<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Feed extends Model
{
    use HasFactory;
    protected $guarded = [];


    protected static function booted()
    {
        static::deleting(function ($feed) {
            // Delete related posts, images, videos, etc.
            $feed->posts()->delete();
            $feed->posts('total_likes')->delete();
            $feed->follow()->delete();
            $feed->posts('comments')->delete();
            $feed->interest()->delete();

            // Delete files associated with the feed
            foreach ($feed->posts('post_images') as $image) {
                Storage::delete($image->file_path);
            }
            foreach ($feed->posts('post_videos') as $video) {
                Storage::delete($video->file_path);
            }
        });
    }

    public function likes()
    {
        return $this->hasMany(FeedPostLike::class);
    }

    public function comments()
    {
        return $this->hasMany(FeedComment::class);
    }


    public function community_owner()
    {
        return $this->hasOne(\App\Models\Profile::class,'id','profile_id');
    }
    
    public function follow()
    {
        return $this->hasOne(\App\Models\FeedFollow::class,'feed_id','id');
    }

    public function postImages()
    {
        return $this->hasMany(FeedPostImage::class);
    }

    public function postVideos()
    {
        return $this->hasMany(FeedPostVideo::class);
    }

    
    public function hashtags()
    {
        return $this->hasMany(\App\Models\Hashtags::class,'feed_id','id');
    }
    
    public function interest()
    {
        return $this->hasOne(\App\Models\FeedInterest::class,'feed_id','id');
    }
    
    public function profile_info()
    {
        return $this->hasOne(\App\Models\Profile::class,'id','profile_id');
    }
    
    public function posts()
    {
        return $this->hasManyThrough(FeedPost::class, PostHashtags::class, 'feed_id', 'id', 'id', 'post_id');
    }
    
    public function postss()
    {
        return $this->hasManyThrough(FeedPost::class, PostHashtags::class, 'feed_id', 'id', 'id', 'post_id');
    }
}
