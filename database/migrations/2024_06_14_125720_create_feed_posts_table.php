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
        Schema::create('feed_posts', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('feed_id')->nullable();
            $table->unsignedBigInteger('profile_id')->nullable();
            $table->string('caption')->nullable();
            $table->string('hashtags')->nullable();
            $table->string('type')->nullable();
            $table->text('file')->nullable();
            $table->string('status')->nullable();
            $table->timestamps();
            $table->foreign('feed_id')->references('id')->on('feeds')->onDelete('cascade');
            $table->foreign('profile_id')->references('id')->on('profiles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('feed_posts');
    }
};
