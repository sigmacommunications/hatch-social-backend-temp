<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    use HasFactory;
	protected $table = 'message';
	protected $guarded = [];
	
	protected $casts = [
        'deleted_for' => 'array', // Ensure it's treated as an array
    ];
}
