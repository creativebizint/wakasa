<?php

namespace App\Traits;

use App\Classes\Common;
use App\Classes\Notify;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\OrderPayment;
use App\Models\Payment;
use App\Models\ProductDetails;
use App\Models\StockHistory;
use App\Models\Unit;
use App\Models\User;
use App\Models\Product;
use App\Models\ProductPlacementRow;
use App\Models\ProductPlacement;
use App\Models\Placement;
use App\Models\PlacementItem;
use App\Models\WarehouseStock;
use App\Models\ScannedHistory;
use App\Models\ScannedHistoryItems;
use App\Models\Warehouse;
use App\Models\Barcode;
use Carbon\Carbon;
use Examyou\RestAPI\ApiResponse;
use Examyou\RestAPI\Exceptions\ApiException;
use Examyou\RestAPI\Exceptions\ResourceNotFoundException;
use Vinkla\Hashids\Facades\Hashids;
use Illuminate\Support\Facades\Request;
use DB;

use Illuminate\Support\Facades\Bus;

trait OrderTraits
{
    public $orderType = "";

    protected function modifyIndex($query)
    {
        $request = request();
        $warehouse = warehouse();
        $user = user();
        
        $query = $query->where('orders.order_type', $this->orderType);

        // Dates Filters
        if ($request->has('dates') && $request->dates != "") {
            $dates = explode(',', $request->dates);
            $startDate = $dates[0];
            $endDate = $dates[1];

            $query = $query->whereRaw('orders.order_date >= ?', [$startDate])
                ->whereRaw('orders.order_date <= ?', [$endDate]);
        }
        
        if ($request->has('item_id') && $request->item_id != "") {
            //$product = Product::where('item_id','like','%'.$request->item_id.'%')->select('id')->first();
            $query = $query->join('order_items','order_items.order_id','=','orders.id')
                    ->join('products','products.id','=','order_items.product_id')
                    ->where('products.item_id','like','%'.$request->item_id.'%');
        }

        // Can see only order of warehouses which is assigned to him
        if($user->role->name != 'admin'){
            if ($this->orderType == 'stock-transfers') {
                if ($request->transfer_type == 'transfered') {
                    $query = $query->where('orders.from_warehouse_id', $warehouse->id);
                } else {
                    $query = $query->where('orders.warehouse_id', $warehouse->id);
                }
            } else {
                $query = $query->where('orders.warehouse_id', $warehouse->id);
            }
        }
        

        return $query;
    }

