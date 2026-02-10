<?php

namespace App\Http\Controllers;

use App\Mail\MonetizationRequestMail;
use App\Models\Community;
use App\Models\Profile;
use App\Models\User;
use App\Models\Wallet;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Stripe\Stripe;
use Carbon\Carbon;
use Stripe\Customer;
use Stripe\PaymentMethod;
use Stripe\Transfer;
use Stripe\Account;
use Stripe\AccountLink;

class ProfileController extends Controller
{

    public function index(User $user = null)
    {
        $user = $user ?? auth()->user();
        abort_unless($user && $user->id === auth()->id(), 403);

        $profiles = Profile::where('user_id', $user->id)->orderBy('id', 'desc')->get();

        return view('admin.profiles.index', [
            'profiles' => $profiles,
            'user' => $user,
        ]);
    }

    /**
     * Show edit form for the authenticated user's first profile.
     */
    public function editSelf()
    {
        $profile = $this->getOrCreateProfileForUser(auth()->user());

        return view('admin.profiles.edit', [
            'profile' => $profile,
            'formAction' => route('admin.profile.update'),
            'formMethod' => 'PUT',
            'title' => 'Edit My Profile',
        ]);
    }

    /**
     * Update the authenticated user's profile.
     */
    public function updateSelf(Request $request)
    {
        $profile = $this->getOrCreateProfileForUser(auth()->user());

        $validated = $this->validateProfile($request);
        $validated['privacy'] = $validated['privacy'] ?? $profile->privacy;
        if ($request->hasFile('photo')) {
            $validated['photo'] = $this->uploadProfilePhoto($request, $profile);
        }

        $profile->update($validated);

        return redirect()->route('admin.profile.edit')->with('success', 'Profile updated successfully.');
    }

    public function create()
    {
        $profile = new Profile([
            'privacy' => 'private',
        ]);

        return view('admin.profiles.create', compact('profile'));
    }


    public function store(Request $request)
    {
        $validated = $this->validateProfile($request);
        $validated['privacy'] = $validated['privacy'] ?? 'private';

        if ($request->hasFile('photo')) {
            $validated['photo'] = $this->uploadProfilePhoto($request);
        }

        $profile = Profile::create(array_merge([
            'user_id' => auth()->id(),
            'type' => auth()->user()->role ?? 'user',
            'status' => 'active',
            'bubble' => 0,
            'privacy' => $validated['privacy'],
        ], $validated));

        return redirect()
            ->route('admin.profiles.index')
            ->with('success', 'Profile created successfully.');
    }


    /**
     * Ensure a profile exists for the given user (creates one if missing).
     */
    protected function getOrCreateProfileForUser(User $user): Profile
    {
        $baseName = trim(($user->first_name ?? '') . ' ' . ($user->last_name ?? ''));
        if ($baseName === '') {
            $baseName = 'User';
        }
        $defaultName = $baseName . ' ' . $user->id;

        return Profile::firstOrCreate(
            ['user_id' => $user->id],
            [
                'name' => $defaultName,
                'type' => $user->role ?? 'user',
                'privacy' => 'private',
                'bubble' => 0,
                'email' => $user->email,
                'status' => 'active',
            ]
        );
    }

    public function profile_wallet($id)
    {
        $wallet = Wallet::where('profile_id', $id)->first();
        $profile = Profile::find($id);
        $withdrawals = Transaction::where('profile_id', $id)
            ->where('type', 'withdraw')
            ->latest()
            ->paginate(10);

        $totalWithdrawn = Transaction::where('profile_id', $id)
            ->where('type', 'withdraw')
            ->sum('amount');

        return view('admin.profiles.wallet', compact(
            'wallet',
            'withdrawals',
            'profile',
            'totalWithdrawn'
        ));
        // return view('admin.chat',$data);
    }

