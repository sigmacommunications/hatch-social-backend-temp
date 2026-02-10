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
        Schema::create('profiles', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->integer('bubble')->default(0);
            $table->string('name')->unique();
            $table->string('passcode')->nullable();
            $table->text('description')->nullable();
            $table->string('type');
            $table->string('privacy');
            $table->text('address')->nullable();
            $table->string('qa_status')->nullable();
            $table->string('photo')->nullable();
            $table->string('device_token')->nullable();
            $table->string('stripe_id', 250)->nullable();
            $table->string('stripe_connect_id', 100)->nullable();
            $table->text('stripe_url')->nullable();
            $table->string('pm_type', 250)->nullable();
            $table->string('exp_month', 250)->nullable();
            $table->string('exp_year', 250)->nullable();
            $table->string('pm_last_four', 250)->nullable();
            $table->timestamp('trial_ends_at')->nullable();
            $table->string('is_logged_in')->nullable();
            $table->text('interests')->nullable();
            $table->string('status')->nullable();
            $table->string('email')->nullable();
            $table->timestamps();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('profiles');
    }
};
