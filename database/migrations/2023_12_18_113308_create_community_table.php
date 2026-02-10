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
        Schema::create('community', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('profile_id')->nullable();
            $table->string('title')->nullable();
            $table->string('approval_post')->nullable();
            $table->string('membership_cost')->nullable();
            $table->string('privacy')->nullable();
            $table->string('admin_create_content')->nullable();
            $table->string('moderator_create_content')->nullable();
            $table->string('member_create_content')->nullable();
            $table->string('admin_remove_content')->nullable();
            $table->string('moderator_remove_content')->nullable();
            $table->string('member_remove_content')->nullable();
            $table->string('admin_remove_comment')->nullable();
            $table->string('moderator_remove_comment')->nullable();
            $table->string('member_remove_comment')->nullable();
            $table->string('admin_create_comment')->nullable();
            $table->string('moderator_create_comment')->nullable();
            $table->string('member_create_comment')->nullable();
            $table->string('admin_member_remove')->nullable();
            $table->string('moderator_member_remove')->nullable();
            $table->string('owner_member_remove')->nullable();
            $table->integer('joining_cost')->nullable();
            $table->integer('app_service_charges')->default(0);
            $table->string('image')->nullable();
            $table->string('bubble')->default(1);
            $table->longText('description')->nullable();
            $table->integer('streaming')->default(0);
            $table->string('status')->nullable();
            $table->timestamps();
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
        Schema::dropIfExists('community');
    }
};
