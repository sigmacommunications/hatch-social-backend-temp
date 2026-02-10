<?php

namespace App\Http\Controllers;

use App\Models\Community;
use App\Models\User;
use Illuminate\Http\Request;
use App\Models\Profile;
use App\Models\Subscription;
use App\Models\Transaction;
use App\Models\Event;
use Carbon\Carbon;
use Stripe\Stripe;
use Stripe\Price;
use Stripe\Product;
use Stripe\Checkout\Session;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Hash;
use Stripe\SetupIntent;

class UsersController extends Controller
{

    public function index(Request $request)
    {
        $users = User::orderBy('id', 'desc')->get();
        $totalUsers = $users->count();
        $activeUsers = $users->where('status', 'active')->count();
        $monthlyRevenue = Transaction::whereYear('created_at', Carbon::now()->year)
            ->whereMonth('created_at', Carbon::now()->month)
            ->sum('amount');
        $upcomingEvents = Event::count();

        return view('admin.users.index', compact('users', 'totalUsers', 'activeUsers', 'monthlyRevenue', 'upcomingEvents'))
            ->with('i', ($request->input('page', 1) - 1) * 10);
    }


    public function profiles(Request $request, $id)
    {
        $users = Profile::where('user_id', $id)->orderBy('id', 'desc')->get();
        return view('admin.users.profile.index', compact('users'))
            ->with('i', ($request->input('page', 1) - 1) * 10);
    }

    public function profileCreate($userid)
    {
        return view('admin.users.profile.create', compact('userid'));
    }

