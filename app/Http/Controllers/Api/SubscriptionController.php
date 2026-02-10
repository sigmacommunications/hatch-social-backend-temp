<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Package;
use App\Models\Subscription;
use Stripe\Stripe;
use Stripe\Customer;
use Stripe\PaymentMethod;
use Stripe\Subscription as StripeSubscription;

class SubscriptionController extends Controller
{
	
	public function subscribee(Request $request)
	{
		$user = auth()->user(); // Get the currently logged-in user
		$paymentMethod = $user->stripe_id; // Stripe Payment Method ID

		// Choose the plan
		if ($user->current_plan === 'Basic') {
			$plan = 'price_basic_plan_id'; // Replace with your Basic plan's Stripe price_id
		} else {
			$plan = 'price_premium_plan_id'; // Replace with your Premium plan's Stripe price_id
		}

		// Create the subscription
		$user->newSubscription('default', $plan)->create($paymentMethod);

		return response()->json(['message' => 'Subscription created successfully!']);
	}
	
    public function subscribe(Request $request)
	{

			// Validate the incoming request to ensure payment_method_id is provided
	//request->validate([
	//'package_id' => 'required|exists:package,id',
	//'payment_method_id' => 'required|string',
	//);

		$user = auth()->user();
		$package = Package::findOrFail($request->package_id);

		Stripe::setApiKey(env('STRIPE_SECRET'));
//turn 'a';

        // Create or retrieve customer
        if (!$user->stripe_id) {
            $customer = \Stripe\Customer::create([
                'email' => $user->email,
            ]);
            $user->stripe_id = $customer->id;
            $user->save();
        } 
		else {
            $customer = \Stripe\Customer::retrieve($user->stripe_id);
        }

        // Retrieve and attach the payment method to the customer
        $paymentMethod = \Stripe\PaymentMethod::retrieve('pm_1Q0PsIJvEtkwdCNYMSaVuRz6');

        // Attach the payment method to the customer
        $paymentMethod->attach(['customer' => $customer->id]);

        // Set the payment method as default for invoices
        $customer->invoice_settings = [
            'default_payment_method' => $paymentMethod->id,
        ];
		
        $customer->save();

        // Create the Stripe product
        $stripeProduct = \Stripe\Product::create([
            'name' => $package->name,
        ]);

        // Create the Stripe price for this product, with type=recurring
        $stripePrice = \Stripe\Price::create([
            'unit_amount' => $package->price * 100, // Convert to cents
            'currency' => env('STRIPE_CURRENCY'),
            'product' => $stripeProduct->id,  // Use the product ID
            'recurring' => [
                'interval' => 'month', // or 'year', depending on your package
            ],
        ]);

        // Create Stripe Subscription
        $stripeSubscription = \Stripe\Subscription::create([
            'customer' => $customer->id,
            'items' => [[
                'price' => $stripePrice->id,  // Use the price ID
            ]],
            'expand' => ['latest_invoice.payment_intent'],
        ]);

        // Save subscription to the database
        $subscription = Subscription::create([
            'user_id' => $user->id,
            'package_id' => $package->id,
            'stripe_id' => $stripeSubscription->id,
            'status' => 'active',
        ]);

        return response()->json(['message' => 'Subscription successful!', 'subscription' => $subscription]);
   }

}
