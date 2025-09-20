<?php

use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth'])->group(function () {
    Route::get('/', function () {
        return redirect('/dashboard');
    });
    Route::get('/dashboard', function () {
        return view('template.components.index');
    })->name('dashboard');

    Route::prefix('user')->group(function () {
        Route::get('/', [UserController::class, 'index'])->name('user.index')->middleware('role:admin');
    });
    Route::prefix('log')->group(function () {
        Route::get('/', [\App\Http\Controllers\LogActivityController::class, 'index'])->name('log.index')->middleware('role:admin');
    });

    Route::prefix('medicine')->group(function () {
        Route::get('/', [\App\Http\Controllers\MedicineController::class, 'index'])->name('medicine.index')->middleware('role:admin');
        Route::get('/{id}', [\App\Http\Controllers\MedicineController::class, 'show'])->name('medicine.show')->middleware('role:admin');
        Route::post('/sync', [\App\Http\Controllers\MedicineController::class, 'syncData'])->name('medicine.sync')->middleware('role:admin');
    });

    Route::prefix('examination')->group(function () {
        Route::get('/', [\App\Http\Controllers\ExaminationController::class, 'index'])->name('examination.index')->middleware('role:dokter,apoteker');
        Route::get('/create', [\App\Http\Controllers\ExaminationController::class, 'create'])->name('examination.create')->middleware('role:dokter,apoteker');
        Route::get('/edit/{id}', [\App\Http\Controllers\ExaminationController::class, 'edit'])->name('examination.edit')->middleware('role:dokter,apoteker');
        Route::post('/', [\App\Http\Controllers\ExaminationController::class, 'store'])->name('examination.store')->middleware('role:dokter,apoteker');
        Route::put('/{id}', [\App\Http\Controllers\ExaminationController::class, 'update'])->name('examination.update')->middleware('role:dokter,apoteker');
        Route::put('/{id}/payment', [\App\Http\Controllers\ExaminationController::class, 'payment'])->name('examination.payment')->middleware('role:apoteker');
        Route::get('/patients/{id}/receipt', [\App\Http\Controllers\ExaminationController::class, 'printReceipt'])
            ->name('examination.receipt')->middleware('role:apoteker');

    });
});

require __DIR__ . '/auth.php';
