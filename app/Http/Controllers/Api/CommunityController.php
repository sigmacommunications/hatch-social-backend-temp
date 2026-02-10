<?php

namespace App\Http\Controllers\Api;
use App\Http\Controllers\Api\BaseController as BaseController;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use App\Models\Community;
use App\Models\PostHashtags;
use App\Models\CommunityTeam;
use App\Models\User;
use App\Models\Transaction;
use App\Models\Subscription;
use App\Mail\MonetizationRequestMail;
use App\Mail\PaymentCommunityJoinMail;
use App\Models\Interests;
use App\Models\FeedInterest;
use App\Models\Profile;
use App\Models\Feed;
use App\Models\Post;
use App\Models\ChatRoom;
use App\Models\CommunityInterests;
use App\Models\ProfileInterests;
use App\Models\CommunityKeywords;
use App\Models\CommuinityCheckIn;
use Auth;
use Mail;
use DB;
use BoogieFromZk\AgoraToken\ChatTokenBuilder2;
use Illuminate\Support\Facades\Http;
use App\Notifications\GeneralNotification;
use App\Services\FirebaseService;

class CommunityController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
	protected $firebaseService;
	
	public function __construct(FirebaseService $firebaseService)
    {
		$stripe = \Stripe\Stripe::setApiKey(env('STRIPE_SECRET'));
		$this->firebaseService = $firebaseService;
    }
	
	public function payment_mail(Request $request)
	{
		$user = Profile::find($request->profile_id);
		$community = Community::find($request->community_id);
		$comdata = [
			'id' => $request->community_team_id,
			'price' => $community->joining_cost,
			'profile_id' => $user->id
		];
		Mail::to($user->email)->send(new PaymentCommunityJoinMail($comdata));
		return $this->sendResponse($comdata,'Mail Successfully Send');  
		
	}
	public function community_by_roles(Request $request, $id)
	{
		$profileId = $request->profile_id;
		$profile = User::find(Auth::id());

		$currentPlan = strtolower($profile->current_plan);
		$limits = [
			'basic' => ['member' => 9, 'owner' => 1],
			'premium' => ['member' => 8, 'owner' => 2],
		];
		$activeLimits = $limits[$currentPlan] ?? ['member' => 8, 'owner' => 2];

		$data = [];

		$rolesConfig = [
			'member' => ['limit' => $activeLimits['member'], 'color' => '#ffb100'],
			'owner'  => ['limit' => $activeLimits['owner'], 'color' => '#ff9404'],
		];

		foreach ($rolesConfig as $role => $config) {
			$communityIds = CommunityTeam::where('profile_id', $profileId)
				->where('role', $role)
				->pluck('community_id');

			$interestIds = CommunityInterests::whereIn('community_id', $communityIds)
				->where('interest_id', $id)
				->pluck('community_id');

			$communities = Community::select(['id','title','membership_cost','privacy','joining_cost','image'])
				->whereIn('id', $interestIds)
				->limit($config['limit'])
				->get()
				->map(function ($c) use ($role, $config) {
					$c->role = $role;
					$c->color = $config['color'];
					return $c;
				});

			$data[$role] = $communities->isEmpty() ? [
				'info' => null,
				'role' => $role,
				'color' => $config['color']
			] : $communities;
		}

		// --- ADMIN + MODERATOR COMBINED ---
		$team = CommunityTeam::where('profile_id', $profileId)
			->whereIn('role', ['admin', 'moderator'])
			->get(['community_id', 'role']);

		$map = $team->pluck('role', 'community_id');

		$interestIds = CommunityInterests::whereIn('community_id', $map->keys())
			->where('interest_id', $id)
			->pluck('community_id');

		$communities = Community::select(['id','title','membership_cost','privacy','joining_cost','image'])
			->whereIn('id', $interestIds)
			->limit(2)
			->get()
			->map(function ($c) use ($map) {
				$c->role = $map[$c->id] ?? null;
				$c->color = '#ffb40c';
				return $c;
			});

		$data['admin_moderator'] = $communities->isEmpty() ? [
			'info' => null,
			'role' => 'admin_moderator',
			'color' => '#ffb40c'
		] : $communities;

		return $this->sendResponse($data,'Community List');    
	}





	private function getRoleColor($role)
	{
		return match($role) {
			'member' => '#ffefcc',
			'moderator' => '#d0f0fd',
			'admin' => '#fce4ec',
			'owner' => '#e8f5e9',
			default => '#ffffff',
		};
	}
	
    public function community_out(Request $request , $id)
    {
        try
        {
            $currenttime = \Carbon\Carbon::now();

            $timein = CommuinityCheckIn::where('profile_id',$request->profile_id)->where('community_id',$id)->first();
            // $timein->timeout = $mytime->toDateTimeString(),

            $startDateTime = $timein->time_in;
            $endDateTime = $currenttime->toDateTimeString();

            // Parse the date-time strings into Carbon instances
            $start = \Carbon\Carbon::parse($startDateTime);
            $end = \Carbon\Carbon::parse($endDateTime);
            
            $totalMinutes = $start->diffInMinutes($end);
            $timein->time_in = null;
            $timein->total_min =  $timein->total_min + $totalMinutes;
            $timein->save();
        }
        catch(\Eception $e)
        {
            return $this->sendError($e->getMessage());    
        }
    }
    public function home_multi_community($id)
    {
        try
        { 
            $communityt = CommuinityCheckIn::where('profile_id',$id)->orderBy('total_min', 'desc')->select('community_id')->pluck('community_id'); // Use pluck to get an array of community IDs
            $communityst = Community::with(['follow' => function($query) use ($id) {
                $query->where('profile_id', $id);  // Only include 'follow' where profile_id matches the request
            },'interest'])->whereIn('id',$communityt)->get();
            $communityst->each(function ($community) {
                $community->type = 'spend time';
            });

            
            // $matchingCommunities = array_merge($communityso->toArray(),$communitysa->toArray(),$communitysm->toArray(),$communityst->toArray());

            return $this->sendResponse('Community List', $communityst);    
            // return $this->sendResponse('Community List', $matchingCommunities);    
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }
    public function indexx(Request $request,$id)
    {
        try{
			$profileInterests =	ProfileInterests::with('interests')->where('profile_id',$id)->get()->pluck('interest_id');
            if($profileInterests == [])
            {
                
                return response()->json(['success'=>true,'message'=>'Community Lists', 'data' => $profileInterests],200);
            }
            else
            {
               
			
			 $matchingCommunities = DB::table('community_interests')
				->select('community_id')
				->whereIn('interest_id', $profileInterests)
				->groupBy('community_id')
				->get();

                if($matchingCommunities == [])
                {
                    return response()->json(['success'=>true,'message'=>'Community Lists', 'data' => $profileInterests],200);
                }
                else
                {
        			$communitiesd = Community::with(['detail','follow' => function ($query) use ($id) {
                		$query->where('profile_id', $id);
            		}, 'community_owner'])
        				->whereIn('id', $matchingCommunities->pluck('community_id'))
        				->orwhere('profile_id', $id)
        				->get();
                    return response()->json(['success'=>true,'message'=>'Community Lists', 'data' => $communitiesd],200);
                }
            return response()->json(['success'=>true,'message'=>'Community Lists', 'data' => $matchingCommunities],200);    
            }
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }
    
    public function community_interest(Request $request,$id)
    {
        try
        {
            // return $request->profile_id;
            $profileId = $request->profile_id;
			
			// Communties Interest By Interest ID 
			$matchingCommunitiess = CommunityInterests::where('interest_id', $id)->select('community_id')
				->groupBy('community_id')
				->get();
			
            // Communties By $matchingCommunities ID
    		$data['community_list_by_interest'] = Community::with(['follow' => function ($query) use ($profileId) {
        		$query->where('profile_id', $profileId);
    		}, 'community_owner'])
			->whereIn('id', $matchingCommunitiess->pluck('community_id'))
			->get();
			
            // Communties Interest By Interest ID & Profile id
			$matchingCommunities = CommunityInterests::where('interest_id', $id)->where('profile_id', $profileId)->select('community_id')
				->groupBy('community_id')
				->get();
			

            // Communties By $matchingCommunities ID
    		$data['community_list'] = Community::with(['follow' => function ($query) use ($profileId) {
        		$query->where('profile_id', $profileId);
    		}, 'community_owner'])
			->whereIn('id', $matchingCommunities->pluck('community_id'))
			//->orwhere('profile_id', $profileId)
			->get();
        		
            // Feed Interest By Interest ID
			$matchingFeeds = FeedInterest::where('interest_id', $id)->select('feed_id')
			->groupBy('feed_id')
			->get();
			
            // Feed By $matchingFeeds ID
			$data['feeds_list'] = Feed::with('profile_info','hashtags','posts','posts.total_likes','posts.comments','posts.comments.profile_info','posts.post_images','posts.post_videos','posts.profile_info','follow')
			        ->whereIn('id',$matchingFeeds->pluck('feed_id'))
                    ->where('profile_id',$profileId)
			        ->get();

            // Communities By Role Member on profile ID
 			$popular_community = CommunityTeam::with('community_info')->where('profile_id',$request->profile_id)->where('role','member')->get()->pluck('community_id');
			$matchingCommunitieswithoutprofileid = CommunityInterests::where('interest_id', $id)->select('community_id')
				->groupBy('community_id')
				->get();
            $data['popular_community'] = Community::with(['follow' => function ($query) use ($profileId) {
            		$query->where('profile_id', $profileId);
        		}, 'community_owner'])
                ->whereIn('id',$matchingCommunitieswithoutprofileid->pluck('community_id'))
				//->orwhereIn('id', $popular_community)
    			//->where('profile_id', $profileId)
    			->get();
            return response()->json(['success'=>true,'message'=>'Lists' ,'data'=>$data]);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
        
        // $userp = Community::where('profile_id',$id)->get();
        // return response()->json(['success'=>true,'message'=>'Community Lists','community_info'=>$userp]);
    }

    public function community_member_my_pending_list($id)
    {
        try{
            $bubble = CommunityTeam::with('invite_profile_info','community_list','community_list.interest')->where('profile_id',$id)->whereNot('status','follow')->whereNot('status','payment hold')->get();
            return response()->json(['success'=>true,'message'=>'Lists' ,'member_info'=>$bubble]);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }

    public function community_member_pending_list($id)
    {
        try{
            $bubble = CommunityTeam::with('profile_info','community_list')->where('community_id',$id)->get();
            return response()->json(['success'=>true,'message'=>'Lists' ,'member_info'=>$bubble]);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }
    
    public function community_member_list($id)
    {
        try{
            // $bubble = CommunityTeam::with('profile_info','community_info')->where('community_id',$id)->where('status','follow')->get();
            $bubble = CommunityTeam::with('profile_info','community_list')->where('community_id',$id)->get();
            return response()->json(['success'=>true,'message'=>'Lists' ,'member_info'=>$bubble]);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }
    
    public function community_member_pending_update(Request $request,$id)
    {
        try
        {
			$bubble = CommunityTeam::find($id);
			
			$user = Profile::find($bubble->profile_id);
			$fuser = Profile::find($request->invite_profile_id);
			$community = Community::find($bubble->community_id);
			$invite = $request->invite;
			
			if($invite)
			{
				$body = $fuser->name .' invite you to become  ' .$request->status. ' of nest ' . $community->title;
				$title = $fuser->name;
				$fcmToken = $user->device_token;
				$response = $this->firebaseService->sendNotification($fcmToken, $title, $body);
			}


			if($request->status == 'admin')
            {
                $bubble = CommunityTeam::find($id);
				if($request->status_type == 'change')
				{
					$bubble->invite_role = 'admin';
					$bubble->status = 'pending';
				}
				else
				{
					$bubble->role = 'admin';
				}
				
				$bubble->save();
                return response()->json(['success'=>true,'message'=>'Role Assign Sucessfully','community_detail'=>$bubble]);
            }
			
			if($request->status == 'moderator')
            {
                $bubble = CommunityTeam::find($id);
                if($request->status_type == 'change')
				{
					$bubble->invite_role = 'moderator';
					$bubble->status = 'pending';
				}
				else
				{
					$bubble->role = 'moderator';
				}
				$bubble->save();
                return response()->json(['success'=>true,'message'=>'Role Assign Sucessfully','community_detail'=>$bubble]);
            }
			
			if($request->status == 'team')
            {
                $bubble = CommunityTeam::find($id);
                $bubble->role = 'team';
				$bubble->save();
                return response()->json(['success'=>true,'message'=>'Role Assign Sucessfully','community_detail'=>$bubble]);
            }
			
			if($request->status == 'member')
            {
                $bubble = CommunityTeam::find($id);
                $bubble->role = 'member';
				$bubble->save();
                return response()->json(['success'=>true,'message'=>'Role Assign Sucessfully','community_detail'=>$bubble]);
            }
            if($request->status == 'reject')
            {
                $bubble = CommunityTeam::find($id);
                if($bubble->invite_role != '')
                {
                    $bubble->invite_role = '';
                    $bubble->status = 'follow';
                    $bubble->save();
                }
                else
                {
                    $bubble->delete();
                }
                return response()->json(['success'=>true,'message'=>'Request Delete Sucessfully','community_detail'=>$bubble]);
            }
            else
            {
                
				if($bubble->invite_role != '')
                {
					//For Admin or moderator
                    if(isset($request->premium))
                    {
						$bubble->status = 'paynent hold';
                    }
					else
					{
						$bubble->status = 'follow';
					}
					

					$bubble->role = $bubble->invite_role;
					$bubble->invite_role = '';
                    
                   // $bubble->save();
                }
				else
				{
					
					$bubble->status = ($request->status == 'blocked') ? 'blocked' : 'follow';
				}
				
				$user = Profile::find($bubble->profile_id);
				$fuser = Profile::find($bubble->invite_profile_id);
				$community = Community::find($bubble->community_id);

				$body = $user->name .' accept your invite request to join community ' . $community->title;
				$title = $user->name;
				$fcmToken = $fuser->device_token;
				$response = $this->firebaseService->sendNotification($fcmToken, $title, $body);

                $bubble->save();
                if($request->status == 'blocked')
                {
                    return response()->json(['success'=>true,'message'=>'Request Blocked Sucessfully','community_detail'=>$bubble]);

                }
                return response()->json(['success'=>true,'message'=>'You Have Accepted Joining Request','community_detail'=>$bubble]);
            }
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

    public function multi_request(Request $request)
    {
        try
        {
            
            $validator = Validator::make($request->all(), [
                'community_id' => 'required',
                'profile_id' => 'required|exists:profiles,id',
                'status' => 'required|string',
            ]);      
            
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first());
            }
            
            foreach($request->community_id as $id => $row)
            {
                $community = Community::find($row);
                if($community)
                {
                    if($community->privacy == 'No')
                    {
                        $input['status'] = $request->status;
                    }
                    else
                    {
    
                        // $input['status'] = ($request->status == 'accept') ? 'accept' : $request->status;
                        $input['status'] =  ($request->status == 'invite') ? 'invite' : 'follow';
                        // $input['status'] = 'follow';
                    }
                    $input['community_id'] = $row;
                    $input['profile_id'] = $request->profile_id;
                    $input['role'] = 'member';
    
                    $communityt = CommunityTeam::where(['community_id'=>$row,'profile_id' => $request->profile_id])->first();
                    if($communityt)
                    {
                        $communityt->delete();
                    }
                    else
                    {
						if($community->membership_cost == 'Yes')
						{
							$input['status'] = 'payment hold';
						}
                        $bubble = CommunityTeam::create($input);
                    }
                }
            }
            //$usersp = Profile::with('user_info','bubble_info')->where(['id' => $request->profile_id])->first();
            return response()->json(['success'=>true,'message'=>'Request Successfully']);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }


    public function member_add(Request $request)
    {
        try
        {
            $validator = Validator::make($request->all(), [
                'community_id' => 'required',
                'profile_id' => 'required',
                'status' => 'required',
            ]);      
            
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first());
            }
             
            $community = Community::find($request->community_id);
            
            $input = $request->all();
            $input['community_id'] = $request->community_id;
            $input['invite_profile_id'] = $request->invite_profile_id;
			if(strtolower($community->privacy) == 'yes')
            {
                $input['status'] = $request->status;
            }
            else
            {
                    // $input['status'] = ($request->status == 'accept') ? 'accept' : $request->status;
                    $input['status'] =  ($request->status == 'invite') ? 'invite' : 'follow';
            }
			if(strtolower($request->status) == 'request')
            {
                if(strtolower($community->membership_cost) == 'yes')
                {
					$input['status'] = 'payment hold';
                }
            }
            
            $input['role'] = 'member';
            foreach($request->profile_id as $key => $pid)
            {
                // return $pid;
                $fuser = Profile::find($community->profile_id);
				$user = Profile::find($pid);
                
                $communityt = CommunityTeam::where(['community_id'=>$request->community_id,'profile_id' => $pid])->first();
                if($communityt)
                {
                    $communityt->delete();
						
                    $body = $user->name .' has unfollowed your nest ' . $community->title;
                    $title = $user->name;
                    $fcmToken = $fuser->device_token;
                    //$response = $this->firebaseService->sendNotification($fcmToken, $title, $body);
                    try {
						$this->firebaseService->sendNotification($fcmToken, $title, $body);
					} catch (\Exception $fcmError) {
						// Agar notification fail ho to continue kare
					}
                    $fuser->notify(new GeneralNotification([
                        'profile_id' => $community->profile_id,
                        'type' => 'request join',
                        'community_id' => $request->community_id,
                        'sender_id' => $pid,
                        'message' => $user->name. " has unfollowed your nest " . $community->title,
                    ]));
                }
                else
                {
					if(strtolower($request->status) == 'request')
					{
                        if(strtolower($community->privacy) == 'yes')
                        {
                            $body = $fuser->name .' has request to join community ' . $community->title;
                        }
                        else
                        {
                            $body = $fuser->name .' has follow your community ' . $community->title;
                        }
						$title = $user->name;
						$fcmToken = $fuser->device_token;
						//$response = $this->firebaseService->sendNotification($fcmToken, $title, $body);
						try {
							$this->firebaseService->sendNotification($fcmToken, $title, $body);
						} catch (\Exception $fcmError) {
							// Agar notification fail ho to continue kare
						}
						$fuser->notify(new GeneralNotification([
							'profile_id' => $community->profile_id,
							'type' => 'request join',
							'community_id' => $request->community_id,
							'sender_id' => $pid,
							'message' => $body,
						]));
					}
					else
					{
						$body = $user->name .' has invited to join community ' . $community->title;
						$title = $user->name;
						$fcmToken = $fuser->device_token;
						//$response = $this->firebaseService->sendNotification($fcmToken, $title, $body);
						try {
							$this->firebaseService->sendNotification($fcmToken, $title, $body);
						} catch (\Exception $fcmError) {
							// Agar notification fail ho to continue kare
						}
						$user->notify(new GeneralNotification([
							'profile_id' => $pid,
							'type' => 'invite',
							'community_id' => $request->community_id,
							'sender_id' => $request->invite_profile_id,
							'message' => $fuser->name. " has invited to join community " . $community->title,
						]));
					}
					
                    $input['profile_id'] = $pid;
                    $bubble = CommunityTeam::create($input);
					if(strtolower($community->membership_cost) == 'yes')
					{
						$comdata = [
							'id' => $bubble->id,
							'price' => $community->joining_cost,
							'profile_id' => $user->id
						];
						Mail::to($user->email)->send(new PaymentCommunityJoinMail($comdata));
					}
                }

            }
             
             //$usersp = Profile::with('user_info','bubble_info')->where(['id' => $request->profile_id])->first();
            return response()->json(['success'=>true,'message'=>'Request Successfully']);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }
	
	public function member_admin(Request $request)
    {
        try
        {
            $validator = Validator::make($request->all(), [
                'community_id' => 'required',
                'profile_id' => 'required',
                'role' => 'required',
            ]);      
            
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first());
            }

            $communityt = CommunityTeam::where(['community_id'=>$request->community_id,'profile_id' => $request->profile_id])->first();
            $communityt->role = $request->role;
            $communityt->save(); 

            return response()->json(['success'=>true,'message'=>'Request Successfully']);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }
	
    public function store(Request $request)
	{
		try { 
			// ✅ Validation
			$validator = Validator::make($request->all(), [
				'title' => 'required|string',		
				'membership_cost' => 'required',			
				'privacy' => 'required',								
				'profile_id' => 'required',						
				'image' => 'required|image|mimes:jpeg,png,jpg,bmp,gif,svg',
			]);      

			if($validator->fails()) {
				return $this->sendError($validator->errors()->first());
			}

			// ✅ Profile update
			$profile = Profile::findOrFail($request->profile_id);
			$profile->bubble = $profile->bubble + 1;
			$profile->save();

			$fileName = null;
			if($request->hasFile('image')) {
				$file = $request->file('image');
				$fileName = md5($file->getClientOriginalName() . time()) .'.'. $file->getClientOriginalExtension();
				$file->move('uploads/community/', $fileName);  
				$image = asset('uploads/community/'.$fileName);
			}

			$input = $request->except(['keywords','interest','premium']);
			$input['image'] = 'uploads/community/'.$fileName;
			$input['profile_id'] = $request->profile_id;

			if($request->premium) {
				$input['status'] = 'active';
				$user = User::find(Auth::user()->id);
				$amount = 1;
				if($user->current_plan !== 'Basic')
				{
					Mail::to($profile->email)->send(new MonetizationRequestMail($profile));
				}
			}

			$bubble = Community::create($input);

			// ✅ Agora Start
			try {
				$appId = env('AGORA_APP_ID');
				$appCertificate = env('AGORA_APP_CERTIFICATE');
				$orgName = env('AGORA_ORG_NAME');   
				$appName = env('AGORA_APP_NAME');   
				$expiresInSeconds = 3600;
				$agoraUsername = $request->profile_id;

				$token = ChatTokenBuilder2::buildAppToken($appId, $appCertificate, $expiresInSeconds);
				$appToken = $token; 

				$url = "https://a41.chat.agora.io/{$orgName}/{$appName}/chatrooms";
				$headers = [
					'Content-Type' => 'application/json',
					'Accept' => 'application/json',
					'Authorization' => 'Bearer ' . $appToken,
				];
				$data = [
					"name" => $bubble->title,
					"description" => $request->description,
					"maxusers" => 500,
					"owner" => $request->profile_id,
				];

				$response = Http::withHeaders($headers)->post($url, $data);
				if ($response->failed() || empty($response['data']['id'])) {
					throw new \Exception('Failed to create Agora chatroom.');
				}

				$roomid = $response['data']['id'];

				ChatRoom::create([
					'room_id' => $roomid,
					'community_id' => $bubble->id,
					'name' => $bubble->title,
					'owner'=>$request->profile_id,
					'type' => 'chat',
					'max_users' => 500
				]);
			} catch (\Exception $e) {
				return $this->sendError("Agora error: " . $e->getMessage());
			}
			// ✅ Agora End

			// ✅ Firebase Notification
			try {
				if(isset($request->interest)) {
					$interest = Interests::find($request->interest);
					CommunityInterests::create([
						'profile_id' => $request->profile_id,
						'community_id' => $bubble->id,
						'interest_id' => $interest->id,
						'name' => $interest->name,
					]);

					$profileintrests = ProfileInterests::where('interest_id',$interest->id)->whereNot('profile_id',$request->profile_id)->pluck('profile_id');
					foreach($profileintrests as $profile_id) {
						if($request->profile_id !== $profile_id) {
							$community = Community::find($request->community_id);
							$user = Profile::find($profile_id);
							$fuser = Profile::find($request->profile_id);

							$body = 'New nests available in your selected interest ' . $interest->name;
							$title = 'Nest Suggestion';
							$fcmToken = $user->device_token;

							try {
								$this->firebaseService->sendNotification($fcmToken, $title, $body);
							} catch (\Exception $fcmError) {
								// Agar notification fail ho to continue kare
							}

							$user->notify(new GeneralNotification([
								'profile_id' => $user->id,
								'type' => 'community',
								'community_id' => $request->community_id,
								'sender_id' => $fuser->id,
								'message' => $body,
							]));
						}
					}
				}
			} catch (\Exception $e) {
				return $this->sendError("Firebase error: " . $e->getMessage());
			}

			// ✅ Keywords Save
			foreach($request->keywords ?? [] as $row) {
				CommunityKeywords::create([
					'community_id' => $bubble->id,
					'name' => $row,
					'profile_id' => $request->profile_id
				]);
			}

			// ✅ Owner Add in CommunityTeam
			CommunityTeam::create([
				'community_id' => $bubble->id,
				'profile_id' => $request->profile_id,
				'role' => 'owner',
				'status' => 'follow',
			]);

			$usersc = Community::with('streaming')->where(['profile_id' => $request->profile_id])->get();
			$usersp = Profile::find($request->profile_id);

			return response()->json([
				'success'=>true,
				'message'=>'Community Create Successfully',
				'community_list' => $usersc,
				'profile_info' => $usersp
			]);
		}
		catch(\Exception $e){
			return $this->sendError($e->getMessage());    
		}
	}


    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request, $id)
{
    try {
        // Profile ke interest IDs nikal lo
        $interestIds = ProfileInterests::where('profile_id', $id)
            ->pluck('interest_id');

        // Direct interest_detail ka array, name ASC order me
        $data['interests'] = Interests::whereIn('id', $interestIds)
            ->orderBy('name', 'asc')
            ->get();

        $data['community_list'] = CommunityTeam::with(
            'community_info',
            'community_info.community_owner',
            'community_info.interest'
        )
        ->where('profile_id', $id)
        ->whereNot('role', 'member') // spelling sahi
        ->get();

        return response()->json([
            'success' => true,
            'message' => 'Interests Lists',
            'data' => $data
        ], 200);

    } catch (\Exception $e) {
        return $this->sendError($e->getMessage());    
    }
}

    
    
    
    public function my_communities(Request $request,$id)
    {
        try{
            $teams = CommunityTeam::where('profile_id', $id)
                ->where(function($q) {
                    $q->where('status','follow')
                    ->orWhere('status','payment hold');
                })
                ->get()
                ->pluck('community_id');
			
			$community = Community::with(['detail' => function($query) use ($id) {
				$query->where('profile_id', $id);
			},'interest'])
			->whereIn('id', $teams)
			->orderBy('title', 'asc')
			->get();

            return response()->json(['success'=>true,'message'=>'Community Lists','community'=>$community],200);

        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }
	
	public function my_all_communities(Request $request,$id)
    {
        try{
            $teams = CommunityTeam::where('profile_id',$id)->get()->pluck('community_id');

			$community = Community::with(['detail' => function($query) use ($id) {
				$query->where('profile_id', $id);
			},'interest'])
			->whereIn('id', $teams)
			->orderBy('title', 'asc')
			->get();

            return response()->json(['success'=>true,'message'=>'Community Lists','community'=>$community],200);

        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());
        }
    }
    
    public function detail(Request $request,$id)
    {
        try{
            $mytime = \Carbon\Carbon::now();
// echo $mytime->toDateTimeString();die;
            $timein = CommuinityCheckIn::where('profile_id',$request->profile_id)->where('community_id',$id)->first();
            if($timein)
            {
                $timein->time_in = $mytime->toDateTimeString();
                $timein->save();
            }
            else
            {
                CommuinityCheckIn::create([
                    'community_id' => $id,
                    'profile_id' => $request->profile_id,
                    'time_in' => $mytime->toDateTimeString(),
                ]);
            }
            $community = Community::withCount('total_posts')->with(['chatroom','streaming' => function ($query) {
							$query->where('status', 'start');
						},'interest'])->find($id);
            $community['total_members'] = CommunityTeam::where(['community_id'=>$community->id,'status'=>'follow'])->count();
            $community['follow'] = CommunityTeam::where(['community_id'=>$community->id,'profile_id'=>$request->profile_id])->first();
            return response()->json(['success'=>true,'message'=>'Community Detail' ,'community_info'=>$community]);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try
        {
            $validator = Validator::make($request->all(), [
            //    'title' => 'required|string',
            //    'approval_admittance' => 'required',			
            //    'approval_post' => 'required',			
            //    'membership_cost' => 'required',			
            //    'privacy' => 'required',			
                //'post_privacy' => 'required',			
                //'remove_content' => 'required',			
                //'remove_comments' => 'required',			
                //'invite_members' => 'required',						
                'profile_id' => 'required',						
                //'image' => 'required|image|mimes:jpeg,png,jpg,bmp,gif,svg',
            ]);      
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first());
            }
            $communitys = Community::find($id); 
            $input = $request->all();
            $filename = $communitys->image;
            if($request->hasFile('image')) 
            {
                $file = request()->file('image');
                $fileName = md5($file->getClientOriginalName() . time()) .'.'. $file->getClientOriginalExtension();
                $file->move('uploads/community/', $fileName);  
                $input['image'] = 'uploads/community/'.$fileName;
            }

            $input['profile_id'] = $request->profile_id;
            $bubble = $communitys->update($input);
            return response()->json(['success'=>true,'message'=>'Community Update Successfully']);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }

    public function community_member_remove($id)
    {
        try
        {
            $community = CommunityTeam::find($id);
            $community->delete();
            return response()->json(['success'=>true,'message'=>'Member Removed Successfully']);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }

    }
    
    public function search(Request $request)
    {
        $query = $request->input('search');
		$profileId = $request->input('profile_id');
        $community = Community::withCount('total_posts','total_members')->with(['profile_info','follow' => function($query) use ($profileId) {
            $query->where('profile_id', $profileId);  // Only include 'follow' where profile_id matches the request
        }])->where('title', 'like', "%$query%")->get();
        $feeds = Feed::with('profile_info','hashtags','posts','posts.total_likes','posts.comments','posts.comments.profile_info','posts.post_images','posts.post_videos','posts.profile_info','follow')->where('name', 'like', "%$query%")->get();

        $posts = Post::withCount('total_likes')
        ->with('my_like', 'comments','comments.profile_info', 'post_images', 'post_videos', 'community_list', 'community_list.profile_info', 'profile_info')
		->where('status', 'active')
        ->where('caption', 'like', "%$query%")
        ->get();
		
		$profiles = Profile::where('name', 'like', "%$query%")->where('privacy','public')->get();
		$interest = Interests::where('name', 'like', "%$query%")->get();
		
        return response()->json(['success'=>true,'message'=>'Lists' ,'interest_list'=>$interest,'community_list'=>$community,'feeds'=>$feeds,'posts'=>$posts,'profile_list'=>$profiles]);
    }
    
    public function multiDestroy(Request $request)
	{
		$request->validate([
			'community_ids' => 'required|array',
			'profile_id' => 'required|exists:profiles,id',
		]);

		$profile = Profile::find($request->profile_id);
		$deletedCount = 0;

		foreach ($request->community_ids as $id) {
			$community = Community::find($id);
			if (!$community) {
				continue; // Skip if community not found
			}

			$deletedCount++;

			Community::where('id', $id)->delete();
			CommunityTeam::where('community_id', $id)->delete();
			CommuinityCheckIn::where('community_id', $id)->delete();
			CommunityInterests::where('community_id', $id)->delete();
			CommunityKeywords::where('community_id', $id)->delete();

			$posts = Post::where('community_id', $id)->get();
			foreach ($posts as $post) {
				PostHashtags::where('post_id', $post->id)->delete();

				$images = PostImage::where('post_id', $post->id)->get();
				foreach ($images as $image) {
					\File::delete(public_path('uploads/post/' . $image->name));
					$image->delete();
				}

				PostLike::where('post_id', $post->id)->delete();

				$videos = PostVideo::where('post_id', $post->id)->get();
				foreach ($videos as $video) {
					\File::delete(public_path('uploads/post/' . $video->name));
					$video->delete();
				}
			}
		}

		$profile->bubble = $profile->bubble - $deletedCount;
		$profile->save();

		$profile = Profile::with('interests', 'community_list')->find($request->profile_id);

		return response()->json([
			'success' => true,
			'message' => "$deletedCount Bubble(s) Deleted Successfully",
			'profile_info' => $profile,
		], 200);
	}

}
