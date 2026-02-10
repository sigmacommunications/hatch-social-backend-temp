<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\AgoraTokenService;
use TaylanUnutmaz\AgoraTokenBuilder\RtcTokenBuilder;
use Illuminate\Support\Facades\Http;
use GuzzleHttp\Client;
use Firebase\JWT\JWT;
use TaylanUnutmaz\AgoraTokenBuilder\RtmTokenBuilder;
use BoogieFromZk\AgoraToken\ChatTokenBuilder2;
use BoogieFromZk\AgoraToken\RtcTokenBuilder2;
use Illuminate\Support\Facades\Storage;

use App\Services\AgoraService;


class AgoraController extends Controller
{
     protected $agora;

    public function __construct(AgoraService $agora)
    {
        $this->agora = $agora;
    }

    public function getToken(Request $request)
    {


        
        $token = $this->agoraService->generateChatToken($request->user_id);

        return response()->json([
            'user_id' => $request->user_id,
            'chat_token' => $token
        ]);


        //work 
        $request->validate([
            'channel_name' => 'required|string',
            'user_id' => 'required|integer',
        ]);

        $token = $this->agoraService->generateRtcToken(
            $request->channel_name,
            $request->user_id
        );

        return response()->json(['token' => $token]);
    }



    public function registeruserwithchatapptoken(Request $request)
    {

        $appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
        
        $expiresInSeconds = 3600; // Token validity (1 hour)
        $agoraUsername = $request->input('username'); // Username used for user registration above.
        
        // $token = ChatTokenBuilder2::buildAppToken($appId, $appCertificate, $agoraUsername, $expiresInSeconds);
        $token = ChatTokenBuilder2::buildAppToken($appId, $appCertificate, $expiresInSeconds);



        $userId = $request->input('username'); // User ka unique username
        $appToken = $token;// Agora App Token
        $orgName = env('AGORA_ORG_NAME');   // Your Organization Name
        $appName = env('AGORA_APP_NAME');   // Your Application Name

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

       

        return response()->json([
            'status' => $response->status(),
            'response' => $response->json()
        ]);
    }


    public function loginUser(Request $request)
    {
        $appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
        $expiresInSeconds = 3600; // Token validity (1 hour)


       return  $accessToken = ChatTokenBuilder2::buildUserToken($appId, $appCertificate,'123asd', $expiresInSeconds);
       

        $serviceChat->addPrivilege($serviceChat::PRIVILEGE_USER, $expire);
        $accessToken->addService($serviceChat);

        return $accessToken->build();

        
        $orgName = env('AGORA_ORG_NAME');   // Your Organization Name
        $appName = env('AGORA_APP_NAME');   // Your Application Name


        $appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
        
        $expiresInSeconds = 3600; // Token validity (1 hour)
        $agoraUsername = '123asd'; // Username used for user registration above.
        
        // $token = ChatTokenBuilder2::buildAppToken($appId, $appCertificate, $agoraUsername, $expiresInSeconds);
        $token = ChatTokenBuilder2::buildAppToken($appId, $appCertificate, $expiresInSeconds);

        // ✅ Agora API URL
        $url = "https://a41.chat.agora.io/{$orgName}/{$appName}/users/{$agoraUsername}";

        $headers = [
            'Content-Type' => 'application/json',
            'Accept' => 'application/json',
            'Authorization' => 'Bearer ' . $token,
        ];
        $data = [
            "username" => $agoraUsername
        ];

        $response = Http::withHeaders($headers)->post($url, $data);

       

        return response()->json([
            'status' => $response->status(),
            'data' => $response->json(),
            'chatapptoken' => $token
        ]);
    }
	
	
	
