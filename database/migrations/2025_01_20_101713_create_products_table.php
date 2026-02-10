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
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('profile_id'); // Foreign Key for users table
            $table->unsignedBigInteger('community_id'); // Foreign Key for users table
            $table->string('title')->nullable();
            $table->string('product_title')->nullable();
            $table->integer('price')->nullable();
            $table->string('image')->nullable();
            $table->string('link')->nullable();
            $table->longtext('description')->nullable();
            $table->timestamps();
            $table->foreign('profile_id')->references('id')->on('profiles')->onDelete('cascade');
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
        Schema::dropIfExists('products');
    }
};
