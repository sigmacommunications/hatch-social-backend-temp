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
        Schema::create('community_teams', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('community_id')->nullable();
            $table->unsignedBigInteger('profile_id')->nullable();
            $table->unsignedBigInteger('invite_profile_id')->nullable();
            $table->string('role')->nullable();
			$table->string('invite_role')->nullable();
            $table->string('status')->nullable();
            $table->timestamps();
            $table->foreign('community_id')->references('id')->on('community')->onDelete('cascade');
            $table->foreign('profile_id')->references('id')->on('profiles')->onDelete('cascade');
            $table->foreign('invite_profile_id')->references('id')->on('profiles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('community_teams');
    }
};
