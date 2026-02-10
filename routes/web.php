<?php

use App\Http\Controllers\CommunityController;
use App\Http\Controllers\UsersController;
use App\Http\Controllers\SubscriptionController;
use App\Models\User;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\InterestController;
use Illuminate\Http\Request;
use App\Http\Controllers\CallController;
use App\Http\Controllers\Admin\EventController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ChatController;
use App\Http\Controllers\Admin\CouponController;

//use App\Http\Controllers\Admin\ProfileController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/





Route::get('/task', [App\Console\Commands\RecurringPayment::class, 'handle'])->name('handle');

Route::view('/call', 'agora_call');
Route::get('/custom-sucess', function () {
    return view('account_connect_payment_success'); //group join call
    //return view('audio'); // audio specific user call
});

Route::get('/delete-account', function () {
    return view('verify_email');
});

Route::post('/send-otp', [App\Http\Controllers\Auth\LoginController::class, 'sendOtpToVerifyEmail']);
Route::post('/verify-otp-delete', [App\Http\Controllers\Auth\LoginController::class, 'verifyOtpAndDeleteUser']);


// Route::get('/verify-email', function () {
//     return view('verify_email');
// });


Route::get('/delete-user', function () {
    $user = \App\Models\User::where('email',request('email'))->first();
	if($user)
	{
		$user->delete();
		return response()->json(['success'=> true,'message' =>'user deleted successfully']);
	}
	return response()->json(['success'=> false, 'message'=>'user not found']);
	
});


Route::get('/stripe/plans/{userid}', [SubscriptionController::class, 'getStripePlans']);
Route::post('/subscription', [SubscriptionController::class, 'checkoutBasic'])->name('subscription-basic');
Route::get('/subscribe/premium/{userid}', [SubscriptionController::class, 'checkoutPremium'])->name('subscribe.premium');
Route::post('/subscription/charge', [SubscriptionController::class, 'charge'])->name('subscription.charge');

// Route::get('/payment-success', [SubscriptionController::class, 'payment_Success'])->name('payment.success');
Route::get('/payment/success', [SubscriptionController::class, 'paymentSuccess'])->name('payment.success');



Route::get('/package-subscription/{userid}', [SubscriptionController::class, 'subscription_buy'])->name('subscription_buy');
Route::get('/withdrawRequest', [SubscriptionController::class, 'withdrawRequest'])->name('withdrawRequest');

Route::get('interest_buy/{userid}', [SubscriptionController::class, 'interest_buy']);
Route::get('community_join/{userid}', [SubscriptionController::class, 'community_join']);
Route::get('purchase_profile/{userid}', [SubscriptionController::class, 'purchase_profile']);



Route::post('/checkout', [UsersController::class, 'createCheckout'])->name('stripe.checkout');

//work start
//Route::get('/agora/video', function(){
//    return view('video'); //group join call
//});
//Route::post('/agora/token', [App\Http\Controllers\AgoraController::class, 'generateToken']);
//Route::post('/call/send', [App\Http\Controllers\AgoraController::class, 'sendCall']);
//Route::get('/call/check', [App\Http\Controllers\AgoraController::class, 'checkCall']);
//Route::post('/call/accept', [App\Http\Controllers\AgoraController::class, 'acceptCall']);
//Route::get('/call-status/{call_id}', [App\Http\Controllers\AgoraController::class, 'getCallStatus']);
//end

//test start

Route::get('/video-call', [CallController::class, 'index']);
Route::post('/call/initiate', [CallController::class, 'initiateCall']);
Route::get('/call/check', [CallController::class, 'checkCall']);
Route::post('/call/update/{id}', [CallController::class, 'updateStatus']);

//test end

Route::post('/call/end', [App\Http\Controllers\AgoraController::class, 'endCall']);

Route::get('/', [App\Http\Controllers\Auth\LoginController::class, 'login'])->name('login');
Route::get('/login', [App\Http\Controllers\Auth\LoginController::class, 'login'])->name('home_login');
Route::get('/admin', [App\Http\Controllers\Auth\LoginController::class, 'login'])->name('admin');
Route::post('/adminpost', [App\Http\Controllers\Auth\LoginController::class, 'admin'])->name('admin_post');