    public function show(...$args)
    {
        $request = request();
        $xid = last(func_get_args());
        $id = Common::getIdFromHash($xid);

        if ($request->has('fields')) {
            $this->validate();

            $results = $this->parseRequest()
                ->addIncludes()
                ->addKeyConstraint($id)
                ->getResults(true)
                ->first()
                ->toArray();

            $meta = $this->getMetaData(true);

            return ApiResponse::make(null, $results, $meta);
        } else {
            $orderDetails = Order::find($id);
            $orderType = $orderDetails->order_type;
            $allProducs = [];
            $selectProductIds = [];
            $sn = 1;

            $allOrderIteams = OrderItem::with('product')->where('order_id', $id)->get();

            foreach ($allOrderIteams as $allOrderIteam) {

                $productDetails = ProductDetails::withoutGlobalScope('current_warehouse')
                    ->where('warehouse_id', '=', $orderDetails->warehouse_id)
                    ->where('product_id', '=', $allOrderIteam->product_id)
                    ->first();

                $maxQuantity = $productDetails->current_stock;
                $unit = $allOrderIteam->unit_id != null ? Unit::find($allOrderIteam->unit_id) : null;

                if ($orderType == 'purchase-returns' || $orderType == 'sales') {
                    $maxQuantity = $allOrderIteam->quantity + $maxQuantity;
                }

                $allProducs[] = [
                    'sn'    =>  $sn,
                    'xid'    =>  Common::getHashFromId($allOrderIteam->product_id),
                    'item_id'    =>  $allOrderIteam->xid,
                    'product_item_id'    =>  $allOrderIteam->product->item_id,
                    'description'    =>  $allOrderIteam->product->description,
                    'product_code'    =>  $allOrderIteam->product->item_code,
                    'text1'    =>  $allOrderIteam->product->text1,
                    'subgroup2'    =>  $allOrderIteam->product->subgroup2,
                    'sat'    =>  $unit->name,
                    'name'    =>  $allOrderIteam->product->name,
                    'image'    =>  $allOrderIteam->product->image,
                    'image_url'    =>  $allOrderIteam->product->image_url,
                    'x_tax_id'    =>   Common::getHashFromId($allOrderIteam->tax_id),
                    'discount_rate'    =>  $allOrderIteam->discount_rate,
                    'total_discount'    =>  $allOrderIteam->total_discount,
                    'total_tax'    =>  $allOrderIteam->total_tax,
                    'unit_price'    =>  $allOrderIteam->unit_price,
                    'single_unit_price'    =>  $allOrderIteam->single_unit_price,
                    'subtotal'    =>  $allOrderIteam->subtotal,
                    'quantity'    =>  $allOrderIteam->quantity,
                    'qr_scanned_in'    => $allOrderIteam->quantity_scanned,
                    'qr_scanned_out'    => Barcode::where('order_item_out_id',Common::getIdFromHash($allOrderIteam->xid))->count(),
                    'tax_rate'    =>  $allOrderIteam->tax_rate,
                    'tax_type'    =>  $allOrderIteam->tax_type,
                    'x_unit_id'    =>  Common::getHashFromId($allOrderIteam->unit_id),
                    'unit'    =>  $unit,
                    'stock_quantity' => $maxQuantity,
                    'unit_short_name' => $unit && $unit->short_name ? $unit->short_name : '',
                    'product_type' => $allOrderIteam->product->product_type,
                    'shelf' => isset($allOrderIteam->shelf) ? $allOrderIteam->shelf : '',
                ];

                $selectProductIds[] = Common::getHashFromId($allOrderIteam->product_id);
                $sn++;
            }

            $user = User::select('id', 'name', 'phone')->find($orderDetails->user_id);
            
            //* ADDENDUM
            $warehouse = Warehouse::select('id', 'name', 'phone')->find($orderDetails->warehouse_id);

            return ApiResponse::make('Data fetched', [
                'order' => $orderDetails,
                'items' => $allProducs,
                'ids' => $selectProductIds,
                'user' => $user,
                'ss'=> 'ddd',
                //* ADDENDUM
                'warehouse' => $warehouse,
            ]);
        }
    }

//    public function storing(Order $order)
//    {
//        $request = request();
//        $warehouse = warehouse();
//
//        if (!$request->has('invoice_number') || ($request->has('invoice_number') && $request->invoice_number == "")) {
//            $order->invoice_number = '';
//        }
//        //    dd($request->warehouse_id );
//        $order->unique_id = Common::generateOrderUniqueId();
//        $order->order_type = $this->orderType;
//        $order->warehouse_id = $this->orderType == 'stock-transfers' ? $request->warehouse_id : $warehouse->id;
//        $order->from_warehouse_id = $this->orderType == 'stock-transfers' ? $warehouse->id : null;
//        $order->user_id = $this->orderType == 'stock-transfers' ? null : $request->user_id;
//
//        if ($this->orderType == "quotations") {
//            $order->order_status = "pending";
//        }
//
//        return $order;
//    }
    
