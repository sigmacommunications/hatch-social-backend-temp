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
        Schema::create('call_requests', function (Blueprint $table) {
            $table->id();
			$table->unsignedBigInteger('caller_id');
			$table->unsignedBigInteger('receiver_id');
			$table->string('channel_name');
			$table->boolean('accepted')->default(false);
            $table->string('status')->nullable();
            $table->string('start_at')->nullable();
            $table->string('ended_at')->nullable();
            $table->timestamps();
//			$table->foreign('caller_id')->references('id')->on('profiles')->onDelete('cascade');
	//		$table->foreign('receiver_id')->references('id')->on('profiles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('call_requests');
    }
};
