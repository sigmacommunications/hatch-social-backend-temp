<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\BaseController as BaseController;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\ProductImage;
use Validator;
use App\Models\Community;
use App\Models\CommunityTeam;
use App\Services\FirebaseService;
use App\Notifications\GeneralNotification;
use App\Models\Profile;

class ProductController extends BaseController
{
	
	protected $firebaseService;
	
	public function __construct(FirebaseService $firebaseService)
    {
		$this->firebaseService = $firebaseService;
    }
	
    public function addProduct(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'profile_id' => 'required|integer',
            'community_id' => 'required|integer',
            'title' => 'required|string',
            'product_title' => 'required|string',
            'price' => 'required|numeric',
            //'image' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',
            'link' => 'nullable|string',
            'description' => 'nullable|string',
        ]);

        // Handle file upload
        // $imagePath = null;
        // if ($request->hasFile('image')) {
        //     $imagePath = $request->file('image')->store('products', 'public');
        // }

        if($validator->fails())
        {
            return $this->sendError($validator->errors()->first());
        }

        $product = Product::create([
            'profile_id' => $request->profile_id,
            'community_id' => $request->community_id,
            'title' => $request->title,
            'product_title' => $request->product_title,
            'price' => $request->price,
            // 'image' => $imagePath,
            'link' => $request->link,
            'description' => $request->description,
        ]);
		
		
		$profiles = CommunityTeam::where('community_id',$request->community_id)->whereNot('profile_id',$request->profile_id)->get()->pluck('profile_id');
			foreach($profiles as $key => $profile_id)
			{
					$community = Community::find($request->community_id);
					$user = Profile::find($profile_id);
					$fuser = Profile::find($request->profile_id);

					$body = ' A new product '.$request->product_title . ' is now available in ' . $community->title . ' nest.';
					$title = $fuser->name;
					$fcmToken = $user->device_token;
					$response = $this->firebaseService->sendNotification($fcmToken, $title, $body);

					$user->notify(new GeneralNotification([
						'profile_id' => $user->id,
						'type' => 'community product add',
						'community_id' => $request->community_id,
						'sender_id' => $fuser->id,
						'message' => $body,
					]));
			}

        if($request->hasFile('image')) 
        {
            $uploadedFiles = $request->file('image');
            $profileUrls = [];

            foreach ($uploadedFiles as $file) 
            {
                $imagePath = $file->store('products', 'public');

                ProductImage::create([
                    'product_id' => $product->id,
                    'name' => $imagePath
                ]);
            }
        }
        
        $products = Product::with('images')->find($product->id);
        return response()->json([
            'success' => true,
            'message' => 'Product added successfully',
            'data' => $products,
        ]);
    }

    public function listProducts($id)
    {
        $products = Product::with('images')->where('community_id',$id)->get();
        return response()->json([
            'success' => true,
            'data' => $products,
        ]);
    }
	
	public function updateProduct(Request $request, $id)
	{
		try {
			$validator = Validator::make($request->all(), [
				'profile_id' => 'required|integer',
				'community_id' => 'required|integer',
				'title' => 'required|string',
				'product_title' => 'required|string',
				'price' => 'required|numeric',
				//'image' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',
				'link' => 'nullable|string',
				'description' => 'nullable|string',
			]);

			if ($validator->fails()) {
				return $this->sendError($validator->errors()->first());
			}

			$product = Product::find($id);
			if (!$product) {
				return response()->json(['success' => false, 'message' => 'Product not found'], 404);
			}
			
			//$oldImages = ProductImage::where('product_id', $id)->get();
			//foreach ($oldImages as $image) {
			//	\Storage::disk('public')->delete($image->name); // Delete from storage
			//	$image->delete(); // Delete from database
			//}

			// Handle file upload
			if($request->hasFile('image')) 
			{
				$uploadedFiles = $request->file('image');
				$profileUrls = [];

				foreach ($uploadedFiles as $file) 
				{
					$imagePath = $file->store('products', 'public');

					ProductImage::create([
						'product_id' => $product->id,
						'name' => $imagePath
					]);
				}
			}

			$product->update([
				'profile_id' => $request->profile_id,
				'community_id' => $request->community_id,
				'title' => $request->title,
				'product_title' => $request->product_title,
				'price' => $request->price,
				'link' => $request->link,
				'description' => $request->description,
			]);

			return response()->json([
				'success' => true,
				'message' => 'Product updated successfully',
				'data' => $product,
			]);
		} catch (\Exception $e) {
			return $this->sendError($e->getMessage());
		}
	}
	
	public function deleteProduct($id)
    {
        try {
            $product = Product::find($id);
            if (!$product) {
                return response()->json(['success' => false, 'message' => 'Product not found'], 404);
            }

            // Delete product image from storage
            if ($product->image && file_exists(public_path('storage/' . $product->image))) {
                unlink(public_path('storage/' . $product->image));
            }

            // Delete product record
            $product->delete();

            return response()->json([
                'success' => true,
                'message' => 'Product deleted successfully',
            ]);
        } catch (\Exception $e) {
            return $this->sendError($e->getMessage());
        }
    }
}