	public function profile_wallet_request(Request $request, $id)
	{
		$request->validate([
			'amount' => 'required|numeric|min:1|decimal:0,2'
		]);

		DB::beginTransaction();

		try {
			$profile = Profile::find($id);

			if (!$profile) {
				return back()->with('error', 'Profile not found.');
			}

			$wallet = Wallet::where('profile_id', $profile->id)->lockForUpdate()->first();

			if (!$wallet) {
				return back()->with('error', 'Wallet not found. Please contact support.');
			}

			// ✅ ONLY AVAILABLE BALANCE CAN BE WITHDRAWN
			if ($wallet->available_amount < $request->amount) {
				return back()->with(
					'error',
					'You can only withdraw available balance. Available: $' .
					number_format($wallet->available_amount, 2)
				);
			}

			// Minimum withdrawal check
			if ($request->amount < 1) {
				return back()->with('error', 'Minimum withdrawal amount is $1.00');
			}

			// Stripe connect check
			if (!$profile->stripe_connect_id) {
				return back()->with('error', 'Stripe account not connected. Please setup payout first.');
			}

			\Stripe\Stripe::setApiKey(env('STRIPE_SECRET'));

			$transferAmount = (int) round($request->amount * 100);

			// 🔹 Stripe Transfer
			$transfer = \Stripe\Transfer::create([
				'amount' => $transferAmount,
				'currency' => 'usd',
				'destination' => $profile->stripe_connect_id,
				'description' => 'Wallet withdrawal from ' . config('app.name'),
				'metadata' => [
					'profile_id' => $profile->id,
					'profile_name' => $profile->name,
					'withdrawal_type' => 'wallet_available'
				]
			]);

			// 🔹 Wallet Update (IMPORTANT)
			$wallet->available_amount -= $request->amount;
			$wallet->total_amount -= $request->amount;
			$wallet->save();

			// 🔹 Transaction Record
			Transaction::create([
				'profile_id' => $profile->id,
				'user_id' => $profile->user_id,
				'amount' => $request->amount,
				'type' => 'withdraw',
				'status' => 'completed',
				'source' => 'available_wallet',
				'reference_id' => $transfer->id
			]);

			DB::commit();

			return back()->with(
				'success',
				'Successfully withdrawn $' . number_format($request->amount, 2) .
				'. Transfer ID: ' . $transfer->id
			);

		} catch (\Stripe\Exception\ApiErrorException $e) {
			DB::rollBack();
			\Log::error('Stripe Error: ' . $e->getMessage());
			return back()->with('error', 'Stripe error: ' . $e->getError()->message);

		} catch (\Exception $e) {
			DB::rollBack();
			\Log::error('Withdrawal failed: ' . $e->getMessage());
			return back()->with('error', 'Withdrawal failed. Please try again.');
		}
	}

	
    public function profile_wallet_requesttt(Request $request, $id)
    {
        $request->validate([
            'amount' => 'required|numeric|min:1|decimal:0,2'
        ]);

        try {
            $profile = Profile::find($id);

            if (!$profile) {
                return back()->with('error', 'Profile not found.');
            }

            $wallet = Wallet::where('profile_id', $profile->id)->first();

            // Check if wallet exists and has sufficient balance
            if (!$wallet) {
                return back()->with('error', 'Wallet not found. Please contact support.');
            }

            if ($wallet->amount < $request->amount) {
                return back()->with('error', 'Insufficient wallet balance. Available: $' . number_format($wallet->amount, 2));
            }

            // Check minimum amount
            if ($request->amount < 1) {
                return back()->with('error', 'Minimum withdrawal amount is $1.00');
            }

            // Check if user has stripe connect account
            if (!$profile->stripe_connect_id) {
                return back()->with('error', 'Stripe account not connected. Please setup payout first.');
            }

            Stripe::setApiKey(env('STRIPE_SECRET'));

            // Create transfer to user's stripe connect account
            $transferAmount = (int) round($request->amount * 100); // Convert to cents

            $transfer = Transfer::create([
                'amount' => $transferAmount,
                'currency' => 'usd',
                'destination' => $profile->stripe_connect_id,
                'description' => 'Wallet withdrawal from ' . config('app.name'),
                'metadata' => [
                    'profile_id' => $profile->id,
                    'profile_name' => $profile->name,
                    'withdrawal_type' => 'wallet'
                ]
            ]);

            // Deduct from wallet
            $wallet->amount -= $request->amount;
            $wallet->save();

            // Save withdrawal record
            Transaction::create([
                'profile_id' => $profile->id,
                'user_id' => $profile->user_id,
                'amount' => $request->amount,
                'type' => 'withdraw',
                'status' => 'completed',
            ]);

            return back()->with(
                'success',
                'Successfully withdrawn $' . number_format($request->amount, 2) .
                ' to your bank account. Transfer ID: ' . $transfer->id
            );

        } catch (\Stripe\Exception\CardException $e) {
            \Log::error('Stripe Card Error: ' . $e->getMessage());
            return back()->with('error', 'Payment failed: ' . $e->getError()->message);

        } catch (\Stripe\Exception\RateLimitException $e) {
            \Log::error('Stripe Rate Limit: ' . $e->getMessage());
            return back()->with('error', 'Too many requests. Please try again later.');

        } catch (\Stripe\Exception\InvalidRequestException $e) {
            \Log::error('Stripe Invalid Request: ' . $e->getMessage());
            return back()->with('error', 'Invalid request: ' . $e->getError()->message);

        } catch (\Stripe\Exception\AuthenticationException $e) {
            \Log::error('Stripe Authentication: ' . $e->getMessage());
            return back()->with('error', 'Authentication error. Please contact support.');

        } catch (\Stripe\Exception\ApiConnectionException $e) {
            \Log::error('Stripe API Connection: ' . $e->getMessage());
            return back()->with('error', 'Network error. Please check your connection.');

        } catch (\Stripe\Exception\ApiErrorException $e) {
            \Log::error('Stripe API Error: ' . $e->getMessage());
            return back()->with('error', 'Stripe error: ' . $e->getError()->message);

        } catch (\Exception $e) {
            \Log::error('Withdrawal failed: ' . $e->getMessage());
            return back()->with('error', 'Withdrawal failed: ' . $e->getMessage());
        }
    }




