<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ChatRoomUsersMessage extends Model
{
    use HasFactory;
	protected $table = 'chat_room_users_message';
	protected $guarded = [];
}
