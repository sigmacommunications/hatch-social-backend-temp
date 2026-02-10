<?php

// app/Services/AgoraService.php
namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Config;

class AgoraService
{
    protected $appId;
    protected $customerId;
    protected $customerSecret;
    protected $baseUrl;

    public function __construct()
    {
        $this->appId          =  env('AGORA_APP_ID');
        $this->customerId     = env('AGORE_CUSTOMER_ID');
        $this->customerSecret = env('AGORA_CUSTOMER_SECRET');
        $this->baseUrl        = env('AGORA_BASE_URL') . $this->appId . '/cloud_recording/';
    }

    protected function auth() {
        return Http::withBasicAuth($this->customerId, $this->customerSecret)
                   ->acceptJson()
                   ->contentType('application/json');
    }

    public function acquire(string $channelName, string $uid = '0')
    {
        $url = $this->baseUrl . 'acquire';
        return $this->auth()->post($url, [
            'cname' => $channelName,
            'uid'   => $uid,
        ])->json();
    }

    public function start(string $resourceId, string $channelName, string $token, string $uid = '0', string $mode = 'mix')
    {
        $url = $this->baseUrl . "resourceid/{$resourceId}/mode/{$mode}/start";
        return $this->auth()->post($url, [
            'cname'            => $channelName,
            'uid'              => $uid,
            'token'            => $token,
            'recordingConfig'  => [
                'maxIdleTime'    => 30,
                'streamTypes'    => 0,
                'channelType'    => 1,
                'audioProfile'   => 0,
            ],
            'storageConfig'    => [
                'vendor'         => 0,    // 0 = Customized (download via REST)
                'region'         => 0,
                'bucket'         => '',
                'accessKey'      => '',
                'secretKey'      => ''
            ],
        ])->json();
    }

    public function stop(string $resourceId, string $sid, string $channelName, string $uid = '0', string $mode = 'mix')
    {
        $url = $this->baseUrl . "resourceid/{$resourceId}/sid/{$sid}/mode/{$mode}/stop";
        return $this->auth()->post($url, [
            'cname' => $channelName,
            'uid'   => $uid,
        ])->json();
    }

    public function fileList(string $resourceId, string $sid)
    {
        $url = $this->baseUrl . "resourceid/{$resourceId}/sid/{$sid}/filelist";
        return $this->auth()->get($url)->json();
    }

    public function download(string $resourceId, string $sid, string $fileName)
    {
        $url = $this->baseUrl
             . "resourceid/{$resourceId}/sid/{$sid}/file"
             . "?fileName={$fileName}";
        $response = $this->auth()->get($url);
        return $response->body();  // raw binary
    }
}
