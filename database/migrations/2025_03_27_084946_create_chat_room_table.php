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
        Schema::create('chat_room', function (Blueprint $table) {
            $table->id();
			$table->string('name'); // Group ka naam
			$table->longtext('description')->nullable(); // Group ka naam
			$table->text('image')->nullable(); // Group ka naam
            $table->unsignedBigInteger('owner'); // Kis user ne banaya
			$table->integer('max_users');
            $table->timestamps();
            $table->foreign('owner')->references('id')->on('profiles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('chat_room');
    }
};
