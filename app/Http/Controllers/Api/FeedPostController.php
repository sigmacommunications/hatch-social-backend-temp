<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\BaseController as BaseController;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

use App\Models\Post;
use App\Models\FeedPost;
use App\Models\FeedPostLike;
use App\Models\PostImage;
use App\Models\FeedPostImage;
use App\Models\Community;
use App\Models\PostHashtags;
use App\Models\FeedPostVideo;
use App\Models\PostVideo;
use App\Models\Hashtags;
use Illuminate\Support\Facades\Http;

use Validator;
use Auth;

class FeedPostController extends BaseController
{
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
        try
        {
			//return ;
            $validator = Validator::make($request->all(), [
                'caption' => 'required|string',
                'profile_id' => 'required',		
				//'video' => 'max:15000',
				//'image' => 'max:15000',
            ]);  
            
            if($validator->fails())
            {
                return $this->sendError($validator->errors()->first(),500);
            }
           
            $input['profile_id'] = $request->profile_id;
            $input['caption'] = $request->caption;
            $input['type'] = $request->type;
            
            if($request->posttype == 'feed' )
            {
                $data = FeedPost::create($input);
                if($request->type == 'photo')
                {
                    if ($request->hasFile('file')) {
                        $uploadedFiles = $request->file('file');
                        $profileUrls = [];
                    
                        foreach ($uploadedFiles as $file) {
                            $fileName = md5($file->getClientOriginalName() . time()) . "Hatch-social." . $file->getClientOriginalExtension();
                            $filePath = $file->storeAs('uploads/feedpost', $fileName, 'public');
        					$profileUrls = Storage::url($filePath);
                            
                            FeedPostImage::create([
                                'post_id' => $data->id,
                                'name' => $profileUrls
                            ]);
                        }
                    }
                }
                else
                {
                    if ($request->hasFile('file')) {
                        $file = $request->file('file');
                        $VideoUrls = [];
                    
                        $createResponse = Http::withHeaders([
                            'AccessKey' => env('BUNNY_API_KEY')
                        ])->post("https://video.bunnycdn.com/library/".env('BUNNY_LIBRARY_ID')."/videos", [
                            'title' => $request->caption ?? 'My Video',
                        ]);

                        if (!$createResponse->successful()) {
                            return response()->json(['success' => false, 'message' => 'Failed to create video on Bunny'], 500);
                        }

                        $videoId = $createResponse['guid'];

                        $uploadResponse = Http::withHeaders([
                            'AccessKey' => env('BUNNY_API_KEY'),
                            'Content-Type' => 'application/octet-stream'
                        ])->withBody(
                            file_get_contents($file->getRealPath()),
                            'application/octet-stream'
                        )->put("https://video.bunnycdn.com/library/".env('BUNNY_LIBRARY_ID')."/videos/$videoId");

                        if (!$uploadResponse->successful()) {
                            return response()->json(['success' => false, 'message' => 'Bunny upload failed'], 500);
                        }
						
                        //$fileName = md5($file->getClientOriginalName() . time()) . "Hatch-social." . $file->getClientOriginalExtension();
                        //$filePath = $file->storeAs('uploads/feedpost', $fileName, 'public');
                        //$VideoUrls = Storage::url($filePath);
    
                        FeedPostVideo::create([
                            'post_id' => $data->id,
                            'name' => $videoId
                        ]);
                    }
                }
                
                foreach($request->hashtags as $hashtags)
                {
                    $hashtagss = Hashtags::where('title',$hashtags)->first();
                     if($hashtagss)
                     {
                        PostHashtags::create([
                            'post_id' => $data->id,
                            'feed_id' => $hashtagss->feed_id,
                            // 'comunity_id' => $request->community_id,
                            'hashtag_id' => $hashtagss->id,
                            'profile_id' => $request->profile_id,
                        ]);
                    }
                }
				return response()->json(['success'=>true,'message'=>'Post Create Successfully'],200);
            }
            else
            {
                foreach($request->community_id as $community_id)
                {
                    $community = Community::find($community_id);
                    if($community->privacy == 'yes' && $community->profile_id != $request->profile_id)
                    {
                        $input['status'] = 'pending';	
                    }
                    else
                    {
                        $input['status'] = 'active';
                    }

                    $input['profile_id'] = $request->profile_id;
                    $input['type'] = $request->type;
                    $input['community_id'] = $community_id;
                    $input['caption'] = $request->caption;
                    $input['hashtags'] = json_encode($request->hashtags);
                    
                    $data = Post::create($input);
                    
                    if($request->hasFile('image')) 
                    {
                        $uploadedFiles = $request->file('image');
                        $profileUrls = [];

                        foreach ($uploadedFiles as $file) 
                        {
                            //$fileName = md5($file->getClientOriginalName() . time()) . "Hatch-social." . $file->getClientOriginalExtension();
                            //$filePath = public_path('uploads/post/');
							//$file->move($filePath, $fileName);
                            //$profileUrls = 'uploads/post/' . $fileName;
							
							$fileName = md5($file->getClientOriginalName() . time()) . "Hatch-social." . $file->getClientOriginalExtension();
        					$filePath = $file->storeAs('uploads/post', $fileName, 'public');
        					$profileUrls = Storage::url($filePath);

                            PostImage::create([
                                'post_id' => $data->id,
                                'name' => $profileUrls
                            ]);
                        }
                    }
                    
                    if ($request->hasFile('file'))
                    {
                        $file = $request->file('file');
                        $VideoUrls = [];
                    
                        $createResponse = Http::withHeaders([
                            'AccessKey' => env('BUNNY_API_KEY')
                        ])->post("https://video.bunnycdn.com/library/".env('BUNNY_LIBRARY_ID')."/videos", [
                            'title' => $request->caption ?? 'My Video',
                        ]);

                        if (!$createResponse->successful()) {
                            return response()->json(['success' => false, 'message' => 'Failed to create video on Bunny'], 500);
                        }

                        $videoId = $createResponse['guid'];

                        $uploadResponse = Http::withHeaders([
                            'AccessKey' => env('BUNNY_API_KEY'),
                            'Content-Type' => 'application/octet-stream'
                        ])->withBody(
                            file_get_contents($file->getRealPath()),
                            'application/octet-stream'
                        )->put("https://video.bunnycdn.com/library/".env('BUNNY_LIBRARY_ID')."/videos/$videoId");

                        if (!$uploadResponse->successful()) {
                            return response()->json(['success' => false, 'message' => 'Bunny upload failed'], 500);
                        }

                        //foreach ($uploadedVideoFiles as $file) {
                        //    $fileName = md5($file->getClientOriginalName() . time()) . "Hatch-social." . $file->getClientOriginalExtension();
						//	$filePath = $file->storeAs('uploads/post', $fileName, 'public');
        			    //		$VideoUrls = Storage::url($filePath);
                            PostVideo::create([
                                'post_id' => $data->id,
                                'name' => $videoId
                            ]);
                        //}
                    }
					
                }
				return response()->json(['success'=>true,'message'=>'Post Create Successfully'],200);
            }
            
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
        try
        {
            $data = FeedPost::find($id);
            if (!$data) {
                return response()->json(['success' => false, 'message' => 'Post not found']);
            }   
            $data->delete();

            $images = FeedPostImage::where('post_id', $id)->get();
            foreach ($images as $image) 
            {
                $imagePath = public_path('ploads/feedpost/' . $image->name); // Adjust filename as needed
                if (file_exists($imagePath)) {
                    unlink($imagePath);
                }
                $image->delete();
            }
            
            $hashtags = PostHashtags::where('post_id', $id)->get();
            foreach ($hashtags as $hashtag) 
            {
                $hashtag->delete();
            }

            $video = FeedPostVideo::where('post_id', $id)->first();
            if ($video) 
            {
                $videoPath = public_path('ploads/feedpost/' . $video->name); // Adjust filename as needed
                if (file_exists($videoPath)) 
                {
                    unlink($videoPath);
                }
                $video->delete();
            }
            return response()->json(['success' => true, 'message' => 'Post deleted successfully']);
        }
        catch(\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()]);
        }
    }
}
