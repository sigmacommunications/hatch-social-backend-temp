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
        Schema::create('webmessage', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('sender_id');
			$table->unsignedBigInteger('receiver_id');
			$table->text('text')->nullable();
            $table->longText('user')->nullable();
            $table->integer('is_read')->default(0);
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
        Schema::dropIfExists('webmessage');
    }
};
