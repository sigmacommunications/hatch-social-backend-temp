<?php

namespace App\Services;

use GuzzleHttp\Client;
use BoogieFromZk\AgoraToken\RtcTokenBuilder2;

class AgoraRecordingService
{
    private $client;
    private $apiUrl;
    private $appId;
    private $appCertificate;
    private $token;

    public function __construct()
    {
        $this->client = new Client();
        $this->apiUrl = 'https://api.agora.io/v1/apps/{app_id}/cloud_recording/resourceid/{resource_id}/mode/mix/start';
        $this->appId = env('AGORA_APP_ID'); // Set your Agora App ID in .env
        $this->appCertificate = env('AGORA_APP_CERTIFICATE'); // Set your Agora App Certificate in .env
        $this->token = $this->generateAgoraToken();
    }

    // Generate an Agora token (you should handle token generation)
    private function generateAgoraToken(Request $request)
    {
        $appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
        $expiresInSeconds = 360000000000000; 
		$channelName = $request->channel_name;
		$uid = $request->uid;
		
        return $rtcToken = RtcTokenBuilder2::buildTokenWithUid($appId, $appCertificate,$channelName,$uid,1, $expiresInSeconds);
    }

    // Start recording
    public function startRecording($channelName, $uid)
    {
        $url = str_replace(['{app_id}', '{resource_id}'], [$this->appId, 'your_resource_id'], $this->apiUrl);

        $body = [
            'channelName' => $channelName,
            'uid' => $uid,
            'clientRequest' => [
                'token' => $this->token,
                'cname' => $channelName,
                'uid' => $uid,
                'recordingConfig' => [
                    'maxIdleTime' => 120,
                    'streamTypes' => 2, // Choose appropriate stream types
                ]
            ]
        ];

        try {
            $response = $this->client->post($url, [
                'json' => $body,
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Authorization' => 'Basic ' . base64_encode($this->appId . ':' . $this->appCertificate),
                ],
            ]);
            return json_decode($response->getBody(), true);
        } catch (\Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }

    // Stop recording
    public function stopRecording($resourceId, $sid)
    {
        $url = 'https://api.agora.io/v1/apps/' . $this->appId . '/cloud_recording/resourceid/' . $resourceId . '/sid/' . $sid . '/stop';

        try {
            $response = $this->client->post($url, [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Authorization' => 'Basic ' . base64_encode($this->appId . ':' . $this->appCertificate),
                ],
            ]);
            return json_decode($response->getBody(), true);
        } catch (\Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
}
