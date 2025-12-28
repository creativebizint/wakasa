<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Barcode\IndexRequest;
use App\Http\Requests\Api\Barcode\StoreRequest;
use App\Http\Requests\Api\Barcode\UpdateRequest;
use App\Http\Requests\Api\Barcode\DeleteRequest;
use App\Http\Requests\Api\Barcode\ImportRequest;
use App\Imports\BarcodeImport;
use App\Exports\BarcodeExport;
use App\Models\Barcode;
use App\Models\Order;
use App\Models\Product;
use App\Models\OrderItem;
use Examyou\RestAPI\ApiResponse;
use Maatwebsite\Excel\Facades\Excel;
use Examyou\RestAPI\Exceptions\ApiException;
use App\Classes\Common;

class BarcodeController extends ApiBaseController
{
    protected $model = Barcode::class;

    protected $indexRequest = IndexRequest::class;
    protected $storeRequest = StoreRequest::class;
    protected $updateRequest = UpdateRequest::class;
    protected $deleteRequest = DeleteRequest::class;

    public function import(ImportRequest $request)
    {
            if ($request->hasFile('file')) {
                    Excel::import(new BarcodeImport, request()->file('file'));
            }

            return ApiResponse::make('Imported Successfully', []);
    }
    public function export()
    {
                return Excel::download(new BarcodeExport, 'barcode.xlsx');
    }

    public function storing(Barcode $barcode)
    {
            $barcode->isactive=0;

            return $barcode;
    }

        public function updating(Barcode $barcode)
    {
        $request = request();
        if($request->invoice_number != ''){
          $product = Product::where('item_id',$request->item_id)->select('id')->first();
          if($product == null){
            throw new ApiException('Item Id tidak ditemukan');
          }
          
          $order = OrderItem::join('orders','orders.id','=','order_items.order_id')
              ->where('orders.invoice_number',$request->invoice_number)
              ->where('order_items.product_id','=',$product->id)
              ->select('order_items.id','order_items.quantity')->first();
          
          if($request->qty_bungkus > $order->quantity){
            throw new ApiException('Act Qty Bungkus('.$request->qty_bungkus.') tidak bisa lebih besar dari Qty Faktur ('.$order->quantity.')');
          }
          
          if($order == null){
            throw new ApiException('No BB tidak ditemukan');
          }
          else{
            $barcode->order_item_id = $order->id;  
          }
          
          $barcodes = Barcode::where('order_item_id',$order->id)->where('string','!=',$request->string)
                      ->get();
          $qty_scanned = $request->qty_bungkus;
          foreach($barcodes as $barcode_detail){
              $qty_scanned += $barcode_detail->qty_bungkus;
          }
          if($qty_scanned > $order->quantity){
            throw new ApiException('Qty Scanned ('.$qty_scanned.') tidak bisa lebih besar dari Qty Faktur ('.$order->quantity.')');
          }
          else{
              OrderItem::where('id',$order->id)->update(['quantity_scanned'=>$qty_scanned]);
          }
          
          if(isset($request->delivery_invoice_number) && $request->delivery_invoice_number != ''){
              $delivery_order = OrderItem::join('orders','orders.id','=','order_items.order_id')
              ->where('orders.invoice_number',$request->delivery_invoice_number)
              ->where('order_items.product_id','=',$product->id)
              ->select('order_items.id')->first();
              if($delivery_order == null){
                throw new ApiException('No DO tidak ditemukan');
              }
              else{
                $barcode->order_item_out_id = $delivery_order->id;  
                $barcode->status = Barcode::STATUS_DO;  
                $barcode->isactive = 0;  
              }
          }
          
        }
        $barcode->box_id = Common::generateOrderUniqueId();
        $barcode->comment = $request->comment;
        $barcode->reg_bungkus_id = Common::generateOrderUniqueId();
        //file_put_contents(storage_path('logs') . '/barcode.log', "[" . date('Y-m-d H:i:s') . "]test 1 : \n" . print_r($barcode,1) . "\n\n", FILE_APPEND);
        return $barcode;
    }
    
    
    public function destroying(Barcode $barcode)
    {
        if($barcode->status != 1){
            throw new ApiException($barcode->string." can't be deleted");
        }

        return $barcode;
    }
    
    /**
     * Modify the index query to support filtering by item_id and invoice_number
     * When only item_id is provided (and no explicit isactive filter), 
     * automatically filter by isactive = 1 for convenience
     * This allows GET /api/v1/barcode?filters=item_id eq "VALUE" to work
     * Also supports filtering by invoice_number via order_item relationship
     */
    public function modifyIndex($query)
    {
        $request = request();
        
        // Check if filters parameter exists and parse it
        $hasItemIdFilter = false;
        $hasIsactiveFilter = false;
        $invoiceNumber = null;
        
        if ($request->has('filters')) {
            $filters = $request->filters;
            // Check if item_id is in filters
            if (strpos($filters, 'item_id') !== false) {
                $hasItemIdFilter = true;
            }
            // Check if isactive is in filters
            if (strpos($filters, 'isactive') !== false) {
                $hasIsactiveFilter = true;
            }
        }
        
        // Check if invoice_number is provided as a separate parameter
        if ($request->has('invoice_number') && $request->invoice_number) {
            $invoiceNumber = $request->invoice_number;
        }
        
        // If invoice_number is provided, join with order_items and orders to filter
        if ($invoiceNumber) {
            $query = $query->join('order_items', 'order_items.id', '=', 'barcode.order_item_id')
                ->join('orders', 'orders.id', '=', 'order_items.order_id')
                ->where('orders.invoice_number', $invoiceNumber);
        }
        
        // If only item_id filter is provided (no explicit isactive filter),
        // automatically add isactive = 1 filter for convenience
        // This makes it work with just: GET /api/v1/barcode?filters=item_id eq "VALUE"
        if ($hasItemIdFilter && !$hasIsactiveFilter) {
            // Use table prefix if joins were added, otherwise use column name directly
            if ($invoiceNumber) {
                $query = $query->where('barcode.isactive', 1);
            } else {
                $query = $query->where('isactive', 1);
            }
        }
        
        return $query;
    }
    
}
