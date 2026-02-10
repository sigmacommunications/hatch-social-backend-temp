<?php
// app/Models/Coupon.php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Coupon extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'code',
        'profile_id',
        'stripe_coupon_id',
        'stripe_promotion_id',
        'type',
        'value',
        'max_redemptions',
        'times_redeemed',
        'valid_from',
        'valid_until',
        'is_active'
    ];

    protected $casts = [
        'valid_from' => 'datetime',
        'valid_until' => 'datetime',
        'is_active' => 'boolean',
    ];

    public function isValid()
    {
        if (!$this->is_active) {
            return false;
        }

        $now = now();
        
        if ($this->valid_from && $this->valid_from->gt($now)) {
            return false;
        }

        if ($this->valid_until && $this->valid_until->lt($now)) {
            return false;
        }

        if ($this->max_redemptions && $this->times_redeemed >= $this->max_redemptions) {
            return false;
        }

        return true;
    }
}