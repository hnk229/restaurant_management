<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CategoriesController;
use App\Http\Controllers\UserController;



Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::Post('/auth/login', [UserController::class, 'login']);
Route::Post('/auth/register', [UserController::class, 'register']);

Route::group(['middleware' =>['auth:sanctum']],function () {
    // Route for categorys
    Route::apiResource('categories', CategoriesController::class);

    // Route for users
    Route::get('/user/all', [UserController::class, 'index']);
    Route::put('/auth/update/{user_id}', [UserController::class, 'update']);
    Route::delete('/auth/destroy/{user_id}', [UserController::class, 'destroy']);
    
});