    public function store()
    {
        $this->validate();

        $request = request();
		$meta = $this->getMetaData(true);

        $batch = Bus::batch([new \App\Jobs\OrderJob("store", $request->all(), null, company()->id, user()->id)])
            ->onQueue('orders')
            ->dispatch();

        $response = [
            'id' => $batch->id,
            'finished' => $batch->finished(),
            'cache_key' => null,
            'progress' => [
                'percent' => $batch->progress(),
                'status' => 'active',
                'message' => '',
            ],
        ];
            
	return ApiResponse::make("Resource is being processed", $response, $meta);
    }

//    public function stored(Order $order)
//    {
//        $request = request();
//        $oldOrderId = "";
//
//        if ($order->invoice_number == '') {
//            $order->invoice_number = Common::getTransactionNumber($order->order_type, $order->id);
//        }
//
//        // Created by user
//        $order->staff_user_id = auth('api')->user()->id;
//        $order->save();
//
//        $order = Common::storeAndUpdateOrder($order, $oldOrderId);
//
//        // Updating Warehouse History
//        Common::updateWarehouseHistory('order', $order, "add_edit");
//
//        // Notifying to Warehouse
//        Notify::send(str_replace('-', '_', $order->order_type)  . '_create', $order);
//
//
//        $allPayments = $request->has('all_payments') && count($request->all_payments) == 0 ? [] : $request->all_payments;
//
//        foreach ($allPayments as $allPayment) {
//            // Save Order Payment
//            if ($allPayment['amount'] > 0 && $allPayment['payment_mode_id'] != '') {
//                $payment = new Payment();
//                $payment->warehouse_id = $order->warehouse_id;
//                if ($order->order_type == 'sales' || $order->order_type == 'purchase-returns') {
//                    $payment->payment_type = "in";
//                } elseif ($order->order_type == 'purchases' || $order->order_type == 'sales-returns') {
//                    $payment->payment_type = "out";
//                }
//                $payment->date = Carbon::now();
//                if ($allPayment['amount'] == $order->total) {
//                    $payment->amount = $allPayment['amount'];
//                } elseif ($allPayment['amount'] > $order->total || $allPayment['amount'] < $order->total) {
//                    throw new ApiException('Paid amount should be less than or equal to Grand Total');
//                }
//                $payment->paid_amount = $allPayment['amount'];
//                $payment->payment_mode_id = $allPayment['payment_mode_id'];
//                $payment->notes = null;
//                $payment->user_id = $order->user_id;
//                $payment->save();
//
//                // Generate and save payment number
//                $paymentType = 'payment-' . $payment->payment_type;
//                $payment->payment_number = Common::getTransactionNumber($paymentType, $payment->id);
//                $payment->save();
//
//                $orderPayment = new OrderPayment();
//                $orderPayment->order_id = $order->id;
//                $orderPayment->payment_id = $payment->id;
//                $orderPayment->amount = $allPayment['amount'];
//                $orderPayment->save();
//            }
//        }
//
//        Common::updateOrderAmount($order->id);
//
//        return $order;
//    }

    public function updating(Order $order)
    {
        $loggedUser = user();
        $warehouse = warehouse();

        // If logged in user is not admin
        // then cannot update order who are
        // of other warehouse
        if (!$loggedUser->hasRole('admin') && $order->warehouse_id != $warehouse->id) {
            throw new ApiException("Don't have valid permission");
        }

        $order->order_type = $this->orderType;

        return $order;
    }

    public function invoiceCheck(){
        $invoice_number = isset($_GET['invoice_number'])?$_GET['invoice_number']:'';
        $order = [];
        if($invoice_number != ''){
          $order = Order::where('invoice_number',$invoice_number)->first();  
        }

        
        return ['data'=>$order];
    }
    
    public function update(...$args)
    {
        \DB::beginTransaction();

        // Geting id from hashids
        $xid = last(func_get_args());
        $convertedId = Hashids::decode($xid);
        $id = $convertedId[0];

        $this->validate();

        // Get object for update
        $this->query = call_user_func($this->model . "::query");

        /** @var ApiModel $object */
        $object = $this->query->find($id);

        if (!$object) {
            throw new ResourceNotFoundException();
        }

        $oldUserId = $object->user_id;

        $orderPaymentCount = OrderPayment::where('order_id', $id)->count();
        $request = request();

        if ($orderPaymentCount > 0) {
            $object->order_status = $request->order_status;
        } else {
            $object->fill(request()->all());
        }

        if (method_exists($this, 'updating')) {
            $object = call_user_func([$this, 'updating'], $object);
        }

        $object->save();

        $meta = $this->getMetaData(true);

        \DB::commit();

        if (method_exists($this, 'updated')) {
            call_user_func([$this, 'updated'], $object);
        }

        // If user changed then
        // Update his order_count & order_return_count
        if ($oldUserId != $object->user_id) {
            Common::updateUserAmount($oldUserId, $object->warehouse_id);
        }

        // Updating Warehouse History
        Common::updateWarehouseHistory('order', $object, "add_edit");

        return ApiResponse::make("Resource updated successfully", ["xid" => $object->xid], $meta);
    }

    public function updated(Order $order)
    {
        $oldOrderId = $order->id;
        Common::storeAndUpdateOrder($order, $oldOrderId);

        // Notifying to Warehouse
        Notify::send(str_replace('-', '_', $order->order_type) . '_update', $order);
    }