    public function show($id)
    {
        Stripe::setApiKey(config('services.stripe.secret'));
        $communities = Community::where('profile_id', $id)->get();
        $profile = Profile::find($id);

        if (!empty($profile->stripe_connect_id)) {
            $account = Account::retrieve($profile->stripe_connect_id);

            $account->external_accounts->data;
            if (!$account->details_submitted) {
                if (empty($account->external_accounts->data)) {
                    $accountLink = AccountLink::create([
                        'account' => $account->id,
                        'refresh_url' => url('/user/profile/' . $id), // redirect when user cancels
                        'return_url' => url('/user/profile/' . $id),   // redirect when completed
                        'type' => 'account_onboarding',
                    ]);

                    $profile->stripe_url = $accountLink->url;
                    $profile->save();
                }
            } else {
                $profile->stripe_url = 'complete';
                $profile->save();
            }
        }



        return view('admin.profiles.show', compact('communities', 'profile'));
    }

    public function edit(Profile $profile)
    {
        $this->ensureProfileOwner($profile);

        return view('admin.profiles.edit', [
            'profile' => $profile,
            'formAction' => route('admin.profiles.update', $profile),
            'formMethod' => 'PUT',
            'title' => 'Edit Profile',
        ]);
    }

    public function update(Request $request, Profile $profile)
    {
        $this->ensureProfileOwner($profile);

        $validated = $this->validateProfile($request);
        $validated['privacy'] = $validated['privacy'] ?? $profile->privacy;
        if ($request->hasFile('photo')) {
            $validated['photo'] = $this->uploadProfilePhoto($request, $profile);
        }

        $profile->update($validated);

        return redirect()
            ->route('admin.profiles.index')
            ->with('success', 'Profile updated successfully.');
    }

    public function destroy(Profile $profile)
    {
        $this->ensureProfileOwner($profile);

        $this->deleteProfilePhoto($profile);
        $profile->delete();

        return redirect()
            ->route('admin.profiles.index')
            ->with('success', 'Profile deleted successfully.');
    }

    // public function checkStripeStatus()
    // {
    //     $profile = Profile::where('user_id', Auth::id())->first();

    //     $hasCard = !empty($profile?->stripe_id);

    //     return response()->json(['hasCard' => $hasCard]);
    // }

    // public function saveCard(Request $request)
    // {
    //     // Here you would normally handle the Stripe token sent from frontend
    //     // and create a customer in Stripe, then save stripe_id.

    //     $profile = Profile::where('user_id', Auth::id())->first();
    //     $profile->stripe_id = 'cus_' . uniqid(); // fake stripe ID for demo
    //     $profile->save();

