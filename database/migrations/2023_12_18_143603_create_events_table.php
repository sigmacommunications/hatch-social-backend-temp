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
        Schema::create('events', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('community_id')->nullable();
            $table->unsignedBigInteger('profile_id')->nullable();
            $table->string('title')->nullable();
            $table->text('description')->nullable();
			$table->string('address')->nullable();
            $table->string('date')->nullable();
            $table->string('time')->nullable();
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
        Schema::dropIfExists('events');
    }
};
