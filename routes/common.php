<?php

use Examyou\RestAPI\Facades\ApiRoute;
use Illuminate\Support\Facades\Route;

$appType = app_type();
$routeArray = [
    'namespace' => 'App\Http\Controllers\Api\Common',
];

if ($appType == 'saas') {
    $routeArray['prefix'] = 'superadmin';
}

if ($appType == 'non-saas') {
    $routeArray['middleware'] = ['api.permission.check', 'api.auth.check', 'license-expire'];
} else {
    $routeArray['middleware'] = ['api.superadmin.check', 'license-expire'];
}

Route::get('langs/download/{xid?}', ['as' => 'api.extra.langs.download', 'uses' => 'Api\Common\LangsController@downloadLang']);

//export
Route::get('brands/export', ['as' => 'api.brands.export', 'uses' => 'Api\BrandController@export']);
Route::get('barcode/export', ['as' => 'api.barcode.export', 'uses' => 'Api\BarcodeController@export']);
Route::get('categories/export', ['as' => 'api.categories.export', 'uses' => 'Api\CategoryController@export']);
Route::get('products/export', ['as' => 'api.products.export', 'uses' => 'Api\ProductController@export']);
Route::get('parts/export', ['as' => 'api.parts.export', 'uses' => 'Api\PartController@export']);
Route::get('floors/export', ['as' => 'api.floors.export', 'uses' => 'Api\FloorController@export']);
Route::get('rows/export', ['as' => 'api.rows.export', 'uses' => 'Api\RowController@export']);
Route::get('shelf-groups/export', ['as' => 'api.shelfGroups.export', 'uses' => 'Api\ShelfGroupController@export']);
Route::get('shelf-numbers/export', ['as' => 'api.shelfNumbers.export', 'uses' => 'Api\ShelfNumberController@export']);
Route::get('stock-in/export', ['as' => 'api.stockIn.export', 'uses' => 'Api\ProductPlacementController@stockInExport']);
Route::get('stock-out/export', ['as' => 'api.stockOut.export', 'uses' => 'Api\ProductPlacementController@stockOutExport']);
Route::get('stock-listings/export', ['as' => 'api.stock-listings.export', 'uses' => 'Api\StockListingController@export']);

// If appType is saas version
// Then we only define routes
// for send email settings not email settings
if ($appType == 'saas') {
    ApiRoute::group(['namespace' => 'App\Http\Controllers\Api\Common', 'prefix' => 'settings', 'middleware' => ['api.permission.check', 'api.auth.check']], function () {
        ApiRoute::post('email/send-mail-settings', ['as' => 'api.settings.send-mail-settings', 'uses' => 'SettingsController@sendMailSettings']);
        ApiRoute::get('email', ['as' => 'api.settings.email.index', 'uses' => 'SettingsController@getEmailSetting']);
    });

    // For SAAS version this endpoint always exists
    ApiRoute::group(['namespace' => 'App\Http\Controllers\Api\Common', 'middleware' => ['api.permission.check', 'api.auth.check']], function () {
        $options = [
            'as' => 'api'
        ];

        ApiRoute::resource('currencies', 'CurrencyController', $options);
    });
}

// Routes which are available
// according to app_type
ApiRoute::group($routeArray, function () {

    ApiRoute::post('translations/import', ['as' => 'api.translations.import', 'uses' => 'TranslationsController@import']);
    ApiRoute::post('translations/refetch', ['as' => 'api.translations.refetch', 'uses' => 'TranslationsController@refetchTranslations']);
    ApiRoute::resource('translations', 'TranslationsController', ['as' => 'api', 'only' => ['update']]);

    $options = [
        'as' => app_type() == 'non-saas' ? 'api' : 'api.superadmin'
    ];

    ApiRoute::resource('langs', 'LangsController', $options);
    ApiRoute::resource('currencies', 'CurrencyController', $options);

    ApiRoute::group(['prefix' => 'settings'], function () {
        ApiRoute::post('storage/update', ['as' => 'api.settings.storage.update', 'uses' => 'SettingsController@updateStorage']);
        ApiRoute::get('storage', ['as' => 'api.settings.storage.index', 'uses' => 'SettingsController@getStorage']);
        ApiRoute::post('email/send-test-mail', ['as' => 'api.settings.email.send-test-mail', 'uses' => 'SettingsController@sendTestMail']);
        ApiRoute::post('email/send-mail-settings', ['as' => 'api.settings.send-mail-settings', 'uses' => 'SettingsController@sendMailSettings']);
        ApiRoute::post('email/update', ['as' => 'api.settings.email.update', 'uses' => 'SettingsController@updateEmailSetting']);
        ApiRoute::get('email', ['as' => 'api.settings.email.index', 'uses' => 'SettingsController@getEmailSetting']);
    });

    ApiRoute::post('modules/extract', ['as' => 'api.modules.extract', 'uses' => 'ModuleController@extractZip']);
    ApiRoute::get('modules/download-percentage', ['as' => 'api.modules.download-percentage', 'uses' => 'ModuleController@downloadPercent']);
    ApiRoute::post('modules/install', ['as' => 'api.modules.install', 'uses' => 'ModuleController@install']);
    ApiRoute::post('modules/update-status', ['as' => 'api.modules.update_status', 'uses' => 'ModuleController@updateStatus']);
    ApiRoute::get('modules', ['as' => 'api.modules.index', 'uses' => 'ModuleController@index']);

    ApiRoute::get('update-app/download-percentage', ['as' => 'api.update-app.download-percentage', 'uses' => 'UpdateAppController@downloadPercent']);
    ApiRoute::post('update-app/extract', ['as' => 'api.update-app.extract', 'uses' => 'UpdateAppController@extractZip']);
    ApiRoute::post('update-app/update', ['as' => 'api.update-app.update', 'uses' => 'UpdateAppController@updateApp']);
    ApiRoute::get('update-app', ['as' => 'api.update-app.index', 'uses' => 'UpdateAppController@index']);

    // Database backup
    ApiRoute::get('download-backups/{id}', ['as' => 'api.settings.download-backups', 'uses' => 'DatabaseBackupController@downloadBackups']);

    ApiRoute::post('database-backups', ['as' => 'api.settings.database-backups', 'uses' => 'DatabaseBackupController@databaseBackups']);
    ApiRoute::post('generate-backups', ['as' => 'api.settings.generate-backups', 'uses' => 'DatabaseBackupController@generateBackups']);
    ApiRoute::post('delete-backup', ['as' => 'api.settings.delete-backup', 'uses' => 'DatabaseBackupController@deleteBackup']);
    
    // Queue Import
    ApiRoute::post('queue/import', ['as' => 'api.queue.import', 'uses' => 'QueueImportController@import']);
    ApiRoute::post('queue/import-progress', ['as' => 'api.queue.import-progress', 'uses' => 'QueueImportController@updateImportProgress']);
});
