<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\BaseController as BaseController;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use App\Models\Profile;
use App\Models\Package;
use Stripe\Stripe;
use Stripe\Charge;
use Stripe\PaymentIntent;
use App\Models\ProfileInterests;
use App\Models\CommunityInterests;
use App\Models\Community;
use App\Models\CommunityTeam;
use App\Models\CommuinityCheckIn;
use App\Models\CommunityKeywords;
use App\Models\Post;
use App\Models\PostHashtags;
use App\Models\PostImage;
use App\Models\Transaction;
use App\Models\Subscription;
use App\Models\PostLike;
use App\Models\PostVideo;
use App\Models\FeedInterest;
use App\Models\Feed;
use App\Models\FeedPost;
use App\Models\FeedComment;
use App\Models\FeedPostLike;
use App\Models\FeedFollow;
use App\Models\FeedPostImage;
use App\Models\Hashtags;
use App\Models\FeedPostVideo;
use App\Models\Interests;
use App\Models\User;
use Auth;
use BoogieFromZk\AgoraToken\ChatTokenBuilder2;
use Illuminate\Support\Facades\Http;
use BoogieFromZk\AgoraToken\RtcTokenBuilder2;
use BoogieFromZk\AgoraToken\RtmTokenBuilder2;

class ProfileController extends BaseController
{
	
	public function __construct()
    {
		$stripe = \Stripe\Stripe::setApiKey(env('STRIPE_SECRET'));
    }
	
    public function index()
    {
        $userp = Profile::with(['interests','community_list','community_info.interest','notifications' => function($q) {
					$q->whereNull('read_at');
				}])->where('user_id',Auth::user()->id)->get();
        return response()->json(['success'=>true,'message'=>'Profiles Lists','profile_info'=>$userp],200);
    }
    
    public function member_list()
    {
        $userp = User::get();
        return response()->json(['success'=>true,'message'=>'Members Lists','profile_info'=>$userp],200);
    }

    public function login(Request $request)
    {
		//return Auth::user();
		
        $validatorss = Validator::make($request->all(), [
            //'name' => 'required|exists:profiles',
        ]);  
        if($validatorss->fails()){
            return $this->sendError($validatorss->errors()->first(),500);
        }
        $userp = Profile::with('interests','community_list','community_list.community_info')->find($request->id);
		$userp->device_token = $request->device_token;
        $userp->save();
		
		// agora user token start
		$appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
        $expiresInSeconds = 360000000000000; // Token validity (1 hour)
		$accessToken = ChatTokenBuilder2::buildUserToken($appId, $appCertificate,$request->id, $expiresInSeconds);
		
		$rtcToken = RtcTokenBuilder2::buildTokenWithUid($appId, $appCertificate,$userp->name,$request->id,1, $expiresInSeconds);
		$rtmToken = RtmTokenBuilder2::buildToken($appId, $appCertificate,$request->id, $expiresInSeconds);

        // agora user token end
		
		if(!$userp)
        {
            return response()->json(['error' => 'Unauthorised User'], 401);
        }
        if($userp->privacy == 'private')
        {
            // $userp = Profile::where('name',$request->name)->first();
            $validators = Validator::make($request->all(), [
                'passcode' => 'required|exists:profiles',
            ]);  
            if($validators->fails())
            {
				return $this->sendError($validators->errors()->first(),500);
            }
       		
			

            //$userp = Profile::firstWhere('name',$request->name);
			//return $userp->passcode;
            if($userp->passcode == $request->passcode){
                $userp->is_logged_in = 'true';
				$userp->device_token = $request->device_token;
                $userp->save();
$userp['user_info'] = User::withCount('profiles as total_profile')->find(Auth::user()->id);
				//$data['profile_info'] =  $userp;
				//$data['profile_info.agora_user_token'] =  $accessToken;
                return response()->json(['success' => true, 'message' => 'Profile Logged In successfully','rtmtoken'=>$rtmToken, 'profile_info' => $userp ,'agora_user_token' =>$accessToken,'rtctoken' => $rtcToken]);
            } else {
                return response()->json(['error' => 'Unauthorised User'], 401);
            }
        }
        else
        {
            $userp->is_logged_in = 'true';
            $userp->save();

            return response()->json(['success' => true, 'message' => 'Profile Logged In successfully', 'profile_info' => $userp ,'agora_user_token' =>$accessToken,'rtctoken' => $rtcToken,'rtmtoken'=>$rtmToken]);
        }
    }

