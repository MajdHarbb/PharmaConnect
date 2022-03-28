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
        
        Route::post('/update-profile-picture', [UserController::class, 'updateProfilePicture'])->name('update-profile-picture');
        Route::post('/update-name', [UserController::class, 'updateName'])->name('update-name');
        Route::post('/update-phone', [UserController::class, 'updatePhone'])->name('update-phone');
        Route::post('/update-password', [UserController::class, 'updatePassword'])->name('update-password');
        Route::post('/get-notifications', [UserController::class, 'getNotifications'])->name('get-notifications');
        Route::post('/my-posts', [UserController::class, 'myPosts'])->name('my-posts');
        Route::post('/solvePost', [PostfindsController::class, 'solvePost'])->name('solvePost');
        
    });
    

    Route::group(['middleware' => ['role.pharmacy']], function () {
        Route::group(['prefix' => 'pharmacy'], function () {
            Route::get('/profile', [UserController::class, 'pharmacyprofile'])->name('pharmacy-profile'); 
            Route::get('/get-unsolved-posts', [PostsController::class, 'getAllPosts'])->name('get-posts'); 
        });
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
    //Route::post('/my-posts', [UserController::class, 'myPosts'])->name('my-posts');
    
      
});



