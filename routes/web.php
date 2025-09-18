<?php


use Illuminate\Support\Facades\Route;

Route::middleware(['auth'])->group(function () {
    Route::get('/', function () {
        return redirect('/dashboard');
    });
    Route::get('/dashboard', function () {
        return view('template.components.index');
    })->name('dashboard');

});

require __DIR__ . '/auth.php';
