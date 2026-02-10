<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use App\Models\Profile;
use App\Models\Package;
use App\Models\Wallet;
use App\Models\Community;
use App\Models\CommunityTeam;
use App\Models\Subscription;
use App\Models\Transaction;
use App\Models\ProfileInterests;
use App\Models\Interests;
use Stripe\Stripe;
use Stripe\Price;
use Stripe\Product;
use Stripe\Checkout\Session;

class SubscriptionController extends Controller
{
    public function getStripePlans($userid)
	{
		
        Stripe::setApiKey(config('services.stripe.secret'));
		$prices = Price::all(['limit' => 10, 'expand' => ['data.product']]);
        $plans = collect($prices->data)->map(function ($price) {
            return [
                'price_id' => $price->id,
                'name' => $price->product->name,
                'amount' => $price->unit_amount / 100,
                'currency' => strtoupper($price->currency),
                'interval' => $price->recurring->interval ?? 'one_time',
            ];
        });
        return view('stripe.plans', compact('plans'));
	}
	
	public function purchase_profile(Request $request, $id)
	{
		session()->forget(['community_join', 'interest_buy', 'subscription_plan']);
		\Stripe\Stripe::setApiKey(env('STRIPE_SECRET'));
		
		$products = \Stripe\Product::all();
		
		$plan = 'Purchase Profile';
		$prices = Price::all(['limit' => 10, 'expand' => ['data.product']]);
		return $basicPlan = collect($prices->data)->first(function ($price) use ($plan) {
			return $price->product->name == $plan;
		});

		// Filter only "profile purchase"
		return $profileProduct = collect($products->data)->first(function ($product) {
			return $product->name === 'Purchase Profile'; // Name exactly match hona chahiye
		});
		
		

		$user = User::find($id);
		$amount = $request->price * 100; // Stripe expects cents
		$interest_ids = $request->interest_id;

		session([
			'interest_buy' => [
				'interest_ids' => $interest_ids,
				'price_amount' => $amount / 100,
				'profile_id' => $id,
			]
		]);

		$profile = Profile::find($id);
		$interests = Interests::whereIn('id', $interest_ids)->get();

		$lineItems = $interests->map(function ($interest) use ($amount) {
			return [
				'price_data' => [
					'currency' => 'usd',
					'product_data' => [
						'name' => $interest->name,
					],
					'unit_amount' => $amount, // Fixed amount per item
				],
				'quantity' => 1,
			];
		})->toArray();

		$session = \Stripe\Checkout\Session::create([
			'payment_method_types' => ['card'],
			'mode' => 'payment',
			'line_items' => $lineItems,
			'metadata' => [
				'profile_id' => $user->id,
				'interest_ids' => implode(',', $interest_ids),
			],
			'success_url' => route('payment.success') . '?session_id={CHECKOUT_SESSION_ID}',
			'cancel_url' => url()->previous(),
			'billing_address_collection' => 'auto',
			'ui_mode' => 'hosted', // Force hosted UI to prevent "Link"
		]);

		return redirect($session->url);
	}
	
	public function interest_buy(Request $request, $id)
	{
		session()->forget(['community_join', 'interest_buy', 'subscription_plan']);
		\Stripe\Stripe::setApiKey(env('STRIPE_SECRET'));

		$user = Profile::find($id);
		$amount = $request->price * 100; // Stripe expects cents
		$interest_ids = $request->interest_id;

		session([
			'interest_buy' => [
				'interest_ids' => $interest_ids,
				'price_amount' => $amount / 100,
				'profile_id' => $id,
			]
		]);

		$profile = Profile::find($id);
		$interests = Interests::whereIn('id', $interest_ids)->get();

		$lineItems = $interests->map(function ($interest) use ($amount) {
			return [
				'price_data' => [
					'currency' => 'usd',
					'product_data' => [
						'name' => $interest->name,
					],
					'unit_amount' => $amount, // Fixed amount per item
				],
				'quantity' => 1,
			];
		})->toArray();

		$session = \Stripe\Checkout\Session::create([
			'payment_method_types' => ['card'],
			'mode' => 'payment',
			'line_items' => $lineItems,
			'metadata' => [
				'profile_id' => $user->id,
				'interest_ids' => implode(',', $interest_ids),
			],
			'success_url' => route('payment.success') . '?session_id={CHECKOUT_SESSION_ID}',
			'cancel_url' => url()->previous(),
			'billing_address_collection' => 'auto',
			'ui_mode' => 'hosted', // Force hosted UI to prevent "Link"
		]);

		return redirect($session->url);
	}
	
