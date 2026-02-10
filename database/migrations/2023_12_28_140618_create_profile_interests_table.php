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
        Schema::create('profile_interests', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('interest_id')->nullable();
            $table->unsignedBigInteger('profile_id')->nullable();
            $table->string('name')->nullable();
            $table->string('image')->nullable();
            $table->timestamps();
            $table->foreign('interest_id')->references('id')->on('interests')->onDelete('cascade');
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
        Schema::dropIfExists('profile_interests');
    }
};