    //     return response()->json(['success' => true, 'message' => 'Card saved successfully!']);
    // }

    // public function saveMembership(Request $request)
    // {
    //     $request->validate([
    //         'membership_cost' => 'required|numeric|min:0',
    //         'joining_cost' => 'required|numeric|min:0',
    //     ]);

    //     // Save to database (update your community table as needed)
    //     // Example:
    //     // Community::find($request->community_id)->update([
    //     //     'membership_cost' => $request->membership_cost,
    //     //     'joining_cost' => $request->joining_cost,
    //     // ]);

    //     return response()->json(['success' => true, 'message' => 'Membership details saved!']);
    // }


    public function checkStatus($profileid)
    {
        $profile = Profile::find($profileid);
        $status = ($profile->stripe_url == 'complete') ? 'complete' : $profile->stripe_url;
        return response()->json(['hasCard' => $status]);
    }

    public function saveCard(Request $request, $id)
    {
        Stripe::setApiKey(config('services.stripe.secret'));

        $user = Auth::user();
        $profile = Profile::find($id);

        try {
            // ✅ Step 1: Create a connected account if not exists
            if (!$profile->stripe_connect_id) {
                $account = Account::create([
                    'type' => 'express',
                    'country' => 'US',
                    'email' => $profile->email,
                    'business_type' => 'individual',
                    'capabilities' => [
                        'transfers' => ['requested' => true],
                        'card_payments' => ['requested' => true],
                    ],
                    'business_profile' => [
                        //'mcc' => '5734', // optional (e.g. computer software)
                        'product_description' => 'User receiving payments through the app',
                    ],
                ]);

                $accountLink = AccountLink::create([
                    'account' => $account->id,
                    'refresh_url' => url('payment-success'), // You can create a route for retrying onboarding
                    'return_url' => url('payment-success'),  // Redirect back after successful onboarding
                    'type' => 'account_onboarding',
                ]);

                // ✅ Save Connected Account ID in profile
                $profile->stripe_connect_id = $account->id;
                $profile->stripe_url = $accountLink->url;
                $profile->save();
            }


            return response()->json([
                'success' => true,
                'url' => $accountLink->url,
                'message' => 'Card saved successfully in connected account!',
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error: ' . $e->getMessage(),
            ], 500);
        }
    }


    public function saveMembership(Request $request)
    {
        $request->validate([
            'community_id' => 'required|exists:community,id',
            'membership_cost' => 'required',
            'joining_cost' => 'required|numeric',
        ]);

        $community = Community::findOrFail($request->community_id);
        $community->membership_cost = $request->membership_cost;
        $community->joining_cost = $request->joining_cost;
        $community->status = 'pending';
        $community->save();

        // ✅ Find all admin users
        $admins = User::where('role', 'admin')->get();

        // ✅ Send email to all admins
        foreach ($admins as $admin) {
            Mail::to($admin->email)->send(new MonetizationRequestMail($community));
        }

        return response()->json([
            'success' => true,
            'message' => 'Membership details saved successfully and notification sent to admin!'
        ]);
    }

    protected function validateProfile(Request $request): array
    {
        return $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'nullable|email|max:255',
            'description' => 'nullable|string',
            'privacy' => 'nullable|string|max:255',
            'address' => 'nullable|string|max:255',
            'photo' => 'nullable|image|max:2048',
        ]);
    }

    protected function uploadProfilePhoto(Request $request, ?Profile $profile = null): string
    {
        if ($profile) {
            $this->deleteProfilePhoto($profile);
        }

        $stored = $request->file('photo')->store('profiles', 'public');
        return 'storage/' . $stored;
    }

    protected function deleteProfilePhoto(?Profile $profile): void
    {
        $oldPath = $profile?->photo;
        $relativeOld = $oldPath && Str::startsWith($oldPath, 'storage/') ? Str::after($oldPath, 'storage/') : $oldPath;
        if ($relativeOld && Storage::disk('public')->exists($relativeOld)) {
            Storage::disk('public')->delete($relativeOld);
        }
    }

    protected function ensureProfileOwner(Profile $profile): void
    {
        abort_unless($profile->user_id === auth()->id(), 403);
    }
}
