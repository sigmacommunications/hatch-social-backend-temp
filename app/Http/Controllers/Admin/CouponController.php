<?php
// app/Http/Controllers/Admin/CouponController.php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Coupon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Stripe\Stripe;
use Stripe\Coupon as StripeCoupon;
use Stripe\Exception\ApiErrorException;

class CouponController extends Controller
{
    public function __construct()
    {
        Stripe::setApiKey(config('services.stripe.secret'));
    }

    public function index($profileid)
    {
        $coupons = Coupon::where('profile_id',$profileid)->paginate(10);
		$stats = [
			'totalCoupons' => Coupon::where('profile_id',$profileid)->count(),
			'activeCoupons' => Coupon::where('profile_id',$profileid)->where('is_active', true)->count(),
			'percentageCoupons' => Coupon::where('profile_id',$profileid)->where('type', 'percentage')->count(),
			'fixedCoupons' => Coupon::where('profile_id',$profileid)->where('type', 'fixed')->count(),
		];

        return view('admin.coupons.index', array_merge(compact('coupons','profileid'), $stats));
    }

    public function create($profileid)
    {
        return view('admin.coupons.create',compact('profileid'));
    }

    public function store(Request $request,$profileid)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'code' => 'required|string|unique:coupons,code',
            'type' => 'required|in:percentage,fixed',
            'value' => 'required|numeric|min:0',
            'max_redemptions' => 'nullable|integer|min:1',
            'valid_from' => 'nullable|date',
            'valid_until' => 'nullable|date|after:valid_from',
        ]);

            // Stripe coupon parameters
            $stripeParams = [
                'name' => $request->name,
                'duration' => 'forever',
            ];

            // Add discount type
            if ($request->type === 'percentage') {
                $stripeParams['percent_off'] = $request->value;
            } else {
                $stripeParams['amount_off'] = $request->value * 100; // Convert to cents
                $stripeParams['currency'] = 'usd';
            }

            // Add max redemptions if provided
            if ($request->max_redemptions) {
                $stripeParams['max_redemptions'] = $request->max_redemptions;
            }

            // Create Stripe coupon
            $stripeCoupon = StripeCoupon::create($stripeParams);

// 1 second delay
sleep(1);

$promotionCode = \Stripe\PromotionCode::create([
    'coupon' => $stripeCoupon->id,
    'code'   => $request->code,
    'max_redemptions' => $request->max_redemptions ?? null,
]);

            // Create local coupon
            $coupon = Coupon::create([
				'profile_id' => $profileid,
                'name' => $request->name,
                'code' => $request->code,
                'stripe_coupon_id' => $stripeCoupon->id,
                'type' => $request->type,
                'value' => $request->value,
                'max_redemptions' => $request->max_redemptions,
                'valid_from' => $request->valid_from,
                'valid_until' => $request->valid_until,
                'is_active' => true,
            ]);

            DB::commit();

            return redirect()->route('admin.coupons.index',$profileid)
                ->with('success', 'Coupon created successfully!');

      
    }

    public function create100PercentCoupon()
    {
        try {
            DB::beginTransaction();

            // Generate unique code
            $code = 'FREE100_' . strtoupper(Str::random(8));

            // Create 100% off coupon in Stripe
            $stripeCoupon = StripeCoupon::create([
                'name' => '100% Free Discount',
                'percent_off' => 100,
                'duration' => 'forever',
                'max_redemptions' => 100, // Optional: limit usage
            ]);

            // Create local coupon
            $coupon = Coupon::create([
                'name' => '100% Free Discount',
                'code' => $code,
                'stripe_coupon_id' => $stripeCoupon->id,
                'type' => 'percentage',
                'value' => 100,
                'max_redemptions' => 100,
                'is_active' => true,
            ]);

            DB::commit();

            return redirect()->route('admin.coupons.index',$profileid)
                ->with('success', '100% Free coupon created successfully! Code: ' . $code);

        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', 'Error creating 100% coupon: ' . $e->getMessage());
        }
    }

    public function edit(Coupon $coupon)
    {
        return view('admin.coupons.edit', compact('coupon'));
    }

    public function update(Request $request, Coupon $coupon)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'is_active' => 'required|boolean',
        ]);

        $coupon->update($request->only('name', 'is_active'));

        return redirect()->route('admin.coupons.index')
            ->with('success', 'Coupon updated successfully!');
    }

    public function destroy(Coupon $coupon)
    {
        try {
            DB::beginTransaction();

            // Delete from Stripe
            if ($coupon->stripe_coupon_id) {
                $stripeCoupon = StripeCoupon::retrieve($coupon->stripe_coupon_id);
                $stripeCoupon->delete();
            }

            // Delete local record
            $coupon->delete();

            DB::commit();

            return redirect()->route('admin.coupons.index')
                ->with('success', 'Coupon deleted successfully!');

        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', 'Error deleting coupon: ' . $e->getMessage());
        }
    }
}