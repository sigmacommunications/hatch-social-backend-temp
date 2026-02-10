<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Profile;
use App\Models\Report;
use Illuminate\Http\Request;
use App\Models\Post;

class ReportController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $reports = Report::with([
              'profile',          // reporter
              'post',
            'post.profile'      // post creator
        ])->latest()->get();
        return view('admin.reports.index', compact('reports'));
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
        //
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
        $report = Report::find($id);
        $report->delete();
         return response()->json([
            'success' => true
        ]);
        //return redirect()
          //      ->back()
            //    ->with('success', 'Report deleted successfully');
    }

    public function post_detail(Request $request,$postid)
    {
        $profileId = $request->profile_id;

        $posts = Post::withCount([
              'likes as total_likes',
              'likes as thumb_count' => function ($q) {
                  $q->where('type', 'thumb');
              },
              'likes as haha_count' => function ($q) {
                  $q->where('type', 'haha');
              },
              'likes as love_count' => function ($q) {
                  $q->where('type', 'love');
              },
              'likes as surprised_count' => function ($q) {
                  $q->where('type', 'surprised');
              },
              'likes as sad_count' => function ($q) {
                  $q->where('type', 'sad');
              },
          ])
          ->with([
              'my_like',
              'comments',
              'comments.profile_info',
              'post_images',
              'post_videos',
              'community_info',
              'community_info.profile_info',
              'profile_info'
          ])
          ->find($postid);
      return response()->json([
          'success'   => true,
          'message'   => 'Post detail fetched successfully',
          'post_info' => $posts
      ], 200);
    }


    public function toggleStatus(Post $post)
    {
        if ($post->status === 'active') {
            $post->status = 'inactive';
        } else {
            $post->status = 'active';
        }

        $post->save();

        return response()->json([
            'status' => $post->status
        ]);
    }
}
