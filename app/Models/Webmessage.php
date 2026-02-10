<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Webmessage extends Model
{
    use HasFactory;
    protected $table = 'webmessage';
    protected $guarded = [];

    public function sender()
	{
		return $this->hasOne(\App\Models\Profile::class,'id','sender_id');
	}

    public function receiver()
	{
		return $this->hasOne(\App\Models\Profile::class,'id','receiver_id');
	}
}
