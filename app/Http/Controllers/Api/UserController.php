<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Api\BaseController as BaseController;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Package;
use App\Models\Interests;
use App\Models\Transaction;
use App\Models\ProfileInterests;
use App\Models\Subscription;
use App\Models\Notification;
use Image;
use File;
use Auth;
use Validator;
use Stripe\PaymentMethod;

class UserController extends BaseController
{
	public function __construct()
    {
		$stripe = \Stripe\Stripe::setApiKey(env('STRIPE_SECRET'));
    }
	
	public function update_account(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'first_name' => 'required|string',
			'last_name' => 'required|string',
            'address' => 'required',
            'currency' => 'required',			
        ]);      
        
        if($validator->fails())
        {
            return $this->sendError($validator->errors()->first(),500);
        }
        
        
        
		$user = User::find(Auth::id());
        
        $user->first_name = $request->first_name;
		$user->last_name = $request->last_name;
        $user->address = $request->address;
        $user->currency = $request->currency;
        $user->save();
		
        return response()->json(['success'=>true,'message'=>'User Update Successfully' ,'user_info'=>$user]);
    }

	public function un_reead_notification()
	{
		$notification = Auth::user()->unreadNotifications;
		$notificationold = Auth::user()->readNotifications;
		$unread = count(Auth::user()->unreadNotifications); 
		$read = count(Auth::user()->readNotifications); 
		// return $notification[0]->data['title']; 
		$data = null;
		if($notification)
		{
			foreach($notification as $row)
			{
				$data[] = [
					'id' => $row->id,
					'title' => $row->data['title'],
					'description' => $row->data['description'],
					'created_at' => $row->data['time'],
					'status' => 'unread'
				];
				// $data[] = $row->data;
			}
		}
			
		$olddata = null;
		if($notificationold){

			foreach($notificationold as $row)
			{
				$data[] = [
					'id' => $row->id,
					'title' => $row->data['title'],
					'description' => $row->data['description'],
					'read_at' => $row->data['time'],
					'status' => 'read'
				];
			}
		}
		return response()->json(['success'=>true,'unread'=> $unread,'read'=> $read,'notification' => $data]);
	}
	
	
	public function read_notification(Request $request)
	{
		try{
			$validator = Validator::make($request->all(),[
				'notification_id' => 'required',
			]);
			if($validator->fails())
			{

				return response()->json(['success'=>false,'message'=> $validator->errors()->first()]);
			}

			$notification= Notification::find($request->notification_id);
			if($notification){
				$notification->read_at = date(now());
				$notification->save();
				$status= $notification;
				if($status)
				{
					return response()->json(['success'=>true,'message'=> 'Notification successfully deleted']);
				}
				else
				{
					return response()->json(['success'=>false,'message'=> 'Error please try again']);
				}
			}
			else
			{
				return response()->json(['success'=>false,'message'=> 'Notification not found']);
			}
		}
		catch(\Eception $e)
		{
			return response()->json(['error'=>$e->getMessage()]);
	   	}
	}

    public function profile(Request $request)
    {
        try{
			$olduser = User::with(['child','goal','temporary_wallet','wallet','payments'])->where('id',Auth::user()->id)->first();
			$child = Child::where('user_id',Auth::user()->id)->first();
			$validator = Validator::make($request->all(),[
				'first_name' =>'string',
				'last_name' =>'string',
				'child_name' => 'string',
				'child_age' => 'string',
				'child_gander' => 'string',
				'passcode' => 'numeric',
				'child_image' =>'string',
				'phone' =>'numeric',
				'email' => 'email|unique:users,email,'.$olduser->id,
				'country'=>'string',
				'photo' => 'image|mimes:jpeg,png,jpg,bmp,gif,svg|max:2048',
			]);
			if($validator->fails())
			{
				return $this->sendError($validator->errors()->first());
	
			}
			$profile = $olduser->photo;
			$child_image = $olduser->child_image;

			if($request->hasFile('child_image')) 
			{
				$file1 = request()->file('child_image');
				$fileName1 = md5($file1->getClientOriginalName() . time()) . "child_image." . $file1->getClientOriginalExtension();
				$file1->move('uploads/user/profiles/', $fileName1);  
				$child_image = 'uploads/user/profiles/'.$fileName1;
			}
			
			if($request->hasFile('photo')) 
			{
				$file = request()->file('photo');
				$fileName = md5($file->getClientOriginalName() . time()) . "PayMefirst." . $file->getClientOriginalExtension();
				$file->move('uploads/user/profiles/', $fileName);  
				$profile = 'uploads/user/profiles/'.$fileName;
			}
			$olduser->first_name = $request->first_name;
			$olduser->last_name = $request->last_name;
			//$olduser->email = $request->email;
			$olduser->rush_service = $request->rush_service;
			$olduser->holiday_mode = $request->holiday_mode;
			$olduser->travel_mode = $request->travel_mode;
			$olduser->photo = $profile;
			$olduser->save();

			$child->update([
				'name' => $request->child_name,
				'age' => $request->child_age,
				'gander' => $request->child_gander,
				'image' => $child_image,
			]);

			$user = User::with(['child','goal','temporary_wallet','wallet','payments'])->where('id',Auth::user()->id)->first();

			return response()->json(['success'=>true,'message'=>'Profile Updated Successfully','user_info'=>$user]);
		}
		catch(\Eception $e)
		{
			return $this->sendError($e->getMessage());
		}        
   
    }
	
	public function subscription(Request $request)
	{
        $validator = Validator::make($request->all(), [
            'package_id' => 'required|exists:package,id',
        ]);
        if($validator->fails()){
            return $this->sendError($validator->errors()->first(),500);
        }
		$package = Package::find($request->package_id);
		$user = User::find(Auth::user()->id);

        // $amount = 100;
		// $charge = \Stripe\Charge::create([
		// 	'amount' => $amount,
		// 	'currency' => 'usd',
		// 	'customer' => $user->stripe_id,
		// ]);

        $user->update(['current_plan' =>$package->name,'created_plan'=> \Carbon\Carbon::now()]);
		return response()->json(['success'=>true,'message'=>'Subscription Buy Successfully','user_info'=>$user]);
    }
	
	public function current_plan(Request $request)
	{
		try
		{
		    //$user= User::findOrFail(Auth::id());
            $user = User::find(Auth::user()->id);
            $package = Package::find($request->package_id);

            $amount = $package->price;
            //$charge = \Stripe\Charge::create([
            //    'amount' => $amount * 100,
            //    'currency' => 'usd',
            //    'customer' => $user->stripe_id,
            //]);

            $user->update(['current_plan' =>$package->name,'created_plan'=> \Carbon\Carbon::now(),'end_plan'=> \Carbon\Carbon::now()->addDays(30)]);
			$subscription = Subscription::where('package_id',$request->package_id)->where('user_id',Auth::id())->first();
			if($subscription)
            {
                $subscription->update([
                    'type' => 'package',
                    'status' => 'active',
                    'name' => $package->name,
                    'stripe_id' => $user->stripe_id,
                    'stripe_price' => $package->price,
                ]);
            }
            else
            {
               	$subscription = Subscription::create([
                    'user_id' => Auth::id(),
                    'package_id' => $request->package_id,
                    'type' => 'package',
                    'status' => 'active',
                    'name' => $package->name,
                    'stripe_id' => $user->stripe_id,
                    'stripe_price' => $package->price,
                ]);
            }
			
			Transaction::create([
				'user_id' => Auth::id(),
				'profile_id' => $request->profile_id,
				'subscription_id' => $subscription->id,
				'type' => 'package',
				'status' => 'active',
				'amount' => $amount,
			]);
            return response()->json(['success'=>true,'message'=>'Current Plan Updated Successfully','user_info'=>$user,'payment' => $subscription]);
		}
		catch(\Exception $e){
	  		return $this->sendError($e->getMessage());
		}
	}
	
	
	public function interest_buy(Request $request)
	{
		try
        {
		    //$user= User::findOrFail(Auth::id());
            $user = User::find(Auth::user()->id);
			$amount = $request->price;
			foreach($request->interest_id as $interestid)
			{
				$interest = Interests::find($interestid);

				$subscription = Subscription::where('interest_id',$interestid)->where('user_id',$request->profile_id)->first();
				if($subscription)
				{
					$subscription->update([
						'type' => 'interest',
						'status' => 'active',
						'name' => $interest->name,
						'stripe_id' => $user->stripe_id,
						'stripe_price' => $amount,
					]);
				}
				else
				{
				$subscription = Subscription::create([
						'user_id' => Auth::id(),
						'profile_id' => $request->profile_id,
						'interest_id' => $interestid,
						'type' => 'interest',
						'status' => 'active',
						'name' => $interest->name,
						'stripe_id' => $user->stripe_id,
						'stripe_price' => $amount,
					]);
				}

				ProfileInterests::create([
					'profile_id' => $request->profile_id,
					'interest_id' => $interestid,
					// 'name' => $row['name'],
					// 'image' => $row['image'],
				]);

				Transaction::create([
					'user_id' => Auth::id(),
					'profile_id' => $request->profile_id,
					'subscription_id' => $subscription->id,
					'type' => 'package',
					'status' => 'active',
					'amount' => $amount,
				]);
				
			}
			
			//$charge = \Stripe\Charge::create([
			//	'amount' => $amount * 100,
			//	'currency' => 'usd',
			//	'customer' => $user->stripe_id,
			//]);


            //$user->update(['current_plan' =>$package->name,'created_plan'=> \Carbon\Carbon::now()]);
            
            return response()->json(['success'=>true,'message'=>'Interest Buy Successfully','user_info'=>$user]);
		}
		catch(\Exception $e)
        {
	        return $this->sendError($e->getMessage());
		}
	}
	
}
