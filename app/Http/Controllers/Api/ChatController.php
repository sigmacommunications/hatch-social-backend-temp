<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Chat;
use App\Models\Message;
use App\Models\Profile;
use App\Services\FirebaseService;

class ChatController extends Controller
{
	protected $firebaseService;

    public function __construct(FirebaseService $firebaseService)
    {
        $this->firebaseService = $firebaseService;
    }

    public function sendMessage(Request $request)
	{
		$senderId = $request->sender_id;
		$receiverId = $request->receiver_id;

		// ✅ Check if chat exists between sender and receiver
		$chat = Chat::where(function ($query) use ($senderId, $receiverId) {
			$query->where('sender_id', $senderId)
				  ->where('receiver_id', $receiverId);
		})->orWhere(function ($query) use ($senderId, $receiverId) {
			$query->where('sender_id', $receiverId)
				  ->where('receiver_id', $senderId);
		})->first();

		// ✅ If chat doesn't exist, create a new chat
		if (!$chat) {
			$chat = Chat::create([
				'sender_id' => $senderId,
				'receiver_id' => $receiverId,
				'message_count' => 1,
				'status' => 'pending'
			]);
		}

		// ✅ Create the message
		$message = Message::create([
			'chat_id' => $chat->id,
			'sender_id' => $senderId,
			'receiver_id' => $receiverId,
			'text' => $request->text,
			'user' => json_encode($request->user),
		]);

		$fuser = Profile::find($receiverId);
		$user = Profile::find($senderId);
		$body = 'you have new message from ' . $user->name;
		$title = $user->name;
		$fcmToken = $fuser->device_token;
		try {
			$this->firebaseService->sendNotification($fcmToken, $title, $body);
		} catch (\Exception $fcmError) {
			// Agar notification fail ho to continue kare
		}
		//$response = $this->firebaseService->sendNotification($fcmToken, $title, $body);

		return response()->json([
			'status' => 'success',
			'message' => 'Message sent successfully!',
			'data' => $message
		]);
	}


	public function chat_status(Request $request)
	{
		$senderId = $request->sender_id;
		$receiverId = $request->receiver_id;
		$chatId = $request->chat_id;

		// ✅ Check if chat exists between sender and receiver
		$chat = Chat::find($chatId);
		$chat->status = 'active';
		//$caht->message_count = 2;
		$chat->save();

		// ✅ Create the message
		$message = Message::create([
			'chat_id' => $chat->id,
			'sender_id' => $senderId,
			'receiver_id' => $receiverId,
			'text' => $request->text,
			'user' => json_encode($request->user),
		]);

		return response()->json([
			'status' => 'success',
			'message' => 'Message sent successfully!',
			'data' => $message
		]);

	}

	public function message_list(Request $request,$id)
	{
		//$sender_id = $request->sender_id;
		//$receiver_id = $request->receiver_id;

		//$messages = Chat::where(function($query) use ($sender_id, $receiver_id) {
		//	$query->where('sender_id', $sender_id)->where('receiver_id', $receiver_id);
		//})->orWhere(function($query) use ($sender_id, $receiver_id) {
		//	$query->where('sender_id', $receiver_id)->where('receiver_id', $sender_id);
		//})->orderBy('created_at', 'asc')->get();
		//$messages = Message::where('chat_id',$id)->get();

		$messages = Message::where('chat_id', $id)
        ->where(function ($query) use ($id) {
            $query->whereNull('deleted_for') // Messages that are not deleted
                  ->orWhereJsonDoesntContain('deleted_for', $id); // Messages that current user has not deleted
        })
        ->orderBy('created_at', 'asc')
        ->get();

		return response()->json([
			'status' => 'success',
			'message' => 'Message send successfully',
			'data' => $messages
		]);
	}

	public function conversations_list($id)
	{
		$authUserId = $id; // Current authenticated user ID

		$chats = Chat::with([
			'message',
			'sender' => function ($query) {
				$query->select('id', 'name','photo');
			},
			'receiver' => function ($query) {
				$query->select('id', 'name','photo');
			}
		])
		->where(function ($query) use ($authUserId) {
			$query->where('sender_id', $authUserId)
				  ->orWhere('receiver_id', $authUserId);
		})
		->get()
		->map(function ($chat) use ($authUserId) {
			// Set related user (opposite of authenticated user)
			$chat->relatedUser = ($chat->sender_id == $authUserId) ? $chat->receiver : $chat->sender;
			return $chat;
		});

//		$chats = Chat::with([
//				Chat::where('sender_id', $id)->exists() ? 'receiver' : 'sender'

//		,'message'])->where('sender_id', $id)->orWhere('receiver_id', $id)->orderBy('created_at', 'asc')->get();
		return response()->json([
			'status' => 'success',
			'message' => 'Chat Lists',
			'data' => $chats
		]);
	}

	public function message_delete(Request $request,$id)
	{
		$userId = $request->profile_id; // Current user
		$message = Message::findOrFail($id);

		// Check existing deleted users
		$deletedFor = $message->deleted_for ?? [];
		$deletedFor[] = $userId;
		$message->deleted_for = array_unique($deletedFor);
		$message->save();
		// If both users deleted, remove message permanently
		if (in_array($message->sender_id, $deletedFor) && in_array($message->receiver_id, $deletedFor)) {
			$message->delete();
			return response()->json(['message' => 'Message deleted permanently']);
		}

		return response()->json(['message' => 'Message delete for you']);
	}

	public function chat_delete(Request $request,$id)
	{
		$userId = $request->profile_id; // Current user
		$messages = Message::where('chat_id',$id)->get();

		foreach($messages as $message)
		{
			$deletedFor = $message->deleted_for ?? [];
			$deletedFor[] = $userId;
			$message->deleted_for = array_unique($deletedFor);
			$message->save();
			// If both users deleted, remove message permanently
			if (in_array($message->sender_id, $deletedFor) && in_array($message->receiver_id, $deletedFor)) {
				$message->delete();
				$chat = Chat::find($id);
				$chat->delete();
				return response()->json(['message' => 'Chat deleted permanently']);
			}
		}

		return response()->json(['message' => 'Chat Delete For You']);
	}
}
