<?php

namespace App\Services;

use TaylanUnutmaz\AgoraTokenBuilder\RtcTokenBuilder;
use Illuminate\Support\Facades\Http;


class AgoraTokenService
{
    protected $appId;
    protected $appCertificate;

    public function __construct()
    {
        $this->appId = env('AGORA_APP_ID');
        $this->appCertificate = env('AGORA_APP_CERTIFICATE');
    }

    /**
     * Generate Agora RTC Token
     *
     * @param string $channelName
     * @param int $uid
     * @param int $role (0: Subscriber, 1: Publisher)
     * @param int $expireTimeInSeconds
     * @return string
     */
    public function generateRtcToken($channelName, $uid, $role = 1, $expireTimeInSeconds = 3600)
    {
        $currentTimestamp = now()->timestamp;
        $expireTimestamp = $currentTimestamp + $expireTimeInSeconds;

        return RtcTokenBuilder::buildTokenWithUid(
            $this->appId,
            $this->appCertificate,
            $channelName,
            $uid,
            $role,
            $expireTimestamp
        );
    }

    public function generateChatToken($userId)
    {
        $appKey = env('AGORA_APP_KEY');
        $appSecret = env('AGORA_APP_SECRET');
        $orgName = env('AGORA_CHAT_ORG_NAME');
        $appName = env('AGORA_CHAT_APP_NAME');
        $region = env('AGORA_CHAT_REGION', 'a41');

        


        $userId = 1;//auth()->id(); // Authenticated user ID
        $appId = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
        $expireTime = \Carbon\Carbon::now()->addHours(2)->timestamp; // 2 hours expiry

        $payload = [
            'uid' => (string) $userId,
            'exp' => $expireTime,
        ];

        $token = JWT::encode($payload, $appCertificate, 'HS256');

        // Token expiration time (1 din ka expiry time set kiya hai)
        $expireTime = now()->timestamp + 86400;

        // API Endpoint
        $url = "https://a41.chat.agora.io/411317503/1518668/users";

        // Send API Request
        $response = Http::withHeaders([
            'Authorization' => "Bearer $token",
            'Content-Type' => 'application/json',
        ])->post($url, [
            'grant_type' => 'password',
            'username' => $userId,
            'expire_time' => $expireTime,
        ]);

        // Debug response
        if ($response->successful()) {
            return $response->json();
        } else {
            return [
                'error' => [
                    'status' => $response->status(),
                    'message' => $response->body(),
                ]
            ];
        }
    }
}