    public function destroy(...$args)
    {
        \DB::beginTransaction();

        // Geting id from hashids
        $xid = last(func_get_args());
        $convertedId = Hashids::decode($xid);
        $id = $convertedId[0];

        $this->validate();

        // Get object for update
        $this->query = call_user_func($this->model . "::query");

        /** @var Model $object */
        $object = $this->query->find($id);

        if (!$object) {
            throw new ResourceNotFoundException();
        }

        if (method_exists($this, 'destroying')) {
            $object = call_user_func([$this, 'destroying'], $object);
        }

        $order = $object;
        $loggedUser = user();
        $orderItems = $order->items;
        $orderType = $order->order_type;
        $warehouseId = $order->warehouse_id;
        $fromWarehouseId = $order->from_warehouse_id;
        $orderUserId = $order->user_id;

        // If logged in user is not admin
        // then cannot delete order who are
        // of other warehouse
        if (!$loggedUser->hasRole('admin') && $order->warehouse_id != $loggedUser->warehouse_id) {
            throw new ApiException("Don't have valid permission");
        }

        foreach ($orderItems as $orderItem) {

            $stockHistory = new StockHistory();
            $stockHistory->warehouse_id = $warehouseId;
            $stockHistory->product_id = $orderItem->product_id;
            $stockHistory->quantity = 0;
            $stockHistory->old_quantity = $orderItem->quantity;
            $stockHistory->order_type = $orderType;
            $stockHistory->stock_type = $orderType == 'sales' || $orderType == 'sales_order' || $orderType == 'purchase-returns' ? 'out' : 'in';
            $stockHistory->action_type = "delete";
            $stockHistory->created_by = $loggedUser->xid;
            $stockHistory->save();
        }

        // Notifying to Warehouse
        Notify::send(str_replace('-', '_', $object->order_type) . '_delete', $object);

        $object->delete();

        foreach ($orderItems as $orderItem) {
            $productId = $orderItem->product_id;

            // Update warehouse stock for product
            Common::recalculateOrderStock($warehouseId, $productId);

            if ($orderType == "stock-transfers") {
                Common::recalculateOrderStock($fromWarehouseId, $productId);
            }
        }

        // Update Customer or Supplier total amount, due amount, paid amount
        Common::updateUserAmount($orderUserId, $order->warehouse_id);

        // Updating Warehouse History
        Common::updateWarehouseHistory('order', $order);

        $meta = $this->getMetaData(true);

        \DB::commit();

        return ApiResponse::make("Resource deleted successfully", null, $meta);
    }
    
    
    public function scannedBarcode($xid){
        $id = Common::getIdFromHash($xid);
        $barcode = Barcode::where('order_item_id',$id)
                    ->where('isactive',1)
                    ->where('status','>=',Barcode::STATUS_IN)
                    ->get();
        $selectProductIds = [];
        foreach($barcode as $barcode_detail){            
          $selectProductIds[] = Common::getHashFromId($barcode_detail->id);  
        }
        $order_item = OrderItem::where('order_items.id',$id)
                       ->join('products','products.id','order_items.product_id')
                       ->select('order_items.id','order_items.quantity','products.item_id','order_items.order_id','quantity_scanned')
                       ->first();
        
        $barcode_in = Barcode::where('order_item_id',$id)
                        ->where('item_id',$order_item->item_id)
                        ->where('status','>=',Barcode::STATUS_IN)
                        ->selectRaw("sum(qty_bungkus) as total_in")
                        ->groupBy('item_id','order_item_id')
                        ->first();
        if($barcode_in == null){
            $order_item->quantity_in = 0;
        }
        else{
            $order_item->quantity_in = $barcode_in->total_in;
        }
        
        return ['total' =>count($barcode), 'data' => $barcode,'ids'=>$selectProductIds, 'order_item' => $order_item];
    }
    public function barcode($xid){
        $id = Common::getIdFromHash($xid);
        $barcode = Barcode::where('order_item_id',$id)->get();
        $selectProductIds = [];
        foreach($barcode as $barcode_detail){
            
          $selectProductIds[] = Common::getHashFromId($barcode_detail->id);  
        }
        $order_item = OrderItem::where('order_items.id',$id)
                       ->join('products','products.id','order_items.product_id')
                       ->select('order_items.id','order_items.quantity','products.item_id','order_items.order_id','quantity_scanned','nik')
                       ->first();
        
        $barcode_in = Barcode::where('order_item_id',$id)
                        ->where('item_id',$order_item->item_id)
                        ->where('status','>=',Barcode::STATUS_IN)
                        ->selectRaw("sum(qty_bungkus) as total_in")
                        ->groupBy('item_id','order_item_id')
                        ->first();
        if($barcode_in == null){
            $order_item->quantity_in = 0;
        }
        else{
            $order_item->quantity_in = $barcode_in->total_in;
        }
        
        return ['total' =>count($barcode), 'data' => $barcode,'ids'=>$selectProductIds, 'order_item' => $order_item];
    }
    
