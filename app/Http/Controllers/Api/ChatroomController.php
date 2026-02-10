<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\BaseController as BaseController;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ChatRoom;
use App\Models\ChatRoomUsers;
use App\Models\ChatRoomUsersMessage;
use Auth;
use BoogieFromZk\AgoraToken\ChatTokenBuilder2;
use Illuminate\Support\Facades\Http;
use Validator;
use BoogieFromZk\AgoraToken\RtcTokenBuilder2;
use App\Services\FirebaseService;
use App\Models\Profile;
use App\Models\CommunityTeam;
use App\Models\Community;

class ChatroomController extends BaseController
{
	protected $firebaseService;

    public function __construct(FirebaseService $firebaseService)
    {
        $this->firebaseService = $firebaseService;
    }
	
	public function rtc_token(Request $request,$id) 
	{
		$validator = Validator::make($request->all(),[
			'channelName' => 'required',
			'role' => 'required',
		]);
		if($validator->fails())
		{
			return $this->sendError($validator->errors()->first(),500);       
		}
		
		//agora start chatroom creat with chat token
		$appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
		$orgName = env('AGORA_ORG_NAME');   // Your Organization Name
        $appName = env('AGORA_APP_NAME');   // Your Application Name
        
        $expiresInSeconds = 360000000000000; // Token validity (1 hour 3600)
        $rtcToken = RtcTokenBuilder2::buildTokenWithUid($appId, $appCertificate,$request->channelName,$id,$request->role, $expiresInSeconds);
        
		return response()->json(['rtc_token' => $rtcToken], 201);
	}	
	
    public function store(Request $request) 
	{
		
		$validator = Validator::make($request->all(),[
			'profile_id' => 'required',
			'chat_name' => 'required',
			'description' => 'required',
			'maxusers' => 'required',
		]);
		if($validator->fails())
		{
			return $this->sendError($validator->errors()->first(),500);       
		}
		
		//agora start chatroom creat with chat token
		$appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
		$orgName = env('AGORA_ORG_NAME');   // Your Organization Name
        $appName = env('AGORA_APP_NAME');   // Your Application Name
        
        $expiresInSeconds = 3600; // Token validity (1 hour)
        $agoraUsername = $request->profile_id; // Username used for user registration above.
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
            "name" => $request->chat_name,
			"description" => $request->description,
			"maxusers" => $request->maxusers,
			"owner" => $request->profile_id,
	//		"name" => $request->chat_name,
        ];

        $response = Http::withHeaders($headers)->post($url, $data);
		//return $response;
		$roomid = $response['data']['id'];
		//end agora
		
		$chatroom = Chatroom::create(['room_id' => $roomid,'name' => $request->chat_name,'owner'=>$request->profile_id,'max_users' =>$request->maxusers]);

		return response()->json(['chatroom' => $chatroom], 201);
	}
	
	public function delete($id)
	{
		$appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
		$orgName = env('AGORA_ORG_NAME');   // Your Organization Name
        $appName = env('AGORA_APP_NAME');   // Your Application Name
		$expiresInSeconds = 3600; // Token validity (1 hour)
		$customerID    = env('AGORA_CUSTOMER_ID');
		$customerSecret= env('AGORA_CUSTOMER_SECRET');
		$rtcToken = ChatTokenBuilder2::buildAppToken($appId, $appCertificate, $expiresInSeconds);
        
        // ✅ Agora API URL
        $url = "https://a41.chat.agora.io/{$orgName}/{$appName}/chatrooms/{$id}";
		$chatroom = Chatroom::where('room_id' , $id)->first();
		$chatroom->status = 'end';
		$chatroom->save();
        //$headers = [
        //    'Content-Type' => 'application/json',
        //    'Accept' => 'application/json',
        //    'Authorization' => 'Bearer ' . $rtcToken,
        //];
		//Http::withHeaders($headers)->delete($url);
		//end
		return response()->json(['success'=>true,'message'=>'chatroom deleted']);
	}
	
	public function user_add(Request $request)
	{
		$validator = Validator::make($request->all(),[
			'chat_id' => 'required',
			'profile_id' => 'required'
		]);
		if($validator->fails())
		{
			return $this->sendError($validator->errors()->first(),500);       
		}
		
		
		$appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
		$orgName = env('AGORA_ORG_NAME');   // Your Organization Name
        $appName = env('AGORA_APP_NAME');   // Your Application Name
        
        $expiresInSeconds = 3600; // Token validity (1 hour)
        $agoraUsername = $request->profile_id; // Username used for user registration above.
        $token = ChatTokenBuilder2::buildAppToken($appId, $appCertificate, $expiresInSeconds);
        $userId = $request->profile_id; // User ka unique username
		$chatId = $request->chat_id; // User ka unique username
        $appToken = $token; // Agora App Token
        
        // ✅ Agora API URL
        $url = "https://a41.chat.agora.io/{$orgName}/{$appName}/chatrooms/{$chatId}/users/{$userId}";

        $headers = [
            'Content-Type' => 'application/json',
            'Accept' => 'application/json',
            'Authorization' => 'Bearer ' . $appToken,
        ];
	
       // return $body;
		$response = Http::withHeaders($headers)->post($url);
		
		$roomid = ChatRoom::where('room_id',$request->chat_id)->first();
		$success = ChatRoomUsers::create([
			'chatroom_id' => $roomid->id,
			'profile_id' => $userId
		]);
		
		return $this->sendResponse($success, 'User Add successfully.');
	}
	
	
	public function message_list(Request $request,$id)
	{	
		$messages = ChatRoomUsersMessage::where('chatroom_id', $id)
        ->where(function ($query) use ($id) {
            $query->whereNull('deleted_for') // Messages that are not deleted
                  ->orWhereJsonDoesntContain('deleted_for', $id); // Messages that current user has not deleted
        })
        ->orderBy('created_at', 'asc')
        ->get();
		
		return response()->json([
			'status' => 'success',
			'message' => 'Messages List',
			'data' => $messages
		]);
	}
	
	public function sendMessage(Request $request,$id)
	{
		$profileid = $request->profile_id;
		
		$profiles = CommunityTeam::where('community_id',$request->community_id)->get()->pluck('profile_id');
		$community = Community::find($request->community_id);
		$fuser = Profile::find($profileid);
		foreach($profiles as $profile)
		{
			if($profile != $profileid)
			{
				$user = Profile::find($profile);
				$body = 'you have new message in ' . $community->title;
				$title = $community->title;
				$fcmToken = $user->device_token;
				// $response = $this->firebaseService->sendNotification($fcmToken, $title, $body)
				try {
					$this->firebaseService->sendNotification($fcmToken, $title, $body);
				} catch (\Exception $fcmError) {
					// Agar notification fail ho to continue kare
				}
			}
		}

		// ✅ Create the message
		$message = ChatRoomUsersMessage::create([
			'chatroom_id' => $id,
			'profile_id' => $profileid,
			'text' => $request->text,
			'user' => json_encode($request->user),
		]);
		

		return response()->json([
			'status' => 'success',
			'message' => 'Message sent successfully!',
			'data' => $message
		]);

	}
}
