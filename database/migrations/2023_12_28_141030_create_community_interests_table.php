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
        Schema::create('community_interests', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('profile_id')->nullable();
            $table->unsignedBigInteger('community_id')->nullable();
            $table->string('interest_id')->nullable();
            $table->string('name')->nullable();
            $table->timestamps();
            $table->foreign('profile_id')->references('id')->on('profiles')->onDelete('cascade');
            // $table->foreign('interest_id')->references('id')->on('interests')->onDelete('cascade');
            $table->foreign('community_id')->references('id')->on('community')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('community_interests');
    }
};
