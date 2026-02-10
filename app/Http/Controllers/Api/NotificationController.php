<?php

namespace App\Http\Controllers\Api;
use App\Http\Controllers\Api\BaseController as BaseController;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Profile;
use App\Models\Community;
use App\Models\FeedPost;
use App\Models\Post;
use App\Models\PostHashtags;
use App\Models\Hashtags;
use App\Models\Feed;

class NotificationController extends BaseController
{
    public function index(Request $request, $id)
	{
		$user = Profile::find($id);

		$notifications = $user->notifications->map(function ($notification) use ($id) {
			$data = $notification->data;
			$sender = Profile::find($data['sender_id'] ?? null);
			$data['sender'] = $sender ? [
				'id' => $sender->id,
				'name' => $sender->name,
				'email' => $sender->email,
				'photo' => $sender->photo ?? null,
			] : null;

			if ($data['type'] == 'community_comment' || $data['type'] == 'community_like') 
			{
				$post = Post::withCount([
					'likes as total_likes',
					'likes as thumb_count' => fn($q) => $q->where('type', 'thumb'),
					'likes as haha_count' => fn($q) => $q->where('type', 'haha'),
					'likes as sad_count' => fn($q) => $q->where('type', 'sad'),
					'likes as love_count' => fn($q) => $q->where('type', 'love'),
					'likes as surprised_count' => fn($q) => $q->where('type', 'surprised'),
					'total_likes', 'comments'
				])->with(['post_images','post_videos','comments.profile_info','my_like','likes.profile_info'])
				->find($data['post_id']);

				if ($post) 
				{
					$data['community_post'] = $post;
					$data['community_post']['community_info'] = Community::find($post->community_id);
					$data['community_post']['likes_grouped'] = [
						'thumb' => $post->likes->where('type', 'thumb')->values(),
						'haha' => $post->likes->where('type', 'haha')->values(),
						'sad' => $post->likes->where('type', 'sad')->values(),
						'love' => $post->likes->where('type', 'love')->values(),
						'surprised' => $post->likes->where('type', 'surprised')->values(),
					];
				}
			}
			if ($data['type'] == 'feed_comment' || $data['type'] == 'feed_like') {
				$post = FeedPost::withCount([
					'likes as total_likes',
					'likes as thumb_count' => fn($q) => $q->where('type', 'thumb'),
					'likes as haha_count' => fn($q) => $q->where('type', 'haha'),
					'likes as sad_count' => fn($q) => $q->where('type', 'sad'),
					'likes as love_count' => fn($q) => $q->where('type', 'love'),
					'likes as surprised_count' => fn($q) => $q->where('type', 'surprised'),
					'total_likes', 'comments'
				])->with([
					'images',
					'videos',
					'comments.profile_info',
					'my_like',
					'profile_info',
					'likes.profile_info'
				])->find($data['post_id']);

				if ($post) {
					// Find the feed this post belongs to
					$postHashtag = PostHashtags::where('post_id', $post->id)
						->where('profile_id', $id)
						->first();

					if ($postHashtag && $postHashtag->feed_id) {
						$feed = Feed::with('profile_info')->find($postHashtag->feed_id);

						if ($feed) {
							$hashtags = Hashtags::whereIn('id',PostHashtags::where('post_id', $post->id)->pluck('hashtag_id'))
								->pluck('title')->toArray();

							$feed->hashtags = $hashtags;
							$post->feed = $feed;
						}
					}

					$post->likes_grouped = [
						'thumb' => $post->likes->where('type', 'thumb')->values(),
						'haha' => $post->likes->where('type', 'haha')->values(),
						'sad' => $post->likes->where('type', 'sad')->values(),
						'love' => $post->likes->where('type', 'love')->values(),
						'surprised' => $post->likes->where('type', 'surprised')->values(),
					];

					$data['feed_post'] = $post;
				}
			}

			if ($data['type'] == 'community' || $data['type'] == 'community product add') {
				$community = Community::find($data['community_id']);
				$data['community_info'] = $community;
			}

			return [
				'id' => $notification->id,
				'type' => $notification->type,
				'notifiable_type' => $notification->notifiable_type,
				'notifiable_id' => $notification->notifiable_id,
				'data' => $data,
				'read_at' => $notification->read_at,
				'created_at' => $notification->created_at,
				'updated_at' => $notification->updated_at,
			];
		});

		return response()->json([
			'success' => true,
			'message' => 'Notification List',
			'notification_list' => $notifications,
		]);
	}

	public function markAsRead(Request $request)
	{
		$request->validate([
			'notification_id' => 'nullable|exists:notifications,id',
			'profile_id' => 'required|exists:profiles,id',
		]);

		$user = Profile::find($request->profile_id);

		if ($request->notification_id) {
			// single notification read
			$notification = $user->notifications()->where('id', $request->notification_id)->first();
			if ($notification) {
				$notification->markAsRead();
				return response()->json([
					'status' => true,
					'message' => 'Notification marked as read successfully',
				]);
			}
		} else {
			// all notifications read
			$user->unreadNotifications->each->markAsRead();
			return response()->json([
				'status' => true,
				'message' => 'All notifications marked as read successfully',
			]);
		}
	}

}
