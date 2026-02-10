  <?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AgoraController;
use App\Http\Controllers\Api\ChatController;
use App\Http\Controllers\Api\ChatroomController;
use App\Http\Controllers\Api\NotificationController;
use App\Http\Controllers\Api\CommunityStreamingController;
use App\Http\Controllers\Api\ReportController;
use App\Http\Controllers\Auth\GoogleController;


 


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::post('/registeruserwithchatapptoken', [AgoraController::class, 'registeruserwithchatapptoken']);





Route::get('/clear-cache', function () {
    //Artisan::call('make:model Community-m');
    return 'Cache cleared successfully.';
});

Route::post('saad', [\App\Http\Controllers\Api\UserController::class, 'saad']);


Route::get('cron', [\App\Http\Controllers\Api\RegisterController::class, 'cron'])->name('cron');

Route::get('recurring/plane', [\App\Http\Controllers\Api\RegisterController::class, 'recurring_plan'])->name('recurring_plan');
Route::get('cron/plane', [\App\Http\Controllers\Api\RegisterController::class, 'cron_plane'])->name('cron_plane');

Route::post('register', [\App\Http\Controllers\Api\RegisterController::class, 'register']);
Route::get('noauth', [\App\Http\Controllers\Api\RegisterController::class, 'noauth'])->name('noauth');
 

Route::any('login', [\App\Http\Controllers\Api\RegisterController::class, 'login']);    
Route::post('/google-login', [GoogleController::class, 'login']);
Route::post('verify', [\App\Http\Controllers\Api\RegisterController::class, 'verify']);
Route::post('password/email',  [\App\Http\Controllers\Api\ForgotPasswordController::class,'forget']);
Route::any('password/reset', [\App\Http\Controllers\Api\CodeCheckController::class,'index']);
Route::post('password/code/check', [\App\Http\Controllers\Api\CodeCheckController::class,'code_verify']);
//Route::get('guide', [\App\Http\Controllers\Api\CMSController::class, 'guide']);
//Route::get('term/conditions', [\App\Http\Controllers\Api\CMSController::class, 'termanscondition']);

