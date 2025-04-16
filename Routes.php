<?php

/*
|--------------------------------------------------------------------------
| Web routes for store module
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use Modules\Frontend\Jigyosho\Controllers\JigyoshoController;
Route::get('/jigyosho', [JigyoshoController::class, 'index'])->name('jigyosho-laravel.index');
Route::get('/jigyosho/map-search', [JigyoshoController::class, 'map_search'])->name('jigyosho.map-search');
Route::get('/jigyosho/home_doctor', function () {
  include public_path('jigyosho-raw/home_doctor.php');
  exit;
});
Route::get('/jigyosho/home_nurse', function () {
  include public_path('jigyosho-raw/home_nurse.php');
  exit;
});
Route::get('/jigyosho/public_counseling', function () {
  include public_path('jigyosho-raw/public_counseling.php');
  exit;
});
Route::get('/jigyosho/home_pharmacist', function () {
  include public_path('jigyosho-raw/home_pharmacist.php');
  exit;
});
Route::get('/jigyosho/home_masseur', function () {
  include public_path('jigyosho-raw/home_masseur.php');
  exit;
});
Route::get('/jigyosho/consultation', function () {
  include public_path('jigyosho-raw/consultation.php');
  exit;
});
Route::get('/jigyosho/home_care', function () {
  include public_path('jigyosho-raw/home_care.php');
  exit;
});
Route::get('/jigyosho/home_rehabilitation', function () {
  include public_path('jigyosho-raw/home_rehabilitation.php');
  exit;
});
Route::get('/jigyosho/bathing_care', function () {
  include public_path('jigyosho-raw/bathing_care.php');
  exit;
});
Route::get('/jigyosho/nurseandcarer', function () {
  include public_path('jigyosho-raw/nurseandcarer.php');
  exit;
});
Route::get('/jigyosho/night_caregiver', function () {
  include public_path('jigyosho-raw/night_caregiver.php');
  exit;
});
Route::get('/jigyosho/welfareequipment_sales', function () {
  include public_path('jigyosho-raw/welfareequipment_sales.php');
  exit;
});
Route::get('/jigyosho/welfareequipment_rent', function () {
  include public_path('jigyosho-raw/welfareequipment_rent.php');
  exit;
});