Route::group(['middleware' => ['auth']], function () {
    // User
    Route::resource('nests', App\Http\Controllers\Admin\CommunityController::class);

    // Mark messages as read
    Route::post('/mark-messages-read', [ChatController::class, 'markMessagesAsRead']);
    Route::get('users/profile/{user}', [ProfileController::class, 'index'])->name('profile.list');
    Route::get('/profiles', [ProfileController::class, 'index'])->name('admin.profiles.index');
    Route::get('/profiles/create', [ProfileController::class, 'create'])->name('admin.profiles.create');
    Route::post('/profiles', [ProfileController::class, 'store'])->name('admin.profiles.store');
    Route::get('/profiles/{profile}/edit', [ProfileController::class, 'edit'])->name('admin.profiles.edit');
    Route::put('/profiles/{profile}', [ProfileController::class, 'update'])->name('admin.profiles.update');
    Route::delete('/profiles/{profile}', [ProfileController::class, 'destroy'])->name('admin.profiles.destroy');
    Route::get('/user/profile/{id}', [ProfileController::class, 'show'])->name('profiles.show');
    Route::get('/profiles/chat/{id}', [App\Http\Controllers\DashboardController::class, 'profile_chat_list'])->name('profile_chat_list');
    Route::get('/profiles/wallet/{id}', [App\Http\Controllers\ProfileController::class, 'profile_wallet'])->name('profile_wallet');
    Route::post('/profiles/wallet-request/{id}', [App\Http\Controllers\ProfileController::class, 'profile_wallet_request'])->name('wallet.withdraw');
    Route::get('/check-stripe-status/{profileID}', [ProfileController::class, 'checkStatus'])->name('check.stripe.status');
    Route::post('/save-card/{profileid}', [ProfileController::class, 'saveCard'])->name('stripe.saveCard');
    Route::post('/save-membership', [ProfileController::class, 'saveMembership'])->name('stripe.saveMembership');
    Route::get('/profile-get-messages/{userid}', [ChatController::class, 'get_messages'])->name('get_message');
    Route::post('/profile-send-messages', [ChatController::class, 'profilesendMessage'])->name('profile-send-messages');
    Route::post('/profile-mark-messages-read', [ChatController::class, 'profileMarkMessagesAsRead']);
    Route::get('/profile/edit', [ProfileController::class, 'editSelf'])->name('admin.profile.edit');
    Route::put('/profile/update', [ProfileController::class, 'updateSelf'])->name('admin.profile.update');

    //coupon
    Route::get('/profiles/coupons/{profileid}', [CouponController::class, 'index'])->name('admin.coupons.index');
    Route::get('/profiles/coupons-create/{profileid}', [CouponController::class, 'create'])->name('admin.coupons.create');
    Route::post('/profiles/coupons-store/{profileid}', [CouponController::class, 'store'])->name('admin.coupons.store');
    Route::get('/coupons-edit/{coupon}/{profileid}', [CouponController::class, 'edit'])->name('admin.coupons.edit');
    Route::put('/coupons-update/{coupon}/{profileid}', [CouponController::class, 'update'])->name('admin.coupons.update');
    Route::delete('/coupons/{coupon}/{profileid}', [CouponController::class, 'destroy'])->name('admin.coupons.destroy');

    // Route::post('/upgrade/{id}', [UsersController::class, 'upgrade']);
});


//Route::delete('users/{user}/profile', [ProfileController::class, 'destroy'])
//    ->name('users.profile.destroy');

//End User


//Community
// Route::resource('community', CommunityController::class);


