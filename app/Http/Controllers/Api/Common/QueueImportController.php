<?php

namespace App\Http\Controllers\Api\Common;

use App\Classes\Common;
use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\ImportRequest;
use Illuminate\Support\Facades\Bus;
use Illuminate\Support\Facades\Cache;
use Examyou\RestAPI\ApiResponse;
use Examyou\RestAPI\Exceptions\ApiException;
use Carbon\Carbon;

class QueueImportController extends ApiBaseController
{
    
	public function import(ImportRequest $request)
    {
        if ($request->hasFile('file')) {
            $fileName = 'import_' . Carbon::now()->timestamp . '_' . Common::generateOrderUniqueId();
            $file = $fileName . '.xlsx';
            request()->file('file')->storeAs('/', $file, 'temp');
            
            if($request->bus == 'inventory_in'){
                $request->bus = 'purchases';
            }
            
            if($request->context == 'inventory_in'){
                $request->context = 'purchases';
            }
            
            if($request->bus == 'inventory_out'){
                $request->bus = 'sales';
            }
            
            if($request->context == 'inventory_out'){
                $request->context = 'sales';
            }
            
            if ($request->bus == 'master') {
                $batch = Bus::batch([new \App\Jobs\MasterImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue($request->bus)
                            ->dispatch();
            } else if ($request->bus == 'products') {
                $batch = Bus::batch([new \App\Jobs\ProductImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue($request->bus)
                            ->dispatch();
            } else if ($request->bus == 'warehouses') {
                $batch = Bus::batch([new \App\Jobs\WarehouseImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue($request->bus)
                            ->dispatch();
            } else if ($request->bus == 'placements') {
                $batch = Bus::batch([new \App\Jobs\PlacementImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue($request->bus)
                            ->dispatch();
            } else if ($request->bus == 'purchases') {
                $batch = Bus::batch([new \App\Jobs\PurchasesImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue('orders')
                            ->dispatch();
            } else if ($request->bus == 'purchase-returns') {
                $batch = Bus::batch([new \App\Jobs\PurchaseReturnsImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue('orders')
                            ->dispatch();
            } else if ($request->bus == 'sales') {
                $batch = Bus::batch([new \App\Jobs\SalesImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue('orders')
                            ->dispatch();
            } else if ($request->bus == 'sales-returns') {
                $batch = Bus::batch([new \App\Jobs\SalesReturnsImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue('orders')
                            ->dispatch();
            } else if ($request->bus == 'stock-transfers') {
                $batch = Bus::batch([new \App\Jobs\StockTransfersImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue('orders')
                            ->dispatch();
            } else if ($request->bus == 'stock-transfer-returns') {
                $batch = Bus::batch([new \App\Jobs\StockTransferReturnsImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue('orders')
                            ->dispatch();
            } else if ($request->bus == 'stock-adjustment-orders') {
                $batch = Bus::batch([new \App\Jobs\StockAdjustmentOrdersImportJob($request->context, $file, $fileName, user()->id)])
                            ->onQueue('orders')
                            ->dispatch();
            } 

            $response = [
                'id' => $batch->id,
                'finished' => $batch->finished(),
                'cache_key' => $fileName,
                'progress' => [
                    'percent' => $batch->progress(),
                    'status' => 'active',
                    'message' => '',
                ],
            ];
            
            return ApiResponse::make('Import Started', $response);
        }
    }

    public function updateImportProgress()
    {
        $request = request();
        $batchId = $request->id;
        $progress = $request->progress;
        $cacheKey = $request->cache_key;

        if (Cache::has($cacheKey) && Cache::get($cacheKey) != '') {
            $errMessage = Cache::get($cacheKey);
            Cache::forget($cacheKey);

            throw new ApiException($errMessage);
        }

        $updatedBatch = Bus::findBatch($batchId);

        if ($updatedBatch->progress() > $progress['percent']) {
            $progress['percent'] = $updatedBatch->progress();
        } else if ($progress['percent'] < 40) {
            $progress['percent'] += 10;
        } else if ($progress['percent'] < 60) {
            $progress['percent'] += 5;
        } else if ($progress['percent'] >= 60 && $progress['percent'] < 80) {
            $progress['percent'] += 2;
        } else if ($progress['percent'] >= 80 && $progress['percent'] < 90) {
            $progress['percent'] += 1;
        }
        
        $response = [
            'id' => $batchId,
            'finished' => $updatedBatch->finished(),
            'cache_key' => $cacheKey,
            'progress' => $progress
        ];

        return ApiResponse::make('Import Progress Updated', $response);
    }
}
