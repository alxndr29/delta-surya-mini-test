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
        Route::get('/', [UserController::class, 'index'])->name('user.index');
    });

    Route::prefix('medicine')->group(function () {
        Route::get('/', [\App\Http\Controllers\MedicineController::class, 'index'])->name('medicine.index');
        Route::get('/{id}', [\App\Http\Controllers\MedicineController::class, 'show'])->name('medicine.show');
        Route::post('/sync', [\App\Http\Controllers\MedicineController::class, 'syncData'])->name('medicine.sync');
    });

    Route::prefix('examination')->group(function () {
        Route::get('/', [\App\Http\Controllers\ExaminationController::class, 'index'])->name('examination.index');
        Route::get('/create', [\App\Http\Controllers\ExaminationController::class, 'create'])->name('examination.create');
        Route::get('/edit/{id}', [\App\Http\Controllers\ExaminationController::class, 'edit'])->name('examination.edit');
        Route::post('/', [\App\Http\Controllers\ExaminationController::class, 'store'])->name('examination.store');
        Route::put('/{id}', [\App\Http\Controllers\ExaminationController::class, 'update'])
            ->name('examination.update');
    });
});

require __DIR__ . '/auth.php';
