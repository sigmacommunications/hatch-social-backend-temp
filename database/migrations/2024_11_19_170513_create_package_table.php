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
        Schema::create('package', function (Blueprint $table) {
            $table->id();
            $table->text('stripe_plan_id')->nullable();
            $table->string('name')->nullable();
            $table->string('price')->nullable();
            $table->text('description')->nullable();
            $table->string('status')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('package');
    }
};
