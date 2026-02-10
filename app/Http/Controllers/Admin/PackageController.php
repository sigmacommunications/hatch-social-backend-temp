<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Stripe\Stripe;
use Stripe\Price;
use Stripe\Product;
use App\Models\Package;

class PackageController extends Controller
{
    public function __construct()
    {
        Stripe::setApiKey(env('STRIPE_SECRET'));
    }

    // List Subscriptions
    public function index()
    {
        $packages = Package::all();
        return view('admin.package.index', compact('packages'));
    }

    // Create Subscription View
    public function create()
    {
        return view('admin.package.create');
    }

    // Store Subscription in Stripe and Database
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric',
            'description' => 'nullable|string',
        ]);

        // Create Stripe Product
        $product = Product::create([
            'name' => $request->name,
            'description' => $request->description,
        ]);

        // Create Stripe Price
        $price = Price::create([
            'unit_amount' => $request->price * 100, // Stripe uses cents
            'currency' => 'usd',
            'recurring' => ['interval' => 'month'],
            'product' => $product->id,
        ]);

        // Save to DB
        Package::create([
            'name' => $request->name,
            'stripe_plan_id' => $price->id,
            'price' => $request->price,
            'description' => $request->description,
        ]);

        return redirect()->route('package.index')->with('success', 'Package created successfully!');
    }

    // Edit Subscription View
    public function edit($id)
    {
        $package = Package::findOrFail($id);
        return view('admin.package.create', compact('package'));
    }

    // Update Subscription
    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric',
            'description' => 'nullable|string',
        ]);

        $package = Package::findOrFail($id);
        
        // Check if price has changed
        if ($package->price != $request->price) {
            try {
                // Archive/delete old Stripe product and price
                $oldPriceId = $package->stripe_plan_id;
                
                // First retrieve the old price to get product ID
                $oldPrice = Price::retrieve($oldPriceId);
                $oldProductId = $oldPrice->product;
                
                // Archive the old product (set as inactive)
                Product::update($oldProductId, [
                    'active' => false,
                ]);
                
                // Archive the old price
                Price::update($oldPriceId, [
                    'active' => false,
                ]);
                
                // Create COMPLETELY NEW Stripe Product
                $newProduct = Product::create([
                    'name' => $request->name,
                    'description' => $request->description ?? '',
                    'active' => true,
                ]);

                // Create new Stripe Price
                $newPrice = Price::create([
                    'unit_amount' => $request->price * 100,
                    'currency' => 'usd',
                    'recurring' => ['interval' => 'month'],
                    'product' => $newProduct->id,
                    'active' => true,
                ]);

                // Update package with new IDs
                $package->update([
                    'name' => $request->name,
                    'stripe_plan_id' => $newPrice->id,
                    'price' => $request->price,
                    'description' => $request->description,
                ]);
                
            } catch (\Exception $e) {
                // If Stripe operations fail, still update database
                $package->update([
                    'name' => $request->name,
                    'price' => $request->price,
                    'description' => $request->description,
                ]);
                
                \Log::error('Stripe product recreation failed: ' . $e->getMessage());
                
                return redirect()->route('package.index')
                    ->with('warning', 'Package updated locally but Stripe sync failed. Old product may still exist.');
            }
            
            return redirect()->route('package.index')
                ->with('success', 'Package updated successfully! Old product archived and new product created in Stripe.');
                
        } else {
            // Price hasn't changed, just update product info
            try {
                // Update existing Stripe product info
                $oldPrice = Price::retrieve($package->stripe_plan_id);
                $productId = $oldPrice->product;
                
                Product::update($productId, [
                    'name' => $request->name,
                    'description' => $request->description ?? '',
                ]);
                
            } catch (\Exception $e) {
                \Log::error('Stripe product update failed: ' . $e->getMessage());
            }
            
            // Update package in database
            $package->update([
                'name' => $request->name,
                'description' => $request->description,
            ]);
            
            return redirect()->route('package.index')
                ->with('success', 'Package information updated successfully!');
        }
    }

    // Delete Subscription
    public function destroy($id)
    {
        $package = Package::findOrFail($id);
        
        try {
            // Archive in Stripe (safer for existing subscriptions)
            if ($package->stripe_plan_id) {
                try {
                    $price = Price::retrieve($package->stripe_plan_id);
                    $productId = $price->product;
                    
                    // Deactivate price (won't be available for new subscriptions)
                    Price::update($package->stripe_plan_id, [
                        'active' => false,
                    ]);
                    
                    // Deactivate product
                    Product::update($productId, [
                        'active' => false,
                    ]);
                    
                } catch (\Exception $e) {
                    \Log::warning('Stripe archive failed: ' . $e->getMessage());
                }
            }
            
            // Delete from database
            $package->delete();
            
            return redirect()->route('package.index')
                ->with('success', 'Package archived successfully!');
                
        } catch (\Exception $e) {
            return redirect()->route('package.index')
                ->with('error', 'Error: ' . $e->getMessage());
        }
    }
}
