<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('first_name')->nullable();
            $table->string('last_name')->nullable();
            $table->string('email')->nullable();
            $table->string('email_code')->nullable();
            $table->string('phone')->nullable();
            $table->text('description')->nullable();
            $table->string('photo')->nullable();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->string('current_role')->nullable();
            $table->string('current_plan')->nullable();
            $table->string('created_plan')->nullable();
            $table->string('end_plan')->nullable();
            $table->text('address')->nullable();
            $table->string('currency', 250)->nullable();
            $table->enum('role', ['user', 'admin'])->default('user');
            $table->enum('status', ['active', 'inactive'])->default('active');
            $table->rememberToken();
            // $table->string('stripe_id')->nullable();
            // $table->string('pm_type')->nullable();
            // $table->string('exp_month', 100)->nullable();
            // $table->string('exp_year', 100)->nullable();
            // $table->string('pm_last_four', 4)->nullable();
            // $table->timestamp('trial_ends_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
};
