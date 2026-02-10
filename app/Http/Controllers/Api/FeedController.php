<?php

namespace App\Http\Controllers\Api;
use App\Http\Controllers\Api\BaseController as BaseController;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use App\Models\Feed;
use App\Models\FeedFollow;
use App\Models\FeedInterest;
use App\Models\FeedPost;
use App\Models\PostHashtags;
use App\Models\Hashtags;
use App\Models\Post;
use Illuminate\Support\Collection;

class FeedController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        try{
// 			$profileInterests = DB::table('profile_interests')
// 				->where('profile_id', $id)
// 				->pluck('interest_id');

			
// 			$matchingCommunities = DB::table('community_interests')
// 				->select('community_id')
// 				->whereIn('interest_id', $profileInterests)
// 				->groupBy('community_id')
// 				->get();

			
// 			$communitiesd = Community::with(['follow' => function ($query) use ($id) {
//         		$query->where('profile_id', $id);
//     		}, 'community_owner'])
// 				->whereIn('id', $matchingCommunities->pluck('community_id'))
// 				->orwhere('profile_id', $id)
// 				->get();
			
// 			$profile = Profile::with('community_list')->find($id);
//             $matchprofile = Profile::where('type',$profile->type)->pluck('id');
//             $matchingCommunitiess = Community::with(['follow' => function ($query) use ($id) {
//                 $query->where('profile_id', $id);
//     		}, 'community_owner'])->whereIn('profile_id', $matchprofile)->get();
            $feed =  Feed::with('profile_info','hashtags','posts','posts.total_likes','posts.comments','posts.comments.profile_info','posts.profile_info','follow')->where('profile_id',$id)->get();
			