Route::group(['middleware' => ['auth:sanctum'], 'prefix' => 'auth'], function () {	
	
	//agora live stram record start
	Route::post('/agora/acquire', [AgoraController::class, 'acquire']);
	Route::post('/agora/start', [AgoraController::class, 'start']);
	Route::post('/agora/stop', [AgoraController::class, 'stop']);
	//end
	
	
	
	Route::post('/generate-rtc-token/{profile_id}', [ChatroomController::class, 'rtc_token']);
	
	Route::get('/notification-list/{profile_id}', [NotificationController::class, 'index']);
	Route::post('/notifications/read', [NotificationController::class, 'markAsRead']);
	Route::get('/chatroom-message-list/{chatroom_id}', [ChatroomController::class, 'message_list']);
	Route::post('/payment-mail', [\App\Http\Controllers\Api\CommunityController::class, 'payment_mail']);
	Route::post('/chatroom-send-message/{chatroom_id}', [ChatroomController::class, 'sendMessage']);
	
	Route::post('/chatroom/create', [ChatroomController::class, 'store']);
	Route::post('/chatroom/delete/{chatroomid}', [ChatroomController::class, 'delete']);
	Route::post('/chatroom/user/add', [ChatroomController::class, 'user_add']);
	
	Route::get('/conversations-list/{profileid}', [ChatController::class, 'conversations_list']);
	Route::post('/send-message', [ChatController::class, 'sendMessage']);
	Route::post('/chat-status', [ChatController::class, 'chat_status']);
	Route::post('/message-delete/{messageid}', [ChatController::class, 'message_delete']);
	Route::post('/chat-delete/{chatid}', [ChatController::class, 'chat_delete']);
	Route::get('/message-list/{chatid}', [ChatController::class, 'message_list']);
	Route::get('community_by_roles/{id}', [\App\Http\Controllers\Api\CommunityController::class,'community_by_roles']);
	Route::post('community_delete/{profile_id}', [\App\Http\Controllers\Api\CommunityController::class,'multiDestroy']);
	Route::get('home_multiple_community/{id}', [\App\Http\Controllers\Api\CommunityController::class,'home_multi_community']);
	Route::get('community_out/{id}', [\App\Http\Controllers\Api\CommunityController::class,'community_out']);
	Route::post('/products', [\App\Http\Controllers\Api\ProductController::class, 'addProduct']);
    Route::post('/products/{productID}', [\App\Http\Controllers\Api\ProductController::class, 'UpdateProduct']);
	Route::get('/products/{community_id}', [\App\Http\Controllers\Api\ProductController::class, 'listProducts']);
    Route::delete('/products/{productID}', [\App\Http\Controllers\Api\ProductController::class, 'DeleteProduct']);
	Route::resource('profile', \App\Http\Controllers\Api\ProfileController::class);
	Route::post('change_passcode/{id}', [\App\Http\Controllers\Api\ProfileController::class, 'change_passcode']); 
	Route::resource('post', \App\Http\Controllers\Api\PostController::class);
	Route::post('bunny_post', [\App\Http\Controllers\Api\PostController::class,'bunny_post']);
	Route::get('post_video_list/{id}', [\App\Http\Controllers\Api\PostController::class,'show_video']);
	Route::get('pending_post/{id}', [\App\Http\Controllers\Api\PostController::class,'pending_post']);
	Route::post('pending_post_update/{id}', [\App\Http\Controllers\Api\PostController::class,'pending_post_update']);
	Route::post('feed', [\App\Http\Controllers\Api\FeedController::class,'store']);
	Route::post('feed/{id}', [\App\Http\Controllers\Api\FeedController::class,'update']);
	Route::delete('feed/{id}', [\App\Http\Controllers\Api\FeedController::class,'destroy']);

    // Feed Urls
	Route::post('post-feed', [\App\Http\Controllers\Api\FeedPostController::class,'store']);
	Route::delete('post-feed/{postid}', [\App\Http\Controllers\Api\FeedPostController::class,'destroy']);
	Route::post('hashtags_list', [\App\Http\Controllers\Api\FeedController::class,'hashtags_list']);
    Route::get('all-feed-list', [\App\Http\Controllers\Api\FeedController::class,'all_feed_list']);
    Route::get('post-by-feed/{id}', [\App\Http\Controllers\Api\FeedController::class,'post_by_feed']);
	Route::get('post-by-profile/{id}', [\App\Http\Controllers\Api\FeedController::class,'post_by_profile']);
    Route::post('show-feed', [\App\Http\Controllers\Api\FeedController::class,'index']);
	Route::post('feed-follow', [\App\Http\Controllers\Api\FeedController::class,'feed_follow']); 
    Route::post('feed_post_like', [\App\Http\Controllers\Api\PostController::class,'feed_post_like']);
    Route::post('feed_post_comment', [\App\Http\Controllers\Api\CommentController::class,'feed_post_comment']); 
    Route::delete('feed_post_comment/{commintID}', [\App\Http\Controllers\Api\CommentController::class,'feed_post_comment_delete']); 
	
    Route::post('post_like', [\App\Http\Controllers\Api\PostController::class,'like']);
	Route::get('post_video_detail/{id}', [\App\Http\Controllers\Api\PostController::class,'video_play']);
	Route::resource('event', \App\Http\Controllers\Api\EventController::class);
	Route::resource('streaming', \App\Http\Controllers\Api\CommunityStreamingController::class);
	Route::get('stream_users', [\App\Http\Controllers\Api\CommunityStreamingController::class,'stream_users']);
	
	Route::post('streaming_comment', [\App\Http\Controllers\Api\CommentController::class,'stream_comment']);
	Route::get('stream_comment_list/{roomid}', [\App\Http\Controllers\Api\CommentController::class,'stream_comment_list']);
	
	
    Route::post('event_join', [\App\Http\Controllers\Api\EventController::class, 'event_join']);
	//Route::resource('profileqa', \App\Http\Controllers\Api\ProfileQAController::class);
    Route::post('profile_login', [\App\Http\Controllers\Api\ProfileController::class, 'login']);
    Route::post('update-post-by-feed/{id}', [\App\Http\Controllers\Api\FeedController::class,'update_post_by_feed']);
    Route::get('my-feed-list/{id}', [\App\Http\Controllers\Api\FeedController::class,'my_feed_list']);
    Route::get('feed-detail/{id}', [\App\Http\Controllers\Api\FeedController::class,'detail']);
    Route::get('feed-post-list/{id}', [\App\Http\Controllers\Api\FeedController::class,'feed_post_list']);
    
	Route::get('interest_list', [\App\Http\Controllers\Api\InterestController::class, 'index']);
	Route::get('interest_detail/{interestid}', [\App\Http\Controllers\Api\InterestController::class, 'show']);
    Route::get('member', [\App\Http\Controllers\Api\ProfileController::class, 'member_list']);
    Route::post('member_search', [\App\Http\Controllers\Api\ProfileController::class, 'search']);
    Route::post('search', [\App\Http\Controllers\Api\CommunityController::class, 'search']);

    //Route::resource('interest', \App\Http\Controllers\Api\InterestController::class); 
    // Route::resource('bubble', \App\Http\Controllers\Api\BubbleController::class); 
	Route::post('report', [\App\Http\Controllers\Api\PostController::class,'report']); 
    Route::get('reports', [ReportController::class,'index']);
	Route::post('community_multi_request', [\App\Http\Controllers\Api\CommunityController::class,'multi_request']); 
	Route::post('community_member/add', [\App\Http\Controllers\Api\CommunityController::class,'member_add']); 
	Route::get('community_member/my_pending_list/{id}', [\App\Http\Controllers\Api\CommunityController::class,'community_member_my_pending_list']); 
	Route::get('community_member/pending_list/{id}', [\App\Http\Controllers\Api\CommunityController::class,'community_member_pending_list']); 
	Route::post('community_member/pending_list/{id}', [\App\Http\Controllers\Api\CommunityController::class,'community_member_pending_update']); 
	Route::delete('community_member/remove/{id}', [\App\Http\Controllers\Api\CommunityController::class,'community_member_remove']); 
	Route::get('community_member/list/{id}', [\App\Http\Controllers\Api\CommunityController::class,'community_member_list']); 

    Route::resource('community', \App\Http\Controllers\Api\CommunityController::class); 
	Route::get('package_list', [\App\Http\Controllers\Api\PackageController::class,'package_list']);
    Route::get('community_list/{id}', [\App\Http\Controllers\Api\CommunityController::class,'indexx']); 
	Route::post('community_update/{id}', [\App\Http\Controllers\Api\CommunityController::class,'update']); 
	Route::post('community_member_admin', [\App\Http\Controllers\Api\CommunityController::class,'member_admin']); 
    Route::get('my_community/{id}', [\App\Http\Controllers\Api\CommunityController::class,'my_communities']); 
	Route::get('my_all_communities/{id}', [\App\Http\Controllers\Api\CommunityController::class,'my_all_communities']);
    Route::get('community_interest/{id}', [\App\Http\Controllers\Api\CommunityController::class,'community_interest']); 
    Route::get('community_detail/{id}', [\App\Http\Controllers\Api\CommunityController::class,'detail']); 
    Route::resource('comment', \App\Http\Controllers\Api\CommentController::class); 
	Route::post('subscribe', [\App\Http\Controllers\Api\ProfileController::class,'subscribe']); 
	Route::post('unsubscribe', [\App\Http\Controllers\Api\ProfileController::class,'unsubscribe']);
	Route::post('subscription', [\App\Http\Controllers\Api\UserController::class,'subscription']);

	Route::post('interest', [\App\Http\Controllers\Api\ProfileController::class,'interest']); 
	Route::post('purchase_interest', [\App\Http\Controllers\Api\ProfileController::class,'purchase_interest']);
	Route::get('interest/{profile_id}', [\App\Http\Controllers\Api\ProfileController::class,'profile_interests']);
	Route::get('interest/{profile_id}/{interestid}', [\App\Http\Controllers\Api\ProfileController::class,'recommand_community_by_profile_interests']);
	Route::post('logout', [\App\Http\Controllers\Api\ProfileController::class,'logout']); 

    
    Route::post('addcard', [\App\Http\Controllers\UserCardController::class, 'addcard']);
	Route::post('updatecard', [\App\Http\Controllers\UserCardController::class, 'updatecard']); 
    Route::get('me', [\App\Http\Controllers\Api\RegisterController::class, 'me']);
	Route::get('profile_me/{profileid}', [\App\Http\Controllers\Api\RegisterController::class, 'profile_me']);
    // Route::get('user', [\App\Http\Controllers\Api\RegisterController::class, 'user']);
    // Route::get('orders', [\App\Http\Controllers\Api\OrderController::class, 'orders']);
    // Route::get('children_orders', [\App\Http\Controllers\Api\OrderController::class, 'childorders']);
    // Route::post('order/{status}', [\App\Http\Controllers\Api\OrderController::class, 'orders_status']);
    Route::get('transaction', [\App\Http\Controllers\TranasactionController::class, 'index']);
    Route::post('googlepaytest', [\App\Http\Controllers\UserCardController::class, 'googlepaytest']);
    // Route::post('withdraw', [\App\Http\Controllers\TranasactionController::class, 'store']);
    // Route::get('withdraw/list', [\App\Http\Controllers\TranasactionController::class, 'index']);
    Route::post('change_password', [\App\Http\Controllers\Api\RegisterController::class, 'change_password']);
	Route::post('update_account', [\App\Http\Controllers\Api\UserController::class, 'update_account']);
	Route::post('current/plan', [\App\Http\Controllers\Api\UserController::class, 'current_plan']);
	Route::post('update/plan', [\App\Http\Controllers\Api\UserController::class, 'update_plan']);
	Route::post('interest_buy', [\App\Http\Controllers\Api\UserController::class, 'interest_buy']);
    // Route::get('financial/breakdowns/{date}', [\App\Http\Controllers\Api\FinancialController::class, 'financialdata']);
    // Route::post('financial/breakdowns/post', [\App\Http\Controllers\Api\FinancialController::class, 'financialpost']);
    // Route::get('admin/info', [\App\Http\Controllers\Api\ContactController::class, 'admininfo']);
    // Route::post('contact/submit', [\App\Http\Controllers\Api\ContactController::class, 'contact_info']);
    // Route::get('logout', [\App\Http\Controllers\Api\RegisterController::class, 'logout']);
});