Route::group(['middleware' => ['auth', 'admin']], function () {
    Route::get('/dashboard', [App\Http\Controllers\UsersController::class, 'index'])->name('dashboard');
    Route::get('/chat', [App\Http\Controllers\DashboardController::class, 'chat_list'])->name('chat');
    Route::get('/get-messages/{userid}', [ChatController::class, 'get_messages'])->name('get_messages');
    Route::post('/send-messages', [ChatController::class, 'sendMessage'])->name('send.messages');
    Route::get('/chat/messages/table', [ChatController::class, 'messagesTable'])->name('admin.chat.messages.table');
    Route::put('/chat/messages/{message}', [ChatController::class, 'updateMessage'])->name('admin.chat.messages.update');
    Route::delete('/chat/messages/{message}', [ChatController::class, 'destroyMessage'])->name('admin.chat.messages.destroy');
    Route::resource('users', UsersController::class);
    Route::prefix('users-profile')->group(function () {
        Route::get('/{userid}', [UsersController::class, 'profiles'])->name('users.profile.index');
        Route::get('/{userid}/create', [UsersController::class, 'profileCreate'])->name('users.profile.create');
        Route::post('/store', [UsersController::class, 'profileStore'])->name('users.profile.store');
        Route::get('/edit/{id}', [UsersController::class, 'profileEdit'])->name('users.profile.edit');
        Route::put('/update/{id}', [UsersController::class, 'profileUpdate'])->name('users.profile.update');
        Route::delete('/delete/{id}', [UsersController::class, 'profileDestroy'])->name('users.profile.destroy');
    });
    Route::get('/users-nest/{profileid}', [UsersController::class, 'nest'])->name('users.nest.index');
    Route::post('/users/{id}/upgrade', [UsersController::class, 'upgrade']);
    Route::get('/hashtags', [UsersController::class, 'hashtags'])->name('hashtags');
    // Route::get('/negotiators/list', [App\Http\Controllers\DashboardController::class, 'negotiators_list'])->name('negotiators.list');
    // Route::get('/helper', [App\Http\Controllers\NotificationController::class, 'helper']);
    Route::resource('/notification', App\Http\Controllers\NotificationController::class);
    // Route::resource('/orders',App\Http\Controllers\OrdersController::class);
    // Route::resource('trophy',App\Http\Controllers\TrophyController::class);
    Route::resource('/interests', InterestController::class);
    Route::resource('reports', App\Http\Controllers\Admin\ReportController::class); 
    Route::get('post-detail/{postid}', [App\Http\Controllers\Admin\ReportController::class,'post_detail']);
    Route::post(
        '/admin/posts/{post}/toggle-status',
        [App\Http\Controllers\Admin\ReportController::class, 'toggleStatus']
    )->name('admin.posts.toggleStatus');
    // Route::resource('event', EventController::class);
    Route::resource('/shop', App\Http\Controllers\Admin\ProductController::class);
    Route::get('/payment-ledger', [App\Http\Controllers\Admin\DashboardController::class, 'payment_ledger']);
    Route::get('/home', [App\Http\Controllers\DashboardController::class, 'dashboard'])->name('home');
    //Route::get('/dashboard', [App\Http\Controllers\DashboardController::class, 'dashboard'])->name('dashboard');
    Route::get('/admin_info', [App\Http\Controllers\DashboardController::class, 'admin_info'])->name('admin_info');
    Route::post('/admin_info_post', [App\Http\Controllers\DashboardController::class, 'admin_info_post'])->name('admin_info_post');
    Route::post('/logout', [App\Http\Controllers\Auth\LoginController::class, 'logout'])->name('logout');
    Route::resource('guides', App\Http\Controllers\GuideController::class);
    Route::get('/terms/conditions', [App\Http\Controllers\TermAndConditionController::class, 'index'])->name('terms_conditions');
    Route::post('/terms-conditions', [App\Http\Controllers\TermAndConditionController::class, 'termandcontionpost'])->name('terms_conditions_post');
    Route::get('/transaction', [App\Http\Controllers\TranasactionController::class, 'transaction_list'])->name('transaction');
    Route::get('/transaction_status/{id}', [App\Http\Controllers\TranasactionController::class, 'transaction_status'])->name('transaction_status');
    Route::get('/transaction_status/{id}', [App\Http\Controllers\TranasactionController::class, 'transaction_status'])->name('transaction_status');

    Route::resource('package', \App\Http\Controllers\Admin\PackageController::class);
    Route::resource('feeds', \App\Http\Controllers\Admin\FeedController::class);
});