    public function profileStore(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'description' => 'nullable|string',
            'type' => 'required|string|max:255',
            'privacy' => 'required|in:public,private',
            'passcode' => 'required_if:privacy,private|nullable|string|size:4|alpha_num',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
        ]);

        $data = $request->only([
            'user_id',
            'name',
            'email',
            'description',
            'type',
            'privacy',
            'passcode'
        ]);

        // ✅ PUBLIC folder upload
        if ($request->hasFile('photo')) {

            $image = $request->file('photo');
            $fileName = time() . '_' . uniqid() . '.' . $image->getClientOriginalExtension();

            $destinationPath = public_path('uploads/user/profiles');

            // folder create agar exist nahi karta
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $image->move($destinationPath, $fileName);

            // DB path
            $data['photo'] = 'uploads/user/profiles/' . $fileName;
        }

        Profile::create($data);

        return redirect()
            ->route('users.profile.index', $request->user_id)
            ->with('success', 'Profile created successfully.');
    }


    public function profileEdit($id)
    {
        $profile = Profile::findOrFail($id);
        $userid = $profile->user_id; // add this
        return view('admin.users.profile.edit', compact('profile', 'userid'));
    }

    public function profileUpdate(Request $request, $id)
    {
        $profile = Profile::findOrFail($id);

        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'description' => 'nullable|string',
            'type' => 'required|string|max:255',
            'privacy' => 'required|in:public,private',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
        ]);

        $data = $request->only([
            'name',
            'email',
            'description',
            'type',
            'privacy'
        ]);

        // ✅ New image upload (same as store)
        if ($request->hasFile('photo')) {

            // 🔴 Old image delete
            if ($profile->photo && file_exists(public_path($profile->photo))) {
                unlink(public_path($profile->photo));
            }

            $image = $request->file('photo');
            $fileName = time() . '_' . uniqid() . '.' . $image->getClientOriginalExtension();
            $destinationPath = public_path('uploads/user/profiles');

            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }

            $image->move($destinationPath, $fileName);

            $data['photo'] = 'uploads/user/profiles/' . $fileName;
        }

        $profile->update($data);

        return redirect()
            ->route('users.profile.index', $profile->user_id)
            ->with('success', 'Profile updated successfully.');
    }

    public function profileDestroy($id)
    {
        $profile = Profile::findOrFail($id);
        $userId = $profile->user_id;

        // 🔴 Image delete
        if ($profile->photo && file_exists(public_path($profile->photo))) {
            unlink(public_path($profile->photo));
        }

        $profile->delete();

        return redirect()
            ->route('users.profile.index', $userId)
            ->with('success', 'Profile deleted successfully.');
    }

    public function nest(Request $request, $profileid)
    {
        $profile = Profile::find($profileid);
        $users = Community::with(['subscriptions' => function ($q) {
            $q->where('type', 'community join');
        }])
            ->where('profile_id', $profileid)
            ->where('membership_cost', 'yes')
            ->get()
            ->map(function ($community) {
                $subscriptionCount = $community->subscriptions->count();
                $community->total_earn_join_amount = $subscriptionCount * $community->joining_cost;
                $community->client_cut = 100 - $community->app_service_charges;
                $community->hs_cut = $community->app_service_charges;
                $community->hs_revenue = ($community->total_earn_join_amount * $community->app_service_charges) / 100;
                $community->client_revenue = ($community->total_earn_join_amount - $community->hs_revenue);

                //$community->service_charge_amount = ($community->total_earn_join_amount * $community->app_service_charges) / 100;
                return $community;
            });
        //		return $users;
        return view('admin.users.nest.index', compact('users', 'profile'))
            ->with('i', ($request->input('page', 1) - 1) * 10);
    }

    // public function upgrade(Request $request, $id)
    // {
    //     $request->validate([
    //         'amount' => 'required|numeric|min:1',
    //     ]);

    //     $user = Community::findOrFail($id);
    //     $user->app_service_charges = $request->amount;
    //     $user->save();

    //     return response()->json(['success' => true, 'message' => 'Upgrade successful!']);
    // }

    public function upgrade(Request $request, $id)
    {
        $request->validate([
            'amount' => 'required|numeric|min:1',
        ]);

        // ✅ Find the community
        $community = Community::findOrFail($id);
        $community->app_service_charges = $request->amount;
        $community->status = 'active';
        $community->save();

        // ✅ Find the profile who created this community
        $profile = Profile::find($community->profile_id);

        // ✅ Get creator email
        $email = optional($profile->user)->email;

        \Log::info("🚀 upgrade() called for community ID: {$id}");
        \Log::info("🔍 Found profile ID: {$community->profile_id}, email: " . ($email ?? 'none'));

        if ($email) {
            \Log::info("📧 Email function triggered for community ID: {$community->id}, sent to: {$email}");

            Mail::send('emails.upgrade_notification', [
                'community' => $community,
                'profile' => $profile,
                'amount' => $request->amount
            ], function ($message) use ($email, $community) {
                $message->to($email)
                    ->subject("Your community '{$community->title}' has been upgraded!");
                // $message->from(env('MAIL_FROM_ADDRESS_creator'), env('MAIL_FROM_NAME'));
            });
        }

        return response()->json(['success' => true, 'message' => 'Upgrade successful and email sent!']);
    }


    public function create()
    {
        return view('admin.users.create');
    }


    public function store(Request $request)
    {
        $request->validate([
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
            'role' => 'required|in:user,admin',
            'status' => 'required|in:active,inactive',
        ]);

        // Create User
        $user = User::create([
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => $request->role,
            'status' => $request->status,
        ]);

        return redirect()->route('users.index')->with('success', 'User created successfully!');
    }


    public function show(User $user)
    {
        //
    }


    public function edit(User $user)
    {
        return view('users.edit', compact('user'));
    }


    public function update(Request $request, User $user)
    {
        $request->validate([
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'status' => 'required|in:active,inactive',
        ]);

        // Update the user
        $user->update([
            'first_name' => $request->input('first_name'),
            'last_name' => $request->input('last_name'),
            'status' => $request->input('status'),
        ]);

        return redirect()->route('negotiators.list')->with('success', 'User updated successfully');
    }


    public function destroy(User $user)
    {
        $user->delete();
        return redirect()->route('users.index')->with('success', 'User deleted successfully');
    }
}