            $matchingCommunities = $feed;
            return response()->json(['success'=>true,'message'=>'Feed Lists', 'feed_info' => $matchingCommunities],200);

        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }
    
    
    
    public function hashtags_list(Request $request)
    {
        try
        {
            if($request->search_text != '')
            {
                $query = $request->input('search_text');
                $Hashtags = Hashtags::select('hashtags.*','feeds.name as name','feeds.image as image')
                ->leftJoin('feeds', 'hashtags.feed_id', '=', 'feeds.id')->where('title', 'like', "%$query%")->get();
            }
            else
            {
                $Hashtags = Hashtags::select('hashtags.*','feeds.name as name','feeds.image as image')
                ->leftJoin('feeds', 'hashtags.feed_id', '=', 'feeds.id')->get();
            }
            return response()->json(['success'=>true,'message'=>'Hashtags Lists','feeds_info'=>$Hashtags],200);
        }
        catch(\Eception $e)
        {
            return $this->sendError($e->getMessage());    
        }
    }
    
    public function my_feed_list($id)
    {
        try{
            // Get  Feed IDs By Profile ID
            $idd = Feed::where('profile_id',$id)->get()->pluck('id')->toArray();
            
            //  Get Feed Ids By Profile PostHashtags match hashtags by profile ID
            $postid = PostHashtags::where('profile_id', $id)
                ->select('feed_id')
                ->distinct()
                ->orderBy('feed_id', 'desc') // Ensure to use a column present in the select list
                ->pluck('feed_id')->toArray();
            
            $feedids =     array_unique(array_merge($idd, $postid));
            // print_r($feedids);die;
            $data = Feed::with('follow','hashtags','interest','interest.detail')->whereIn('id',$feedids)->get();
            return response()->json(['success'=>true,'message'=>'My All Feed Lists','feeds_info'=>$data],200);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }
    
    public function all_feed_list()
    {
        try
        {
            $data = Feed::withCount('posts')->with('profile_info','hashtags','posts','posts.total_likes','posts.comments','posts.comments.profile_info','posts.profile_info','follow')->get();
            return response()->json(['success'=>true,'message'=>'Feed Lists','feeds_info'=>$data],200);
        }
        catch(\Eception $e)
        {
            return $this->sendError($e->getMessage());    
        }
    }
    
    public function post_by_feed(Request $request,$id)
    {
        try
        {
            // $feed = Feed::with('posts','posts.total_likes')->find($id);
            // $posts = $feed->posts()->with('post_images','post_videos','comments','profile_info')->withCount('total_likes')->paginate(10);
            
            $profileId = $request->profile_id;
            $feed = Feed::with('posts','posts.total_likes','posts.my_like')->find($id);
            $posts = $feed->posts()->with('hashtags.post_hashtags','comments','comments.profile_info','profile_info','my_like')->withCount('total_likes','comments')->distinct()->paginate(10);
            return response()->json(['success'=>true,'message'=>'Feed Detail','feeds_info'=>$posts],200);
        }
        catch(\Eception $e)
        {
            return $this->sendError($e->getMessage());    
        }
    }
    
    public function post_by_profile($id)
{
	try {
		$feedIds = PostHashtags::where('profile_id', $id)
			->distinct()->orderByDesc('feed_id')->pluck('feed_id');

		$posts = Feed::with('profile_info')->whereIn('id', $feedIds)->get()->flatMap(fn($feed) =>
			FeedPost::withCount([
					'likes as total_likes',
					'likes as thumb_count' => fn($q) => $q->where('type', 'thumb'),
					'likes as haha_count' => fn($q) => $q->where('type', 'haha'),
					'likes as sad_count' => fn($q) => $q->where('type', 'sad'),
					'likes as love_count' => fn($q) => $q->where('type', 'love'),
					'likes as surprised_count' => fn($q) => $q->where('type', 'surprised'),
				])
				->whereHas('postHashtags', fn($q) => $q->where('profile_id', $id)->where('feed_id', $feed->id))
				->with([
					'images',
					'videos',
					'profile_info',
					'comments.profile_info',
					'likes.profile_info', // Add this line
					'my_like' => fn($q) => $q->where('profile_id', $id)
				])
				->get()
				->each(function ($post) use ($feed) {
					$post->hashtags = Hashtags::whereIn('id',
						PostHashtags::where('post_id', $post->id)->pluck('hashtag_id')
					)->pluck('title')->toArray();
					$post->feed = $feed;

					$post->likes_grouped = [
						'thumb' => $post->likes->where('type', 'thumb')->values(),
						'haha' => $post->likes->where('type', 'haha')->values(),
						'sad' => $post->likes->where('type', 'sad')->values(),
						'love' => $post->likes->where('type', 'love')->values(),
						'surprised' => $post->likes->where('type', 'surprised')->values(),
					];
				})
		)->values();

		$community_post = Post::withCount([
				'likes as total_likes',
				'likes as thumb_count' => fn($q) => $q->where('type', 'thumb'),
				'likes as haha_count' => fn($q) => $q->where('type', 'haha'),
				'likes as sad_count' => fn($q) => $q->where('type', 'sad'),
				'likes as love_count' => fn($q) => $q->where('type', 'love'),
				'likes as surprised_count' => fn($q) => $q->where('type', 'surprised'),
			])
			->with([
				'my_like' => fn($q) => $q->where('profile_id', $id),
				'comments.profile_info',
				'post_images',
				'post_videos',
				'likes.profile_info', // Add this line
				'community_info.profile_info',
				'profile_info'
			])
			->where('profile_id', $id)
			->get()
			->each(function ($post) {
				$post->likes_grouped = [
					'thumb' => $post->likes->where('type', 'thumb')->values(),
					'haha' => $post->likes->where('type', 'haha')->values(),
					'sad' => $post->likes->where('type', 'sad')->values(),
					'love' => $post->likes->where('type', 'love')->values(),
					'surprised' => $post->likes->where('type', 'surprised')->values(),
				];
			});

		return response()->json([
			'success' => true,
			'message' => 'All Post List',
			'post_list' => $posts,
			'community_post_list' => $community_post
		]);
	} catch (\Exception $e) {
		return $this->sendError($e->getMessage());
	}
}




    
    public function detail($id)
    {
        try{
            $feedId = $id;

            $postid = PostHashtags::where('feed_id', $id)
                ->select('post_id')
                ->distinct()
                ->pluck('post_id');

            $posts = FeedPost::whereIn('id',$postid)->get();
            $feed = Feed::with(['posts','posts.comments','posts.comments.profile_info','posts.postHashtags','hashtags', 'profile_info'])->with(['posts' => function($query) {
                $query->withCount('total_likes');
                $query->withCount('comments');
            }])->find($id);

            $feed['posts'] = $posts;
                
            return response()->json(['success'=>true,'message'=>'Feed Detail','feeds_info'=>$feed],200);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
        
    }
    
    public function feed_post_list($id)
    {
        try
        {
            $feedId = $id;
            $postid = PostHashtags::where('feed_id', $id)
                ->select('post_id')
                ->distinct()
                ->pluck('post_id');

            $posts = FeedPost::withCount('total_likes','comments')
            ->with('my_like','profile_info','videos','images','comments','comments.profile_info')->whereIn('id',$postid)->paginate(10);
            // $feed = Feed::with(['posts','posts.comments','posts.comments.profile_info','posts.postHashtags','hashtags', 'profile_info'])->with(['posts' => function($query) {
            //     $query->withCount('total_likes');
            //     $query->withCount('comments');
            // }])->find($id);

            // $feed['posts'] = $posts;
                
            return response()->json(['success'=>true,'message'=>'Feed Post Lists','feeds_post_list'=>$posts],200);
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
        
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
    
    public function feed_follow(Request $request)
    {
        try{
            $validator = Validator::make($request->all(), [
                'profile_id' => 'required',
                'feed_id' => 'required',
            ]);      
            
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first(),500);
            }

            $feeed = FeedFollow::where('profile_id',$request->profile_id)->where('id' ,$request->feed_id)->first();
            if($feeed)
            {
                $feeed->delete();
            }
            else
            {
                $userp = FeedFollow::create([
                    'profile_id' => $request->profile_id,
                    'feed_id' => $request->feed_id,
                ]);
            }

            return response()->json(['success'=>true,'message'=>'Request Successfully'],200);
            
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // return $request->hashtags;
        // print_r($request->all());die;
        try{
            $validator = Validator::make($request->all(), [
                'profile_id' => 'required',
                'name' => 'required',
                'hashtags' => 'required',			
                //'description' => 'required',			
                'image' => 'image|mimes:jpeg,png,jpg,bmp,gif,svg|max:2048',
            ]);      
            
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first(),500);
            }
            
            $fileName = null;
            if($request->hasFile('image')) 
            {
                $file = request()->file('image');
                $fileName = md5($file->getClientOriginalName() . time()) .'.' . $file->getClientOriginalExtension();
                $file->move('uploads/feed/', $fileName);  
                $profile = asset('uploads/feed/'.$fileName);
            }

            $input = $request->except(['hashtags','interest'],$request->all());

            // $input = $request->all();
            $input['profile_id'] = $request->profile_id;
            $input['name'] = $request->name;
            // $input['hashtags'] = ;
            $input['description'] = $request->description;
            $input['image'] = 'uploads/feed/'.$fileName;
        
            $userp = Feed::create($input);
            FeedInterest::create([
                'feed_id' => $userp->id,
                'interest_id' => $request->interest,
            ]);

            foreach($request->hashtags as $key => $row)
            {
                Hashtags::create([
                    'feed_id' => $userp->id,
                    'title' => $row,
                ]);
            }

            return response()->json(['success'=>true,'message'=>'Feed Create Successfully'],200);
            
        }
        catch(\Eception $e){
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
        try{
            $validator = Validator::make($request->all(), [
                'profile_id' => 'required',
                'name' => 'required',
                'hashtags' => 'required',			
                'image' => 'image|mimes:jpeg,png,jpg,bmp,gif,svg|max:2048',
            ]);      
            
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first(),500);
            }
            $feed = Feed::find($id);
            
            $fileName = $feed->image;
            if($request->hasFile('image')) 
            {
				\File::delete(asset('uploads/feed/'.$feed->image));
                
				$file = request()->file('image');
                $fileName = md5($file->getClientOriginalName() . time()) .'.' . $file->getClientOriginalExtension();
                $file->move('uploads/feed/', $fileName);  
                //$profile = asset('uploads/feed/'.$fileName);
				$feed->image = 'uploads/feed/'.$fileName;
            }

            // $input = $request->except(['hashtags','interest'],$request->all());

            $feed->profile_id = $request->profile_id;
            $feed->name = $request->name;
            $feed->description = $request->description;
            
            $feed->save();

            $feedinterest = FeedInterest::where('feed_id',$id)->first();
            $feedinterest->update([
                'interest_id' => $request->interest,
            ]);

            Hashtags::where('feed_id',$id)->delete();
            foreach($request->hashtags as $key => $row)
            {
                Hashtags::create([
                    'feed_id' => $id,
                    'title' => $row,
                ]);
            }

            return response()->json(['success'=>true,'message'=>'Feed Create Successfully'],200);
            
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try
        {
            $feed = Feed::find($id);
            $feed->delete();
            return response()->json(['success'=>true,'message'=>'Feed Delete Successfully'],200);       
        }
        catch(\Eception $e){
            return $this->sendError($e->getMessage());    
        }
    }
}
