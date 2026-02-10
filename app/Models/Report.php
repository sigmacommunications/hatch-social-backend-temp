<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Post;
use App\Models\Profile;

class Report extends Model
{
    use HasFactory;
    protected $guarded = [];

    public function post()
    {
        return $this->belongsTo(Post::class);
    }

    public function profile()
    {
        return $this->belongsTo(Profile::class);
    }
}
