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
        Schema::create('examinations', function (Blueprint $table) {
            $table->id();

            $table->integer('weight');
            $table->integer('height');
            $table->integer('systole');
            $table->integer('diastole');
            $table->integer('heart_rate');
            $table->integer('respiratory_rate');
            $table->integer('temperature');

            $table->unsignedBigInteger('patient_id')->nullable()->after('id');
            $table->foreign('patient_id')
                ->references('id')
                ->on('patients')
                ->onDelete('set null');

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
        Schema::dropIfExists('examinations');
    }
};
