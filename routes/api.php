<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\RateController;
use App\Http\Controllers\TokenController;
use App\Http\Controllers\DurationController;
use App\Http\Controllers\OwnerController;
use App\Http\Controllers\PurchaseController;
use App\Http\Controllers\WithdrawController;
use App\Http\Controllers\UserController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
  
  //logout
   Route::post('logout', [AuthController::class, 'logout']);

  //contract settings
   Route::post('save-rate', [RateController::class, 'saveRate']);

   Route::get('/get-rate', [RateController::class, 'getRate']);

   

  //set duration
   Route::post('save-duration', [DurationController::class, 'saveDuration']);

   Route::get('/duration-logs', [DurationController::class, 'durationLogs']);

   Route::get('/duration-info', [DurationController::class, 'durationInfo']);

  //set owner
   Route::post('save-owner', [OwnerController::class, 'saveOwner']);

   Route::get('/get-owner', [OwnerController::class, 'getOwner']);
   
   Route::get('/owner-logs', [OwnerController::class, 'ownerLogs']);  
  
  //purchase logs
   Route::get('/purchase-logs', [PurchaseController::class, 'purchaseLogs']);

  //withdraw

   Route::post('save-withdraw', [WithdrawController::class, 'saveWithdraw']);

   Route::get('/withdraw-logs', [WithdrawController::class, 'withdrawLogs']);

  //user details
    
    Route::get('/user-details', [UserController::class, 'userDetails']);

  //tokens
   //Route::apiResource('tokens', TokenController::class);
});

Route::get('/get-date', [DurationController::class, 'getDate']);

Route::get('/rate-logs', [RateController::class, 'rateLogs']);

//purchase
  Route::post('save-purchase', [PurchaseController::class, 'savePurchase']);