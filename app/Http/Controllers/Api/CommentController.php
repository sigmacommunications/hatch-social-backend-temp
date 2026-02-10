<?php

namespace App\Http\Controllers\Api;
use App\Http\Controllers\Api\BaseController as BaseController;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Comment;
use App\Models\Profile;
use App\Models\Post;
use App\Models\FeedPost;
use App\Models\StreamingComment;
use App\Notifications\GeneralNotification;
use App\Models\FeedComment;
use Validator;
use Auth;
use App\Services\FirebaseService;



class CommentController extends BaseController
{
	protected $firebaseService;

    public function __construct(FirebaseService $firebaseService)
    {
        $this->firebaseService = $firebaseService;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        try{
            $validator = Validator::make($request->all(), [
                'post_id' => 'required|exists:posts,id',
                'profile_id' => 'required|exists:profiles,id',
                'description' => 'required|string',
            ]); 
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first(),500);
            }
            $input = $request->except(['_token'],$request->all());
            $input['profile_id'] = $request->profile_id;
            $data = Comment::create($input);
			
			$post = Post::find($request->post_id);
			$user = Profile::find($post->profile_id);
			
			//firebase notification send
			$body = $data->profile_info->name .' comment on your post';
			$title = $data->profile_info->name;
			$fcmToken = $user->device_token;
			$response = $this->firebaseService->sendNotification($fcmToken, $title, $body);
			//end
			$user->notify(new GeneralNotification([
				'profile_id' => $post->profile_id,
				'type' => 'community_comment',
				'post_id' => $data->post_id,
				'sender_id' => $request->profile_id,
				'comment_id' => $data->id,
				'message' => "{$data->profile_info->name} commented on your post",
			]));
            return response()->json(['success'=>true,'message'=>'Your Comment has bees post','data'=>$data]);

        }catch(\Eception $e){
            return $this->sendError($e->getMessage());

        }
    }
	
	
	public function stream_comment(Request $request)
    {
        try{
            $validator = Validator::make($request->all(), [
                'room_id' => 'required|exists:chat_room,room_id',
           ]); 
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first(),500);
            }
			
            $input = $request->all();
            $input['user_id'] = Auth::id();
			$input['user'] = json_encode($request->user);
            $data = StreamingComment::create($input);
            return response()->json(['success'=>true,'message'=>'Your Comment has bees post','data'=>$data]);

        }catch(\Eception $e){
            return $this->sendError($e->getMessage());

        }
    }
	
	public function stream_comment_list($id)
    {
        try{
            $data = StreamingComment::where('room_id',$id)->get();
            return response()->json(['success'=>true,'message'=>'Comment List','data'=>$data]);

        }catch(\Eception $e){
            return $this->sendError($e->getMessage());

        }
    }

    
    public function feed_post_comment(Request $request)
    {
        try{
            $validator = Validator::make($request->all(), [
                'post_id' => 'required|exists:feed_posts,id',
                'profile_id' => 'required|exists:profiles,id',
                'description' => 'required|string',
            ]); 
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first(),500);
            }
            $input = $request->except(['_token'],$request->all());
            $input['profile_id'] = $request->profile_id;
            $data = FeedComment::create($input);
			
			$post = FeedPost::find($request->post_id);
			$user = Profile::find($post->profile_id);
			$user->notify(new GeneralNotification([
				'profile_id' => $post->profile_id,
				'type' => 'feed_comment',
				'post_id' => $data->post_id,
				'sender_id' => $request->profile_id,
				'comment_id' => $data->id,
				'message' => "{$data->profile_info->name} commented on your post",
			]));
            return response()->json(['success'=>true,'message'=>'Your Comment has bees post','data'=>$data]);

        }catch(\Eception $e){
            return $this->sendError($e->getMessage());

        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $comment = Comment::find($id);
        $comment->delete();
        
        return response()->json(['success'=>true,'message'=>'Comment Delete']);
    }
    
    
    
    public function feed_post_comment_delete($id)
    {
        $comment = FeedComment::find($id);
        $comment->delete();

        return response()->json(['success'=>true,'message'=>'Comment Delete']);
    }

}