    public function barcodeRegister(Request $request){
        $message = '';
        DB::beginTransaction();
        try{
            $request = $request::all();        
            $xorder_item_id = $request['order_item_id'];
            $item_id = $request['item_id'];
            $nik = isset($request['nik'])?$request['nik']:'';
            $row = isset($request['row']) ? $request['row'] : '';
            $order_item_id = Common::getIdFromHash($xorder_item_id);
            $loggedUser = user();
            $user_id = Common::getIdFromHash($loggedUser->xid);
            $product_items = $request['product_items'];

            $order = OrderItem::where('id',$order_item_id)->first();
            
            if($row != ''){
                //place in
                $company = company();
                $warehouse = warehouse();
                $row_detail = ProductPlacementRow::where('value',$row)->first();
                
                if($row_detail == null){
                    throw new ApiException('Rak tidak teregistrasi: '.$row);
                }
                
                $placement = new Placement();
                $placement->company_id = $company->id;
                $placement->invoice_number = '';
                $placement->unique_id = Common::generateOrderUniqueId();
                $placement->invoice_type = "product-placement";
                $placement->placement_type = "in";
                $placement->placement_date = date('Y-m-d H:i:s');
                $placement->warehouse_id = $warehouse->id;
                $placement->notes = '';
                $placement->staff_user_id = $loggedUser->id;
                $placement->user_id = $loggedUser->id;
                $placement->total_items = count($product_items);
                $placement->total_quantity = 0;
                $placement->save();

                $type = 'product-placement-in';
                $placement->invoice_number = Common::getTransactionNumber($type);
                $placement->save();
                $total_qty = 0;
                foreach($product_items as $product_item){
                    $placement_item = new PlacementItem();
                    $placement_item->placement_id = $placement->id;
                    $placement_item->barcode_id = Common::getIdFromHash($product_item['xid']);
                    $placement_item->row = $row_detail->id;
                    $placement_item->save();
                    
                    $product_placement = new ProductPlacement();
                    $product_placement->placement_id = $placement->id;
                    $product_placement->barcode_id = Common::getIdFromHash($product_item['xid']);
                    $product_placement->row = $row_detail->id;
                    $product_placement->warehouse_id = $warehouse->id;
                    $product_placement->save();
                    
                    $total_qty += $product_item['qty_bungkus'];                     
                    Barcode::where('id',Common::getIdFromHash($product_item['xid']))->update(['status' => Barcode::STATUS_IN ]);
                }
                

                $placement->total_quantity = $total_qty;
                $placement->save();
                
                $message = 'Masukkan produk ke rak telah berhasil';
            }
            else{
                //scan only
                $scannedHistory_last = ScannedHistory::where('order_id',$order->id)
                                ->where('order_item_id', $order_item_id)
                                ->orderBy('id','desc')
                                ->select('batch')
                                ->first();

                if($scannedHistory_last == null){
                    $batch = 1;
                }
                else{
                    $batch = $scannedHistory_last->batch+1;
                }
                
                $scanned_history = new ScannedHistory();
                $scanned_history->batch = $batch;
                $scanned_history->staff_user_id = $user_id;
                $scanned_history->order_id = $order->id;
                $scanned_history->order_item_id = $order_item_id;
                $scanned_history->save();

                $total_scanned = 0;
                foreach($product_items as $product_item){
                    $count = ScannedHistoryItems::where('barcode_id',Common::getIdFromHash($product_item['xid']))->count();
                    if($count == 0){
                        $scanned_history_items = new ScannedHistoryItems();
                        $scanned_history_items->scanned_history_id = $scanned_history->id;
                        $scanned_history_items->barcode_id = Common::getIdFromHash($product_item['xid']);
                        $scanned_history_items->qty = $product_item['qty_bungkus'];
                        $scanned_history_items->save();
                        Barcode::where('id',Common::getIdFromHash($product_item['xid']))->update(['isactive'=>'1','order_item_id' => $order_item_id,'item_id' => $item_id,'scanned_in_by'=> $user_id, 'status' => Barcode::STATUS_SCANNED, 'nik' => $nik, 'qty_bungkus' => $product_item['qty_bungkus'], 'comment' => isset($product_item['comment'])?$product_item['comment']:''  ,'reg_bungkus_id' => Common::generateOrderUniqueId(),'box_id' => Common::generateOrderUniqueId()]);
                        $total_scanned += $product_item['qty_bungkus'];
                    }                    
                }
                $scanned_history->qty_scanned = $total_scanned;
                $scanned_history->save();

                //calculate total scanned
                $all_scanned = ScannedHistory::where('order_id',$order->id)
                                    ->where('order_item_id', $order_item_id)->selectRaw("sum(qty_scanned) as total")->first();
                $barcodes = Barcode::where('order_item_id',$order_item_id)->get();
                $total_scanned_qty = $total_qrcode = 0;
                foreach($barcodes as $barcode_data){
                    $total_scanned_qty += $barcode_data->qty_bungkus;
                    $total_qrcode++;
                }
                OrderItem::where('id',$order_item_id)->update(['quantity_scanned'=>$total_scanned_qty, 'quantity_qrcode'=>$total_qrcode]);

                $message = 'Barcode telah berhasil di scan';
            }
        } catch (\Exception $ex) {
            DB::rollback();
            throw new ApiException($ex->getMessage());
        }
        DB::commit();
        return ['total' =>count($product_items), 'message' => $message];
    }
    
