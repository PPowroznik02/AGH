<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CommentController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__ . '/auth.php';

Route::middleware('auth')->group(function () {
    Route::get('/books', [\App\Http\Controllers\BookController::class, 'index'])->name('books.index');
    Route::get('/books/create', [\App\Http\Controllers\BookController::class, 'create'])->name('books.create');
    Route::post('/books', [\App\Http\Controllers\BookController::class, 'store']);
    Route::get('/books/{id}', [\App\Http\Controllers\BookController::class, 'show'])->name('books.show.{id}');
    Route::get('/books/{id}/edit', [\App\Http\Controllers\BookController::class, 'edit'])->name('books.{id}.edit');
    Route::patch('/books/{id}', [\App\Http\Controllers\BookController::class, 'update'])->name('books.update');
    Route::get('/books/{id}/delete', [\App\Http\Controllers\BookController::class, 'delete'])->name('books.{id}.delete');
});

Route::resource('/comments', CommentController::class);