    public function store(Request $request)
    { 
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|unique:profiles',
            'description' => 'string',
            'type' => 'required',			
            'privacy' => 'required',			
            'photo' => 'image|mimes:jpeg,png,jpg,bmp,gif,svg|max:2048',
        ]);      
        
        if($validator->fails())
        {
            return $this->sendError($validator->errors()->first(),500);
        }
		
        $input = $request->except(['premium'],$request->all());
		if(isset($request->premium))
        {
			//$user = User::find(Auth::id());
            //$amount = 2;
            //$charge = \Stripe\Charge::create([
            //    'amount' => $amount * 100,
            //    'currency' => 'usd',
            //    'customer' => $user->stripe_id,
            //]);
			$input['status'] = 'pending';
        }
		else
		{
			$input['status'] = 'active';
		}
		
        $profilename = null;
        if($request->hasFile('photo')) 
        {
            $file = request()->file('photo');
            $fileName = md5($file->getClientOriginalName() . time()) .'.' . $file->getClientOriginalExtension();
            $file->move('uploads/user/profiles/', $fileName);  
            $profilename = 'uploads/user/profiles/'.$fileName;
        }

        $input['photo'] = $profilename;
		if($request->passcode)
        {
            $input['passcode'] = $input['passcode'];
        }
        $input['user_id'] = Auth::user()->id;
		
        $userp = Profile::create($input);
		
		//agora start
		$appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
		$orgName = env('AGORA_ORG_NAME');   // Your Organization Name
        $appName = env('AGORA_APP_NAME');   // Your Application Name
        
        $expiresInSeconds = 360000000000000; // Token validity (1 hour)
        $agoraUsername = $userp->id; // Username used for user registration above.
        $token = ChatTokenBuilder2::buildAppToken($appId, $appCertificate, $expiresInSeconds); //chat app token
		$accessToken = ChatTokenBuilder2::buildUserToken($appId, $appCertificate,$userp->id, $expiresInSeconds); //chatusertoken
		$rtcToken = RtcTokenBuilder2::buildTokenWithUid($appId, $appCertificate,$userp->name,$userp->id,1, $expiresInSeconds);
		$rtmToken = RtmTokenBuilder2::buildToken($appId, $appCertificate,$userp->id, $expiresInSeconds);
		
        $userId = $userp->id; // User ka unique username
        $appToken = $token; // Agora App Token
        
        // ✅ Agora API URL
        $url = "https://a41.chat.agora.io/{$orgName}/{$appName}/users";

        $headers = [
            'Content-Type' => 'application/json',
            'Accept' => 'application/json',
            'Authorization' => 'Bearer ' . $appToken,
        ];
        $data = [
            "username" => $userId
        ];

        $response = Http::withHeaders($headers)->post($url, $data);
		//end agora
		
		
		$usersp = Profile::with('interests','community_list','community_list.community_info','user_info')
				  ->where(['id' => $userp->id, 'name' => $request->name])->first();
		$usersp['user_infos'] = User::withCount('profiles as total_profile')->find(Auth::user()->id);
		
        return response()->json([
			'success'=>true,
			'message'=>'Profile Create Successfully',
			'profile_info'=>$usersp,
			'agora_user_token' =>$accessToken,
			'rtctoken' => $rtcToken,
			'rtmtoken' => $rtmToken
		]);
    }

    public function search(Request $request)
    {
        $query = $request->input('search');
        // return Auth::user()->id;
        $profile = Profile::find($request->profile_id);
        $users = Profile::where('name', 'like', "%$query%")
                    //->where('type',$profile->type)
                    ->where('id', '!=', $profile->id)
                     ->get();

        return response()->json(['success'=>true,'message'=>'Profile Lists' ,'profile_info'=>$users]);
        // return response()->json(['users' => $users]);
    }

    public function show($id)
    {
        
    }

    public function edit($id)
    {
        
    }

    public function interest(Request $request)
	{
		$profile = Profile::find($request->profile_id);
		if(isset($request->name))
		{
			$profile->interests = $request->name ? json_encode($request->name) : json_encode($profile->interests);
		}
			$profile->save();
		return response()->json(['success' => true, 'message' => 'Interest Selected successfully', 'info' => $profile]);
	}
	
	public function purchase_interest(Request $request)
	{
		// Validate input
		$request->validate([
			'profile_id' => 'required|exists:profiles,id',
			'interest_id' => 'required',
			'price' => 'required|numeric', // Added validation for price
			'stripe_token' => 'required|string',
		]);

		Stripe::setApiKey(env('STRIPE_SECRET'));

		try {
			// Correctly calculate the amount (ensure price is in dollars and multiply by 100 to get cents)
			$amount = $request->price * 100; // Amount in cents

			// Create the charge
			$charge = Charge::create([
				'amount' => $amount, // Amount in cents
				'currency' => 'usd',
				'description' => 'Purchase additional interests',
				'source' => $request->stripe_token, // Token from frontend
				'metadata' => [
					'user_id' => auth()->id(),
					'profile_id' => $request->profile_id,
				],
			]);

			// Save the transaction
			$transaction = Transaction::create([
				'user_id' => auth()->id(),
				'type' => 'interest',
				'profile_id' => $request->profile_id,
				'amount' => $amount / 100, // Store the amount in dollars
				'stripe_transaction_id' => $charge->id, // Transaction ID from Stripe
			]);

			// Save the profile interest
			ProfileInterests::create([
				'profile_id' => $request->profile_id,
				'interest_id' => $request->interest_id,
			]);

			return response()->json(['success' => true, 'message' => 'Interests purchased successfully']);
		} catch (\Exception $e) {
			return response()->json(['success' => false, 'message' => 'Payment failed: ' . $e->getMessage()]);
		}
	}

    
    public function profile_interests($id)
	{
		$profileinterestids = ProfileInterests::where('profile_id', $id)->pluck('interest_id');

		$data['profile_interests'] = Interests::whereIn('id', $profileinterestids)->orderBy('name', 'asc')->get();
		$data['recommend_interests'] = Interests::whereNotIn('id', $profileinterestids)->orderBy('name', 'asc')->get();

		$linkedCommunities = CommunityInterests::whereIn('interest_id', $profileinterestids)
							->whereNot('profile_id', $id)
							->pluck('community_id');

		$recommend_community_ids = CommunityTeam::whereIn('community_id', $linkedCommunities)
									->where('profile_id', '!=', $id)
									->where('role', 'owner')
									->pluck('community_id');
		
		$data['recommend_private_community'] = Community::with(['profile_info','follow' => function($query) use ($id) {
				$query->where('profile_id', $id);
			}])->whereIn('id', $recommend_community_ids)
			->where('privacy', 'yes')
			->where('status', 'active')
			->get();
		$data['recommend_public_community'] = Community::with(['profile_info','follow' => function($query) use ($id) {
				$query->where('profile_id', $id);
			}])->whereIn('id', $recommend_community_ids)
			->where('privacy', 'no')
			->where('status', 'active')
			->get();

		return response()->json(['success' => true, 'message' => 'Interest Lists', 'data' => $data]);
	}
	
	public function recommand_community_by_profile_interests($id,$interestId)
	{
		$profileinterestids = ProfileInterests::where('profile_id', $id)->pluck('interest_id');

		$data['profile_interests'] = Interests::whereIn('id', $profileinterestids)->orderBy('name', 'asc')->get();
		//$data['recommend_interests'] = Interests::fi('id', $interestId)->orderBy('name', 'asc')->get();

		$linkedCommunities = CommunityInterests::where('interest_id', $interestId)
							->whereNot('profile_id', $id)
							->pluck('community_id');

		$recommend_community_ids = CommunityTeam::whereIn('community_id', $linkedCommunities)
									->whereNot('profile_id', $id)
									->pluck('community_id');

		$data['recommend_private_community'] = Community::with(['profile_info','follow' => function($query) use ($id) {
				$query->where('profile_id', $id);
			}])->whereIn('id', $recommend_community_ids)
			->where('privacy', 'yes')
			->where('status', 'active')
			->get();
		
		$ownerCommunities = CommunityInterests::where('interest_id', $interestId)
							->where('profile_id', $id)
							->pluck('community_id');
		$data['owner_community'] = Community::with(['profile_info','follow' => function($query) use ($id) {
				$query->where('profile_id', $id);
			}])->whereIn('id', $ownerCommunities)
			->get();
		$data['recommend_public_community'] = Community::with(['profile_info','follow' => function($query) use ($id) {
				$query->where('profile_id', $id);
			}])->whereIn('id', $recommend_community_ids)
			->where('privacy', 'no')
			->where('status', 'active')
			->get();

		return response()->json(['success' => true, 'message' => 'Interest Lists', 'data' => $data]);
	}


	public function unsubscribe(Request $request)
	{
        $communityinterestid = CommunityInterests::where('profile_id',$request->profile_id)->where('interest_id',$request->interest_id)->get()->pluck('community_id');
		
		if ($communityinterestid->isNotEmpty())
        {
			Community::whereIn('id',$communityinterestid)->delete();
			CommunityTeam::whereIn('community_id',$communityinterestid)->delete();
			CommuinityCheckIn::whereIn('community_id',$communityinterestid)->delete();
			CommunityInterests::whereIn('community_id',$communityinterestid)->delete();
			CommunityKeywords::whereIn('community_id',$communityinterestid)->delete();
			$posts = Post::whereIn('community_id',$communityinterestid)->get();

			foreach($posts as $post)
			{
				PostHashtags::where('post_id')->delete();
				$images = PostImage::where('post_id')->get();
				foreach($images as $image)
				{
					\File::delete('uploads/post/', $image->name);
					$image->delete();
				}
				PostLike::where('post_id')->delete();
				$videos = PostVideo::where('post_id')->get();

				foreach($videos as $video)
				{
					\File::delete('uploads/post/', $video->name);
					$video->delete();
				}
			}
		}

        $feedid = FeedInterest::where('interest_id',$request->interest_id)->get()->pluck('feed_id');
       	if($feedid->isNotEmpty())
		{
			$feeds = Feed::whereIn('id',$feedid)->where('profile_id',$request->profile_id)->get();	
			
			if($feeds->isNotEmpty())
			{
				foreach($feeds as $feed)
				{
					$data = FeedPost::find($feed->id);
					if($data)
					{
						$feedcomment = FeedComment::where('post_id',$feed->id)->get();
						if ($feedcomment->isNotEmpty())
						{
							foreach ($feedcomment as $comment)
							{
								$comment->delete();
							}
						}

						$feedpostlike = FeedPostLike::where('post_id',$feed->id)->get();
						if ($feedpostlike->isNotEmpty())
						{
							foreach ($feedpostlike as $comment)
							{
								$comment->delete();
							}
						}
						$data->delete();
					}

					$FeedFollow = FeedFollow::where('feed_id',$feed->id)->get();
					if ($FeedFollow->isNotEmpty())
					{
						foreach ($FeedFollow as $comment)
						{
							$comment->delete();
						}
					}

					if($data)
					{
						$feedcomment = FeedComment::where('post_id',$feed->id)->get();
						if ($feedcomment->isNotEmpty())
						{
							foreach ($feedcomment as $comment)
							{
								$comment->delete();
							}
						}
						$data->delete();
					}

					$images = FeedPostImage::where('post_id', $feed->id)->get();
					foreach ($images as $image)
					{
						$imagePath = public_path('ploads/feedpost/' . $image->name); // Adjust filename as needed
						if (file_exists($imagePath)) {
							unlink($imagePath);
						}
						$image->delete();
					}

					$hashtags = Hashtags::where('feed_id', $feed->id)->get();
					foreach ($hashtags as $hashtag)
					{
						$hashtag->delete();
					}

					$video = FeedPostVideo::where('post_id', $feed->id)->first();
					if ($video)
					{
						$videoPath = public_path('ploads/feedpost/' . $video->name); // Adjust filename as needed
						if (file_exists($videoPath))
						{
							unlink($videoPath);
						}
						$video->delete();
					}
					$feed->delete();
				}

			}
		}

        $interest = ProfileInterests::where('profile_id',$request->profile_id)->where('interest_id',$request->interest_id)->first();
        $interest->delete();
		return response()->json(['success' => true, 'message' => 'Interest unlike successfully']);
	}
	
    public function subscribe(Request $request)
	{
		$profile = Profile::find($request->id);
		if(isset($request->bubble))
		{
			$profile->bubbles = $request->bubble ? json_encode($request->bubble) : json_encode($profile->bubble);
            foreach($request->bubbles as $row)
            {
                CommunityInterests::create([
                    'community_id' => $request->id,
                    'interest_id' => $row
                ]);
            }
		}
		if(isset($request->interests))
		{
            foreach($request->interests as $row)
            {

        
                ProfileInterests::create([
                    'profile_id' => $request->id,
                    'interest_id' => $row,
                    // 'name' => $row['name'],
                    // 'image' => $row['image'],
                ]);
            }
            // $profile->interests = json_encode($request->interests);
			// $profile->bubbles = $request->bubble ? json_encode($request->bubble) : json_encode($profile->bubble);
		}
		if(isset($request->feed))
		{
			$profile->feed = $request->feed ? json_encode($request->feed) : json_encode($profile->feed);
			$profile->save();
		}
			$profile = Profile::with('interests','community_list','community_list.community_info','user_info')->find($request->id);
		return response()->json(['success' => true, 'message' => 'Bubbles Selected successfully', 'profile_info' => $profile]);
	}

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
            'description' => 'string',
            'privacy' => 'required',			
            'photo' => 'image|mimes:jpeg,png,jpg,bmp,gif,svg|max:2048',
        ]);      
        
        if($validator->fails())
        {
            return $this->sendError($validator->errors()->first(),500);
        }
        
        
        $profilee = Profile::find($id);
        
        if($request->privacy =='private')
        {
            $profilee->passcode = $request->passcode;
        }
        $profilename = $profilee->photo;
        if($request->hasFile('photo')) 
        {
            $file = request()->file('photo');
            $fileName = md5($file->getClientOriginalName() . time()) .'.' . $file->getClientOriginalExtension();
            $file->move('uploads/user/profiles/', $fileName);  
            $profilename = 'uploads/user/profiles/'.$fileName;
        }

        $input = $request->all();
        $input['user_id'] = Auth::user()->id;
        
        $profilee->name = $request->name;
        $profilee->description = $request->description;
		$profilee->address = $request->address;
        $profilee->privacy = $request->privacy;
        $profilee->photo = $profilename;
        $profilee->save();


		$usersp = Profile::with('interests','community_list','community_list.community_info','user_info')->find($id);
		$usersp['user_infos'] = User::withCount('profiles as total_profile')->find(Auth::user()->id);
		
        return response()->json(['success'=>true,'message'=>'Profile Update Successfully' ,'profile_info'=>$usersp]);
    }
    
    
    public function change_passcode(Request $request,$id)
    {
        try{
            $validator = Validator::make($request->all(),[
                'current_passcode' => 'required',
                'new_passcode' => 'required|same:confirm_passcode',
                'confirm_passcode' => 'required',
            ]);
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first());       
            }
            $profile = Profile::find($id);
            if ($request->current_passcode != $profile->passcode) {
                return $this->sendError('Current Passcode is Incorrect');
            }
            $profile->passcode = $request->new_passcode;
            $profile->save();

            $usersp = Profile::with('interests','community_list','community_list.community_info','user_info')->find($id);
		    $usersp['user_infos'] = User::withCount('profiles as total_profile')->find(Auth::user()->id);
            return response()->json(['success'=>true,'message'=>'Password Passcode Changed','profile_info'=>$usersp]);
        }
        catch(\Eception $e){
           return $this->sendError($e->getMessage());    
        }
    }   

    public function destroy($id)
    {
		$user = Profile::find($id);
        $user->delete();
        return response()->json(['success'=>true,'message'=>'Profile Deleted Successfully']);
    }
}
