<?php

namespace App\Http\Controllers\Api;
use App\Http\Controllers\Api\BaseController as BaseController;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\CommunityStreaming;
use App\Models\Community;
use App\Models\CommunityTeam;
use App\Models\ChatRoom;
use App\Models\Profile;
use Validator;
use BoogieFromZk\AgoraToken\ChatTokenBuilder2;
use Illuminate\Support\Facades\Http;
use App\Notifications\GeneralNotification;
use App\Services\FirebaseService;


class CommunityStreamingController extends BaseController
{
	
	protected $firebaseService;

    public function __construct(FirebaseService $firebaseService)
    {
        $this->firebaseService = $firebaseService;
    }
	
    public function store(Request $request)
    {
        try
		{
            $validator = Validator::make($request->all(), [
                'community_id' => 'required|string',
            ]); 
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first(),500);
            }
			
			$appId = env('AGORA_APP_ID');
			$appCertificate = env('AGORA_APP_CERTIFICATE');
			$orgName = env('AGORA_ORG_NAME');   // Your Organization Name
			$appName = env('AGORA_APP_NAME');   // Your Application Name
			$community = Community::find($request->community_id);
			$expiresInSeconds = 36000000; // Token validity (1 hour)
			$agoraUsername = $community->profile_id; // Username used for user registration above.
			$token = ChatTokenBuilder2::buildAppToken($appId, $appCertificate, $expiresInSeconds);
			$userId = $request->profile_id; // User ka unique username
			$appToken = $token; // Agora App Token
			
			// ✅ Agora API URL
			$url = "https://a41.chat.agora.io/{$orgName}/{$appName}/chatrooms";

			$headers = [
				'Content-Type' => 'application/json',
				'Accept' => 'application/json',
				'Authorization' => 'Bearer ' . $appToken,
			];
			$data = [
				"name" => $community->title,
				"description" => $request->description,
				"maxusers" => 500,
				"owner" => strval($community->profile_id),
			];

			$response = Http::withHeaders($headers)->post($url, $data);
			
			$roomid = $response['data']['id'];
			
			$chatroom = ChatRoom::create([
				'room_id' => $roomid,
				'community_id' => $community->id,
				'name' => $community->title,
				'owner'=> $community->profile_id,
				'max_users' => 500,
				'type' => 'streaming',
				'status' => 'start'
			]);
			
			$users = CommunityTeam::where('community_id',$request->community_id)->get();
			$community = Community::find($request->community_id);

			foreach ($users as $userr) {
				$user = Profile::find($userr->profile_id);
				// Optional: Sender ko notification na mile
				if ($user->id != $request->profile_id) {
					
					$fuser = Profile::find($request->profile_id);
					
					$body = $fuser->name .' has started live streming in ' . $community->title;
					$title = $fuser->name;
					$fcmToken = $user->device_token;
					//$response = $this->firebaseService->sendNotification($fcmToken, $title, $body);
					try {
						$this->firebaseService->sendNotification($fcmToken, $title, $body);
					} catch (\Exception $fcmError) {
						// Agar notification fail ho to continue kare
					}
					$user->notify(new GeneralNotification([
						'profile_id' => $user->id,
						'type' => 'streaming',
						'community_id' => $request->community_id,
						'sender_id' => $request->profile_id,
						'message' => $user->name. " has started live streming in " . $community->title,
					]));
				}
			}

			
			$input = $request->all();
			$input['start'] = date('y-m-d h:i:s');
			
			$community = Community::with('streaming')->find($request->community_id);
			$community['follow'] = CommunityTeam::where(['community_id'=>$community->id,'profile_id'=>$request->profile_id])->first();
			
            return response()->json(['success'=>true,'message'=>'Streaming Start','community_info'=>$community]);

        }catch(\Eception $e){
            return $this->sendError($e->getMessage());

        }
    }
	
	public function stream_users(Request $request)
	{
			$appId = env('AGORA_APP_ID');
			$appCertificate = env('AGORA_APP_CERTIFICATE');
			$orgName = env('AGORA_ORG_NAME');   // Your Organization Name
			$appName = env('AGORA_APP_NAME');   // Your Application Name
			$expiresInSeconds = 36000000; // Token validity (1 hour)
			$channel = $request->channel; // Username used for user registration above.
			
			// ✅ Agora API URL
			$url = "http://api.sd-rtn.com/dev/v1/channel/user/$appId/{$channel}";

		
			$customerID    = env('AGORA_CUSTOMER_ID');
			$customerSecret= env('AGORA_CUSTOMER_SECRET');
			$appToken    = base64_encode("$customerID:$customerSecret");
		
			$headers = [
				'Content-Type' => 'application/json',
				'Accept' => 'application/json',
				'Authorization' => 'Basic ' . $appToken,
			];
		
		$response = Http::withHeaders($headers)->get($url);
		
		return $response;
	}
}