    public function barcodeOut(Request $request){
        $message = '';
        DB::beginTransaction();
        try{
            $request = $request::all();        
            $xorder_item_id = $request['order_item_id'];
            $item_id = $request['item_id'];
            $nik = isset($request['nik'])?$request['nik']:'';
            $row = isset($request['row']) ? $request['row'] : '';
            $order_item_id = Common::getIdFromHash($xorder_item_id);
            $loggedUser = user();
            $user_id = Common::getIdFromHash($loggedUser->xid);
            $product_items = $request['product_items'];

            $order = OrderItem::where('id',$order_item_id)->first();
            
            $company = company();
            $warehouse = warehouse();
            $row_detail = ProductPlacementRow::where('value',$row)->first();

            if($row_detail == null){
                throw new ApiException('Rak tidak teregistrasi: '.$row);
            }
                
            $placement = new Placement();
            $placement->company_id = $company->id;
            $placement->invoice_number = '';
            $placement->unique_id = Common::generateOrderUniqueId();
            $placement->invoice_type = "product-placement";
            $placement->placement_type = "out";
            $placement->placement_date = date('Y-m-d H:i:s');
            $placement->warehouse_id = $warehouse->id;
            $placement->notes = '';
            $placement->staff_user_id = $loggedUser->id;
            $placement->user_id = $loggedUser->id;
            $placement->total_items = count($product_items);
            $placement->total_quantity = 0;
            $placement->reference = $order_item_id;
            $placement->save();

            $type = 'product-placement-out';
            $placement->invoice_number = Common::getTransactionNumber($type);
            $placement->save();
            $total_qty = 0;
            foreach($product_items as $product_item){
                $placement_item = new PlacementItem();
                $placement_item->placement_id = $placement->id;
                $placement_item->barcode_id = Common::getIdFromHash($product_item['xid']);
                $placement_item->row = $row_detail->id;
                $placement_item->save();

                $product_placement = new ProductPlacement();
                $product_placement->placement_id = $placement->id;
                $product_placement->barcode_id = Common::getIdFromHash($product_item['xid']);
                $product_placement->row = $row_detail->id;
                $product_placement->warehouse_id = $warehouse->id;
                $product_placement->save();

                $total_qty += $product_item['qty_bungkus'];                     
                Barcode::where('id',Common::getIdFromHash($product_item['xid']))->update(['status' => Barcode::STATUS_SO ]);
            }


            $placement->total_quantity = $total_qty;
            $placement->save();

            //calculate total scanned
            $placements = Placement::where('reference',$order_item_id)->selectRaw("sum(total_quantity) as total_scanned, sum(total_items) as total_qrcode")
                    ->groupBy('reference')
                    ->first();

            OrderItem::where('id',$order_item_id)->update(['quantity_scanned'=>$placements->total_scanned, 'quantity_qrcode'=>$placements->total_qrcode]);

            $message = 'Picking produk telah berhasil';
        } catch (\Exception $ex) {
            DB::rollback();
            throw new ApiException($ex->getMessage());
        }
        DB::commit();
        return ['total' =>count($product_items), 'message' => $message];
    }
    
};
