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
        Schema::create('message', function (Blueprint $table) {
            $table->id();
			$table->unsignedBigInteger('chat_id');
			$table->unsignedBigInteger('sender_id');
			$table->unsignedBigInteger('receiver_id');
			$table->text('text')->nullable();
            $table->longText('deleted_for')->nullable();
            $table->longText('user');
            $table->integer('is_read')->default(0);
			$table->foreign('chat_id')->references('id')->on('chat')->onDelete('cascade');
			$table->foreign('sender_id')->references('id')->on('profiles')->onDelete('cascade');
			$table->foreign('receiver_id')->references('id')->on('profiles')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('message');
    }
};
