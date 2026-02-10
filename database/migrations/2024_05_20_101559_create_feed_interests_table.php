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
        Schema::create('feed_interests', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('interest_id');
            $table->unsignedBigInteger('feed_id');
            $table->timestamps();
            $table->foreign('interest_id')->references('id')->on('interests')->onDelete('cascade');
            $table->foreign('feed_id')->references('id')->on('feeds')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('feed_interests');
    }
};