	public function community_join(Request $request, $id)
	{
		session()->forget(['community_join', 'interest_buy', 'subscription_plan']);
		\Stripe\Stripe::setApiKey(env('STRIPE_SECRET'));

		$communityteam = CommunityTeam::find($id);
		$community = Community::find($communityteam->community_id);
		$user = Profile::find($request->profile_id);

		$amount = (int) round(floatval($community->joining_cost) * 100); // Stripe expects cents
		$servicecost = $community->joining_cost / 100 * $community->app_service_charges;
		$walletamount = $community->joining_cost - $servicecost;
		
		$profileid = $request->profile_id;
		
		
		
		session([
			'community_join' => [
				'id' => $id,
				'community_id' => $communityteam->community_id,
				'price_amount' => $community->joining_cost ,
				'profile_id' => $profileid,
				'role' => $request->role,
			]
		]);


		// Stripe Checkout Session
		$lineItems = [[
			'price_data' => [
				'currency' => 'usd',
				'product_data' => [
					'name' => $community->title,
				],
				'unit_amount' => $amount,
			],
			'quantity' => 1,
		]];

		$session = \Stripe\Checkout\Session::create([
			'payment_method_types' => ['card'],
			'mode' => 'payment',
			'line_items' => $lineItems,
			'metadata' => [
				'profile_id' => $user->id,
				'community_id' => $communityteam->community_id,
			],
			'success_url' => route('payment.success') . '?session_id={CHECKOUT_SESSION_ID}',
			'cancel_url' => url()->previous(),
			'billing_address_collection' => 'auto',
			'ui_mode' => 'hosted',
			'allow_promotion_codes' => true,
		]);

		// ✅ Wallet Update with Pending Amount
		$wallet = Wallet::where('profile_id', $community->profile_id)->first();
		if ($wallet) {
			$wallet->pending_amount += $walletamount;
			$wallet->amount   += $walletamount;
			$wallet->save();
		} else {
			$wallet = Wallet::create([
				'profile_id' => $community->profile_id,
				'available_amount' => 0,
				'pending_amount' => $walletamount,
				'amount' => $walletamount
			]);
		}

		// ✅ Transaction Record - Pending
		Transaction::create([
			'user_id' => $user->user_id,
			'profile_id' => $community->profile_id,
			'type' => 'credit',
			'status' => 'pending', // pending until refundable period
			'amount' => $walletamount,
			'source' => 'community_join',
			'refundable_until' => now()->addDays(14),
		]);

		return redirect($session->url);
	}


	
	public function withdrawRequest(Request $request)
	{
		\Stripe\Stripe::setApiKey(env('STRIPE_SECRET'));
		$profile = Profile::find($request->profle_id);
		$amount = $request->amount;

		try {
			// Create transfer to user's stripe connect account
			$transfer = \Stripe\Transfer::create([
				'amount' => (int) round($amount * 100), // Convert to cents
				'currency' => 'usd',
				'destination' => $profile->stripe_connect_id,
				'description' => 'Wallet withdrawal',
			]);

			// Deduct from wallet
			$wallet = Wallet::where('profile_id', $community->profile_id)->first();
			$wallet->amount -= $request->amount;
			$wallet->save();
			
			Transaction::create([
				'user_id' => $user->user_id,
				'profile_id' => $request->profile_id,
				'type' => 'withdraw',
				'status' => 'completed',
				'amount' => $request->amount,
			]);

			return back()->with('success', 'Withdrawal successful! Amount transferred to your bank account.');

		} catch (\Exception $e) {
			\Log::error('Withdrawal failed: ' . $e->getMessage());
			return back()->with('error', 'Withdrawal failed: ' . $e->getMessage());
		}
	}

	
	public function subscription_buy(Request $request,$id)
	{
		session()->forget(['community_join', 'interest_buy', 'subscription_plan']);
		Stripe::setApiKey(env('STRIPE_SECRET'));
		$prices = Price::all(['limit' => 10, 'expand' => ['data.product']]);
		$plan = $request->plan;
		$basicPlan = collect($prices->data)->first(function ($price) use ($plan) {
			return strtolower($price->product->name) == strtolower($plan);
		});

		if (!$basicPlan) {
			return response()->json(['error' => $plan.' plan not found'], 404);
		}

		session([
			'subscription_plan' => [
				'package_id' => $request->package_id,   
				'profile_id' => $request->profile_id,// e.g., 'basic'
				'price_id' => $basicPlan->id,      // Stripe price ID
				'price_amount' => $basicPlan->unit_amount / 100,     // Actual price like 4.99
				'user_id' => $id,
			]
		]);
				
		
		$user = User::find($id);

		$session = \Stripe\Checkout\Session::create([
			'payment_method_types' => ['card'],
			'mode' => 'subscription',
			'customer_email' => $user->email, // Payment ties to user email
			'line_items' => [[
				'price' => $basicPlan->id, // your Stripe Basic price ID
				'quantity' => 1,
			]],
			'success_url' => route('payment.success') . '?session_id={CHECKOUT_SESSION_ID}&plan=',
			'cancel_url' => url()->previous(),
		]);

		return redirect($session->url);
	}
	
