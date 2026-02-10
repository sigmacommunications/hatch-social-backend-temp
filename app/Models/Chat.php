<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Chat extends Model
{
    use HasFactory;
	protected $table = 'chat';
	protected $guarded = [];
	
	
	public function receiver()
	{
		return $this->hasOne(\App\Models\Profile::class,'id','receiver_id');
	}
	
	public function sender()
	{
		return $this->hasOne(\App\Models\Profile::class,'id','sender_id');
	}
	
	
	public function message()
	{
		return $this->hasOne(\App\Models\Message::class,'chat_id','id')->orderBy('id','desc');
	}
	
}
