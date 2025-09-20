<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('medical_prescriptions', function (Blueprint $table) {
            $table->id();

            $table->unsignedBigInteger('examination_id')->nullable()->after('id');
            $table->foreign('examination_id')
                ->references('id')
                ->on('examinations')
                ->onDelete('set null');

            $table->unsignedBigInteger('medicine_price_id')->nullable()->after('id');
            $table->foreign('medicine_price_id')
                ->references('id')
                ->on('medicine_prices')
                ->onDelete('set null');

            $table->integer('qty');
            $table->float('total_price');
            $table->string('description')->nullable();

            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->unsignedBigInteger('deleted_by')->nullable();

            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
        Schema::dropIfExists('medical_prescriptions');
    }
};
