<?php
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\PostsController;
use App\Http\Controllers\PostfindsController;


Route::group(['middleware' => ['auth:api']], function () {

    Route::group(['prefix' => 'user'], function () {
        Route::get('/profile', [UserController::class, 'userProfile'])->name('user-profile');  
        Route::get('/info', [UserController::class, 'info'])->name('user-info');
        Route::get('/get-pharmacies', [UserController::class, 'getAllPharmacies'])->name('get-pharmacies');  
        Route::post('/addPost', [PostsController::class, 'addPost'])->name('addPost');
        Route::get('/get-posts', [PostsController::class, 'getAllPosts'])->name('get-posts');



        Route::post('/solvePost', [PostfindsController::class, 'solvePost'])->name('solvePost');  
    });
    
    Route::group(['middleware' => ['role.pharmacy']], function () {
        Route::group(['prefix' => 'pharmacy'], function () {
            Route::get('/profile', [UserController::class, 'pharmacyprofile'])->name('pharmacy-profile');  
        });
    });

    
    
    Route::group(['prefix' => 'patient'], function () {
         
    });
    
    Route::group(['prefix' => 'admin'], function () {
         
    });

    Route::group(['prefix' => 'auth'], function () {
        Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
        Route::post('/refresh', [AuthController::class, 'refresh'])->name('refresh');
          
    });
});

Route::group(['prefix' => 'auth'], function () {
    Route::post('/login', [AuthController::class, 'login'])->name('auth-login');
    Route::post('/register', [AuthController::class, 'register'])->name('auth-register');
    Route::get('/notfound', [AuthController::class, 'notFound'])->name('not-found');
      
});



