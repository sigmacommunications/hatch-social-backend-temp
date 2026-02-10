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
        Schema::create('post_hashtags', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('post_id')->nullable();
            $table->unsignedBigInteger('feed_id')->nullable();
            $table->unsignedBigInteger('community_id')->nullable();
            $table->unsignedBigInteger('hashtag_id')->nullable();
            $table->unsignedBigInteger('profile_id')->nullable();
            $table->timestamps();
            $table->foreign('post_id')->references('id')->on('feed_posts')->onDelete('cascade');
            $table->foreign('feed_id')->references('id')->on('feeds')->onDelete('cascade');
            $table->foreign('community_id')->references('id')->on('community')->onDelete('cascade');
            $table->foreign('hashtag_id')->references('id')->on('hashtags')->onDelete('cascade');
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
        Schema::dropIfExists('post_hashtags');
    }
};