	//agora recording
	public function acquire(Request $request)
    {
        $appID         = env('AGORA_APP_ID');
		$customerID    = env('AGORA_CUSTOMER_ID');
		$customerSecret= env('AGORA_CUSTOMER_SECRET');
		$channelName   = $request->channel_name;
		$appCertificate = env('AGORA_APP_CERTIFICATE');
		$expiresInSeconds = 3600;
		
		$authHeader    = base64_encode("$customerID:$customerSecret");
		$recordingUid  = $request->uid;
         $rtctoken = RtcTokenBuilder2::buildTokenWithUid($appID, $appCertificate,$channelName,$recordingUid,1, $expiresInSeconds);
		// 1. Acquire resource ID
		$acquire = Http::withHeaders([
			'Authorization' => 'Basic ' . $authHeader,
			'Content-Type'  => 'application/json;charset=utf-8',
		])->post("https://api.agora.io/v1/apps/{$appID}/cloud_recording/acquire", [
			'cname'         => $channelName,
			'uid'           => $recordingUid,
			'clientRequest' => (object)[],
		]);

		$resourceId = $acquire->json()['resourceId'];

		// 2. Start composite (mix) recording
		 $start = Http::withHeaders([
			'Authorization' => 'Basic ' . $authHeader,
			'Content-Type'  => 'application/json;charset=utf-8',
		])->post("https://api.agora.io/v1/apps/{$appID}/cloud_recording/resourceid/{$resourceId}/mode/mix/start", [
			'cname'         => $channelName,
			'uid'           => $recordingUid,
			'clientRequest' => [
				'token'                => $rtctoken,               // Your RTC token
				'recordingConfig'      => [                        // REQUIRED: select services
					'maxIdleTime'       => 120,
					'streamTypes'       => 2,                      // 2 = audio+video
					'channelType'       => 0,                      // 1 = live broadcasting
					'audioProfile'      => 0,
					"videoStreamType"	=> 0,
					"streamMode" => "standard",
					"subscribeVideoUids"=> [
						"#allstream#"
					],
					"subscribeAudioUids" => [
						"#allstream#"
					],
					"subscribeUidGroup" => 0
				],
				'recordingFileConfig'  => [                        // REQUIRED: choose output formats
					'avFileType'        => ['hls','mp4'],                // or ['hls','mp4']
				],
				'storageConfig'       => [
					'vendor'           => 0,
					'region'           => 1,
					'bucket'           => 'recordingtesting',
					'accessKey'        => 'streaming-mushi',
					'secretKey'        => 'K005hH7/aUSnPX9f0XLgusj+SVijbr0',
					'endpoint' => 'https://s3.us-east-005.backblazeb2.com'
					//'fileNamePrefix'   => [$channelName]
				]
				// ← no storageConfig: you’ll pull via fileList & download endpoints
			],
		]);


return $start->json();

        return $response->json();
    }

    public function start(Request $request)
    {
		$appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
        $expiresInSeconds = 360000000000000; // Token validity (1 hour)
		
        $channelName = $request->channel_name;
        $uid = $request->uid;
        $resourceId = $request->resource_id;
        $token = RtcTokenBuilder2::buildTokenWithUid($appId, $appCertificate,$channelName,$uid,1, $expiresInSeconds);


        $response = Http::withBasicAuth(env('AGORA_CUSTOMER_ID'), env('AGORA_CUSTOMER_SECRET'))
            ->post("https://api.agora.io/v1/apps/".env('AGORA_APP_ID')."/cloud_recording/resourceid/{$resourceId}/mode/mix/start", [
                "cname" => $channelName,
                "uid" => $uid,
                'clientRequest' => [
                    'recordingConfig' => [
                        'channelType' => 1,
                        'streamTypes' => 2,
                        'audioProfile' => 1,
                        'videoStreamType' => 0,
                        'maxIdleTime' => 30,
                        'transcodingConfig' => [
                            'width' => 640,
                            'height' => 360,
                            'fps' => 15,
                            'bitrate' => 600,
                            'mixedVideoLayout' => 1,
                        ],
                    ],
					"recordingFileConfig" => [
					  "avFileType" => ["hls", "mp4"]
					],
					"recordingServiceConfig" => [
					  "serviceType" => 2
					],
                ],
            ]);

        return $response->json();
    }

    public function stop(Request $request)
	{
		$appID       = env('AGORA_APP_ID');
		$channelName = $request->input('channel_name');
		$uid         = $request->input('uid');
		$resourceId  = $request->input('resource_id');
		$sid         = $request->input('sid');
		$customerID    = env('AGORA_CUSTOMER_ID');
$customerSecret= env('AGORA_CUSTOMER_SECRET');
$authHeader    = base64_encode("$customerID:$customerSecret");
		$response = Http::withHeaders([
			'Authorization' => 'Basic ' . $authHeader,
			'Content-Type'  => 'application/json;charset=utf-8',
		])->post(
				"https://api.agora.io/v1/apps/{$appID}/cloud_recording/resourceid/{$resourceId}/sid/{$sid}/mode/mix/stop",
				[
					'cname'         => $channelName,
					'uid'           => $uid,
					'clientRequest' => (object)[],
				]
			);

		return response()->json($response->json());
	}
	
	public function saveAgoraRecording($fileUrl, $filename)
	{
		// Download file from Agora temp URL
		$response = Http::get($fileUrl);

		if ($response->successful()) {
			Storage::disk('recordings')->put($filename, $response->body());
			return response()->json(['message' => 'Recording saved!']);
		}

		return response()->json(['error' => 'Failed to download recording'], 500);
	}

}
