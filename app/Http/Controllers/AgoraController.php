<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use BoogieFromZk\AgoraToken\RtcTokenBuilder;
use App\Models\CallRequest;
use Auth;

class AgoraController extends Controller
{
    public function generateToken(Request $request)
    {
		//dd($request->channelName);
        $appID = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
        $channelName = $request->channelName;
        $uid = $request->uid ?? rand(100000, 999999);
        $role = RtcTokenBuilder::RoleAttendee;
        $expireTimeInSeconds = 360000000000000;
        $currentTimestamp = now()->timestamp;
        $privilegeExpiredTs = $currentTimestamp + $expireTimeInSeconds;

        $token = RtcTokenBuilder::buildTokenWithUid($appID, $appCertificate, $channelName, $uid, $role, $privilegeExpiredTs);

        return response()->json([
            'token' => $token,
            'uid' => $uid,
        ]);
    }
	
	public function sendCall(Request $request) {
		CallRequest::create([
            'caller_id' => $request->from_user_id,
            'receiver_id' => $request->to_user_id,
            'channel_name' => $request->channel_name,
			'status' => 'ringing'
        ]);
        return response()->json(['status' => 'Call request sent']);
    }

    //public function checkCall() {
		
	//	$id = Auth::user()->id;
    //    $call = CallRequest::where('receiver_id', $id)->where('accepted', false)->latest()->first();
   //     return response()->json(['call' => $call]);
    //}
	
	public function checkCall(Request $request)
	{
		$userId = auth()->id(); // ya $request->user_id;

		// 1. Kya koi active call hai jisme yeh user involved ho?
		$call = CallRequest::where(function($query) use ($userId) {
			//$query->where('caller_id', $userId);
			$query->where('receiver_id', $userId);
		})->latest()->first();

		// 2. Agar koi ringing call milti hai
		if ($call) {
			return response()->json(['call' => $call]);
		}

		// 3. Kya koi call cancel ho gayi hai?
		$canceledCall = CallRequest::where(function($query) use ($userId) {
			$query->where('receiver_id', $userId);
		})->where('status', 'ended') // ya 'canceled'
		  ->latest()->first();

		if ($canceledCall) {
			return response()->json(['call_canceled' => true]);
		}

		// 4. Agar kuch bhi nahi hai
		return response()->json([]);
	}


    public function acceptCall(Request $request) {
        $call = CallRequest::where('id', $request->call_id)->first();
        if ($call) {
            $call->update(['accepted' => $request->accepted,'status'=>$request->status,'start_at' => now()]);
        }
        return response()->json(['status' => 'accepted']);
    }
	
	public function endCall(Request $request)
	{
		$userId = auth()->id();

		$call = CallRequest::where(function ($query) use ($userId) {
			$query->where('caller_id', $userId)
				  ->orWhere('receiver_id', $userId);
		})
		->whereIn('status', ['ringing', 'accept']) // active calls only
		->latest()
		->first();

		if ($call) {
			$call->status = 'completed'; // ya 'ended'
			$call->ended_at = now();     // optional: agar time bhi store karna ho
			$call->save();

			return response()->json(['success' => true, 'message' => 'Call ended.']);
		}

		return response()->json(['success' => false, 'message' => 'No active call found.']);
	}
	
	public function rejectCall(Request $request, $call_id)
	{
		$call = CallRequest::findOrFail($call_id);
		$call->status = 'rejected';
		$call->save();

		return response()->json(['status' => 'rejected']);
	}
	
	public function getCallStatus($call_id)
	{
		$call = CallRequest::findOrFail($call_id);
		return response()->json(['status' => $call->status]);
	}

}
