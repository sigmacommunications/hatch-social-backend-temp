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
        Schema::create('community_streamings', function (Blueprint $table) {
            $table->id();
			$table->unsignedBigInteger('community_id');
			$table->string('start')->nullable();
			$table->string('end')->nullable();
			$table->string('type')->nullable();
            $table->timestamps();
			$table->foreign('community_id')->references('id')->on('community')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('community_streamings');
    }
};
