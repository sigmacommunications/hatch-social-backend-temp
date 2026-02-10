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
        Schema::create('commuinity_check_ins', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('community_id');
            $table->unsignedBigInteger('profile_id');
            $table->string('time_in')->nullable();
            $table->string('time_out')->nullable();
            $table->string('total_min')->nullable();
            $table->timestamps();
            $table->foreign('community_id')->references('id')->on('community')->onDelete('cascade');
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
        Schema::dropIfExists('commuinity_check_ins');
    }
};
