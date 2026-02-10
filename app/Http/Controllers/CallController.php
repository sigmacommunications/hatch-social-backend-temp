<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use BoogieFromZk\AgoraToken\RtcTokenBuilder;
use App\Models\CallRequest;
use Carbon\Carbon;
use Illuminate\Support\Str;

class CallController extends Controller
{
    public function index(Request $request)
    {
		
		//token
		$appID = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
        //$channelName = 'abc';//$request->channelName;
        $channelName = 'testChannel'; // dynamic bana sakte ho user-wise
		$uid = $request->uid ?? rand(100000, 999999);
        $role = RtcTokenBuilder::RoleAttendee;
        $expireTimeInSeconds = 360000000000000;
        $currentTimestamp = now()->timestamp;
        $privilegeExpiredTs = $currentTimestamp + $expireTimeInSeconds;

        $token = RtcTokenBuilder::buildTokenWithUid($appID, $appCertificate, $channelName, $uid, $role, $privilegeExpiredTs);
		//token end
        $appID = env('AGORA_APP_ID');
        
        return view('call', compact('appID', 'channelName', 'token'));
    }
	
	
	public function initiateCall(Request $request)
    {
        $channel = Str::random(10);

        $call = CallRequest::create([
            'caller_id' => auth()->id(),
            'receiver_id' => $request->receiver_id,
            'channel_name' => $channel,
        ]);

        return response()->json([
            'call_id' => $call->id,
            'channel' => $channel,
            'app_id' => env('AGORA_APP_ID'),
            'token' => '' // temp token can be added
        ]);
    }

    public function checkCall()
    {
        $call = CallRequest::where('receiver_id', auth()->id())
            ->where('status', 'ringing')
            ->latest()
            ->first();

        return response()->json(['call' => $call]);
    }

    public function updateStatus(Request $request, $id)
    {
        $call = CallRequest::find($id);
        if (!$call) return response()->json(['error' => 'Not found'], 404);

        $call->status = $request->status;

        if ($request->status == 'accepted') {
            $call->start_at = Carbon::now();
        } elseif (in_array($request->status, ['rejected', 'no_response'])) {
            $call->end_at = Carbon::now();
        }

        $call->save();
        return response()->json(['message' => 'Status updated']);
    }
}
