<?php

namespace App\Http\Controllers;

use App\Events\WebMessageSend;
use App\Models\Webmessage;
use App\Models\Profile;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Pusher\Pusher; 
use Mail;
use App\Mail\NewMessageNotification;

class ChatController extends Controller
{
    public function messagesTable()
    {
        $messages = Webmessage::with(['sender:id,name,photo', 'receiver:id,name,photo'])
            ->latest()
            ->limit(500)
            ->get()
            ->map(function ($message) {
                return [
                    'id' => $message->id,
                    'text' => $message->text,
                    'sender' => optional($message->sender)->name ?? 'Unknown',
                    'sender_photo' => optional($message->sender)->photo,
                    'receiver' => optional($message->receiver)->name ?? 'Unknown',
                    'receiver_photo' => optional($message->receiver)->photo,
                    'is_read' => (bool) $message->is_read,
                    'created_at' => $message->created_at ? $message->created_at->toDateTimeString() : null,
                ];
            });

        return response()->json(['data' => $messages]);
    }

    public function updateMessage(Request $request, Webmessage $message)
    {
        $validator = Validator::make($request->all(), [
            'text' => 'required|string|max:2000',
        ]);

        if ($validator->fails()) {
            return response()->json(['success' => false, 'errors' => $validator->errors()], 422);
        }

        $message->update(['text' => $request->text]);

        return response()->json(['success' => true, 'message' => 'Message updated', 'data' => $message]);
    }

    public function destroyMessage(Webmessage $message)
    {
        $message->delete();

        return response()->json(['success' => true, 'message' => 'Message deleted']);
    }
	
	public function profilesendMessage(Request $request)
	{
		$profile= Profile::find($request->receiver_id);
		$message = new Webmessage();
		$message->sender_id = $request->receiver_id;
		$message->receiver_id = 1;
		$message->text = $request->message;
		$message->user = auth()->user();
		$message->save();
		
		broadcast(new WebMessageSend($message,1))->toOthers();

		return response()->json(['success' => true, 'message' => 'Sent']);
	}
	
	public function sendMessage(Request $request)
	{
		$message = new Webmessage();
		$message->sender_id = Auth::id();
		$message->receiver_id = $request->receiver_id;
		$message->text = $request->message;
		$message->user = auth()->user();
		$message->save();
		
		
		broadcast(new WebMessageSend($message,$request->receiver_id))->toOthers();


		$totalMsgs = Webmessage::where([
            'sender_id' => Auth::id(),
            'receiver_id' => $request->receiver_id
        ])
        ->orWhere([
            'receiver_id' => Auth::id(), 
            'sender_id' => $request->receiver_id
        ])
        ->count();
		if ($totalMsgs < 1) {
			$receiver = Profile::find($request->receiver_id);
			Mail::to($receiver->email)->send(new NewMessageNotification($message, $request->receiver_id));
		}

		return response()->json(['success' => true, 'message' => 'Sent']);
	}
	
	private function isUserOnline($userId)
	{
		try {
			$pusher = app('pusher');

			// Aapka private channel name
			$channelName = 'private-chat.' . $userId;

			$response = $pusher->get('/channels/' . $channelName);
			$channelInfo = json_decode($response['body'], true);

			// Check if channel exists and has subscribers
			if (isset($channelInfo['channels'][$channelName])) {
				return $channelInfo['channels'][$channelName]['subscription_count'] > 0;
			}

			return false;
		} catch (\Exception $e) {
			\Log::error('Online check error: ' . $e->getMessage());
			return false;
		}
	}

	
	public function profile_chat_list(Request $request,$userId)
	{
		try {
            $receiverId = 1;
			
            Log::info("Getting messages between $userId and $receiverId");

            // Messages get karen based on chat relationships
            $messages = Webmessage::where(function($query) use ($userId, $receiverId) {
                $query->where('sender_id', $userId)
                      ->where('receiver_id', $receiverId);
            })->orWhere(function($query) use ($userId, $receiverId) {
                $query->where('sender_id', $receiverId)
                      ->where('receiver_id', $userId);
            })
            ->with(['sender', 'receiver'])
            ->orderBy('created_at', 'asc')
            ->get();

            Log::info("Found " . $messages->count() . " messages");

            return response()->json($messages);

        } catch (\Exception $e) {
            Log::error('Get messages error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'error' => 'Failed to load messages: ' . $e->getMessage()
            ], 500);
        }
	}
	
    public function get_messages(Request $request,$userId)
	{
		try {
           $receiverId = Auth::id() ?: 1;
			
           
            // Messages get karen based on chat relationships
            $messages = Webmessage::where(function($query) use ($userId, $receiverId) {
                $query->where('sender_id', $userId)
                      ->where('receiver_id', $receiverId);
            })->orWhere(function($query) use ($userId, $receiverId) {
                $query->where('sender_id', $receiverId)
                      ->where('receiver_id', $userId);
            })
            ->with(['sender', 'receiver'])
            ->orderBy('created_at', 'asc')
            ->get();

            Log::info("Found " . $messages->count() . " messages");

            return response()->json($messages);

        } catch (\Exception $e) {
            Log::error('Get messages error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'error' => 'Failed to load messages: ' . $e->getMessage()
            ], 500);
        }
	}
	
	public function markMessagesAsRead(Request $request)
	{
		$userId = auth()->id();
		$senderId = $request->sender_id;

		// Mark all unread messages from this sender as read
		$updated = Webmessage::where('receiver_id', $userId)
						 ->where('sender_id', $senderId)
						 ->where('is_read', 0)
						 ->update(['is_read' => 1]);

		return response()->json([
			'success' => true,
			'updated_count' => $updated
		]);
	}
	
	public function profileMarkMessagesAsRead(Request $request)
	{
		$profileUserId = $request->profile_user_id; // Profile user ID
		$senderId = $request->sender_id;

		// Mark messages as read from profile user's perspective
		$updated = Webmessage::where(function($query) use ($profileUserId, $senderId) {
			$query->where('sender_id', $senderId)
				  ->where('receiver_id', $profileUserId);
		})->where('is_read', 0)
		  ->update(['is_read' => 1]);

		return response()->json([
			'success' => true,
			'updated_count' => $updated
		]);
	}

}