	public function paymentSuccess(Request $request)
	{
		\Stripe\Stripe::setApiKey(env('STRIPE_SECRET'));

		// Session data
		$communityJoinSession = session('community_join');
		$interestSession = session('interest_buy');
		$packageSession = session('subscription_plan');

		// Shared variables
		$profileId = $communityJoinSession['profile_id'] ?? $interestSession['profile_id'] ?? $packageSession['profile_id'] ?? null;
		$userId = $packageSession['user_id'] ?? null;
		$amount = $communityJoinSession['price_amount'] ?? $packageSession['price_amount'] ?? $interestSession['price_amount'];

		$user = $profileId ? Profile::find($profileId) : null;
		$mainUser = $userId ? User::find($userId) : ($user ? User::find($user->user_id) : null);

		// --- Community Join Payment ---
		if ($communityJoinSession) 
		{
			$communityTeamId = $communityJoinSession['id'];
			$communityId = $communityJoinSession['community_id'];
			$role = $communityJoinSession['role'];

			$community = Community::find($communityId);

			$subscription = Subscription::updateOrCreate(
				[
					'community_id' => $communityId,
					'profile_id' => $profileId
				],
				[
					'user_id' => $user->user_id,
					'type' => 'community join',
					'status' => 'active',
					'name' => $community->title,
					'stripe_id' => $user->stripe_id,
					'stripe_price' => $amount,
				]
			);

			$communityTeam = CommunityTeam::find($communityTeamId);
			$communityTeam->update([
				'status' => 'follow',
				'role' => $role
			]);

			//Transaction::create([
			//	'user_id' => $user->user_id,
			//	'profile_id' => $profileId,
			//	'subscription_id' => $subscription->id,
			//	'type' => 'community join',
			//	'status' => 'active',
			//	'amount' => $amount,
			//]);
		}

		// --- Interest Purchase ---
		if ($interestSession) {
			$interestIds = $interestSession['interest_ids'];

			foreach ($interestIds as $interestId) {
				$interest = Interests::find($interestId);

				$subscription = Subscription::updateOrCreate(
					[
						'interest_id' => $interestId,
						'user_id' => $request->profile_id
					],
					[
						'user_id' => $user->user_id,
						'profile_id' => $profileId,
						'type' => 'interest',
						'status' => 'active',
						'name' => $interest->name,
						'stripe_id' => $user->stripe_id,
						'stripe_price' => $amount,
					]
				);

				ProfileInterests::create([
					'profile_id' => $profileId,
					'interest_id' => $interestId,
				]);

				Transaction::create([
					'user_id' => $user->user_id,
					'profile_id' => $profileId,
					'subscription_id' => $subscription->id,
					'source' => 'interest',
					'status' => 'active',
					'amount' => $amount,
					//'source' => 'community_join',
				]);
			}
		}

		// --- Package Subscription ---
		if ($packageSession) 
		{
			$package = Package::find($packageSession['package_id']);
			$plan = $package->name;

			$mainUser->update([
				'current_plan' => $plan,
				'created_plan' => now(),
				'end_plan' => now()->addDays(30)
			]);

			if ($package->name === 'Purchase-Profile') {
				$profile = Profile::find($profileId);
				$profile->status = 'active';
				$profile->save();
			}

			$subscription = Subscription::updateOrCreate(
				[
					'user_id' => $userId,
					'package_id' => $package->id,
					'profile_id' => $profileId,
				],
				[
					'type' => 'package',
					'stripe_price' => $amount,
					'ends_at' => now()->addDays(30),
					'status' => 'active',
					'stripe_id' => $mainUser->stripe_id,
					'name' => $package->name,
				]
			);

			Transaction::create([
				'user_id' => $userId,
				'profile_id' => $profileId,
				'subscription_id' => $subscription->id,
				'source' => 'package',
				'status' => 'active',
				'amount' => $amount,
			]);
		}

		// ✅ Clear all related session data
		session()->forget(['community_join', 'interest_buy', 'subscription_plan']);

		return view('payment_success');
	}
	
	public function payment_Success()
	{
		return view('account_connect_payment_success');
	}


}
