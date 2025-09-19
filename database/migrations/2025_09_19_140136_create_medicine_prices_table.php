<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('medicine_prices', function (Blueprint $table) {
            $table->id();
            $table->uuid('uuid')->unique();

            $table->float('unit_price');
            $table->date('start_date');
            $table->date('end_date')->nullable();

            $table->unsignedBigInteger('medicine_id')->nullable()->after('id');
            $table->foreign('medicine_id')
                ->references('id')
                ->on('medicines')
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
        Schema::dropIfExists('medicine_prices');
    }
};
