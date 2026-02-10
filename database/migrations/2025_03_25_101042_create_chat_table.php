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
        Schema::create('chat', function (Blueprint $table) {
            $table->id();
			$table->unsignedBigInteger('sender_id');
			$table->unsignedBigInteger('receiver_id');
            $table->integer('message_count')->default(1);
            $table->string('status', 250)->default('pending');
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
        Schema::dropIfExists('chat');
    }
};
