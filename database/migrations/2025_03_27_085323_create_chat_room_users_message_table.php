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
        Schema::create('chat_room_users_message', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('chatroom_id'); // Kis chatroom me bheja gaya
            $table->unsignedBigInteger('profile_id'); // Kis user ne bheja
            $table->text('text'); // Message content
            $table->longText('user')->nullable();
            $table->text('deleted_for')->nullable();
            $table->timestamps();

            $table->foreign('chatroom_id')->references('id')->on('chat_room')->onDelete('cascade');
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
        Schema::dropIfExists('chat_room_users_message');
    }
};
