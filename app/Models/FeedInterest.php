<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FeedInterest extends Model
{
    use HasFactory;
    protected $guarded = [];
    protected $table = 'feed_interests';
	
	public function detail()
    {
        return $this->hasOne(\App\Models\Interests::class,'id','interest_id');
    }
}
