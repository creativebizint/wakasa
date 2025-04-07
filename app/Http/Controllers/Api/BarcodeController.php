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
              ->select('order_items.id')->first();
          if($order == null){
            throw new ApiException('No BB tidak ditemukan');
          }
          else{
            $barcode->order_item_id = $order->id;  
          }
        }
        file_put_contents(storage_path('logs') . '/barcode.log', "[" . date('Y-m-d H:i:s') . "]test 1 : \n" . print_r($barcode,1) . "\n\n", FILE_APPEND);
        return $barcode;
    }
}
