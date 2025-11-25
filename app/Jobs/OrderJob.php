<?php

namespace App\Jobs;

use Illuminate\Bus\Batchable;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Maatwebsite\Excel\Facades\Excel;
use Examyou\RestAPI\Exceptions\ApiException;
use App\Classes\Common;
use App\Classes\Notify;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\OrderPayment;
use App\Models\Placement;

class OrderJob implements ShouldQueue, ShouldBeUnique
{
    use Batchable, Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     */
    private $context;
    private $request;
    private $oldOrderId;
    private $companyId;
    private $userId;
    
    public function __construct($context, $request, $oldOrderId,  $companyId, $userId)
    {
        $this->context = $context;
        $this->request = $request;
        $this->oldOrderId = $oldOrderId;
        $this->companyId = $companyId;
        $this->userId = $userId;
    }

    /**
     * Get the unique ID for the job.
     */
    public function uniqueId(): string
    {
        return 'orders';
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {

        if ($this->context == "store") {
            $productItems = $this->request["product_items"];
            $orderSubtotal = 0;
            $totalQuantities = 0;

            foreach ($productItems as $item) {
                $orderSubtotal += $item['subtotal'];
                $totalQuantities += $item['quantity'];
            }

            $warehouseId = isset($this->request["warehouse_id"]) ? Common::getIdFromHash($this->request["warehouse_id"]) : null;
            $fromWarehouseId = isset($this->request["from_warehouse_id"]) ? Common::getIdFromHash($this->request["from_warehouse_id"]) : null;
            $userId = isset($this->request["user_id"]) ? Common::getIdFromHash($this->request["user_id"]) : null;
            $sales_id = isset($this->request["sales_id"]) ? Common::getIdFromHash($this->request["sales_id"]) : null;
            
            if($sales_id != ''){
                $sales_order = Order::where('id',$sales_id)->select('invoice_number')->first();
                $refference = $sales_order->invoice_number;
            }
            else{
                $refference = '';
            }
            
//            $label = isset($this->request['label']) ? $this->request['label'] : null;
//            $boxNumber = isset($this->request['box_number']) ? $this->request['box_number'] : null;
//            $packingListNumber = isset($this->request['packing_list_number']) ? $this->request['packing_list_number'] : null;

            $orderType = $this->request["order_type"];
            $do_process = 0;
            
            if($orderType == 'inventory_in'){
                $orderType = 'purchases';
            }
            elseif($orderType == 'inventory_out'){
                $orderType = 'sales_order';
            }
            elseif($orderType == 'delivery_order'){
                $do_process = 1;
                $orderType = 'sales';
            }
            
            $newOrder = new Order();
            $newOrder->company_id = $this->companyId;
            $newOrder->unique_id = Common::generateOrderUniqueId();
            $newOrder->order_type = $orderType;
            $newOrder->order_date = $this->request["order_date"];
            $newOrder->warehouse_id = $warehouseId;
            $newOrder->from_warehouse_id = $fromWarehouseId;
            $newOrder->user_id = $userId;
            $newOrder->tax_id = null;
            $newOrder->tax_rate = 0;
            $newOrder->discount = 0;
            $newOrder->shipping = 0;
            $newOrder->paid_amount = 0;
            $newOrder->order_status = $this->request["order_status"];
            $newOrder->notes = $this->request["notes"];
            $newOrder->payment_status = 'unpaid';
            $newOrder->total_items = count($productItems);
            $newOrder->priority = isset($this->request["priority"])?$this->request["priority"]:'';
//            $newOrder->label = $label;
//            $newOrder->box_number = $boxNumber;
//            $newOrder->packing_list_number = $packingListNumber;
            $newOrder->total_quantity = 0;
            $newOrder->subtotal = 0;
            $newOrder->total = 0;
            $newOrder->due_amount = 0;
            $newOrder->total_quantity = $totalQuantities;
            $newOrder->subtotal = $orderSubtotal;
            $newOrder->total = $orderSubtotal;
            $newOrder->due_amount = $orderSubtotal;
            $newOrder->staff_user_id = $this->userId;
            $newOrder->invoice_number = $this->request["invoice_number"];
            $newOrder->refference = $refference;
            $newOrder->delivery_address  = isset($this->request["shipping_address"])?$this->request["shipping_address"]:'';
            $newOrder->city  = isset($this->request["city"])?$this->request["city"]:'';
            $newOrder->shipping_alias  = isset($this->request["shipping_alias"])?$this->request["shipping_alias"]:'';
            
            if(isset($this->request["combine_shipment_number"]) && $this->request["combine_shipment_number"] != ''){
                $combine_invoice_number = Order::where('invoice_number', 'like','%'.$this->request["combine_shipment_number"].'%')
                    ->orderBy('id','desc')
                    ->select('invoice_number')
                    ->first();
                if($combine_invoice_number == null){
                    throw new ApiException("Invalid Invoice Number");
                }
                $combine_invoice_number_ = $combine_invoice_number->invoice_number;
                $newOrder->invoice_number = $this->incrementCombineDeliveryCode($combine_invoice_number_);
            }
            
            
            if (!$newOrder->invoice_number || $newOrder->invoice_number == "") {
                $newOrder->invoice_number = Common::getTransactionNumber($orderType);
            }

            $newOrder->save();
            
            
                file_put_contents(storage_path('logs') . '/order.log', "[" . date('Y-m-d H:i:s') . "]order 1 : \n" . print_r($newOrder,1) . "\n\n", FILE_APPEND);
                // Update Stock
                if($do_process == 0){
                    $newOrder = Common::storeAndUpdateOrder($newOrder, "", $productItems);
                }
                else{
                    //DO process copy the item from SO to DO
                    foreach ($productItems as $item) {
                        $so_order_items = OrderItem::where('id',Common::getIdFromHash($item['item_id']))->first();
                        
                        file_put_contents(storage_path('logs') . '/order.log', "[" . date('Y-m-d H:i:s') . "]so id : \n" . Common::getIdFromHash($item['xid']).':' .print_r($so_order_items,1) . "\n\n", FILE_APPEND);
                        
                        $new_order_item = new OrderItem();
                        $new_order_item->user_id = $so_order_items->user_id;
                        $new_order_item->order_id = $newOrder->id;
                        $new_order_item->product_id = $so_order_items->product_id;
                        $new_order_item->quantity_done = 0;
                        $new_order_item->quantity = $item['quantity'];
                        $new_order_item->quantity_scanned = $so_order_items->quantity_scanned;
                        $new_order_item->picker_by = $so_order_items->picker_by;
                        $new_order_item->picker_by_name = $so_order_items->picker_by_name;
                        $new_order_item->save();
                        
                                               
            $barcodes = Placement::join('placement_items','placement_items.placement_id','=','placements.id')
                        ->join('barcode','barcode.id','=','placement_items.barcode_id')
                        ->whereNull('order_item_out_id')
                        ->where('reference','=',$so_order_items->id)
                        ->select('barcode.*')
                        ->get();

            file_put_contents(storage_path('logs') . '/barcode.log', "[" . date('Y-m-d H:i:s') . "]reference : \n" .$so_order_items->id . "\n\n", FILE_APPEND);
            file_put_contents(storage_path('logs') . '/barcode.log', "[" . date('Y-m-d H:i:s') . "]barcode : \n" .print_r($barcodes,1) . "\n\n", FILE_APPEND);
            
            $qty_barcode = $item['quantity'];
            $barcodeids = [];
            foreach($barcodes as $barcode){
                $qty_barcode = $qty_barcode - $barcode->qty_bungkus;
                if($qty_barcode > 0){
                    $barcodeids[] = $barcode->id;
                }elseif($qty_barcode == 0){
                    $barcodeids[] = $barcode->id;
                    break;
                }else{
                    throw new ApiException("Qr code Qty is not match");
                }
            }
            
            foreach($barcodeids as $barcodeid){
                \App\Models\Barcode::where('id',$barcodeid)
                        
                        ->update(['order_item_out_id'=>$new_order_item->id]);
            }
                        
                        
                        $so_order_items->update(['quantity_done'=> $item['quantity']]);
                        
                        
                    }
                    
                    $order_item = new OrderItem;
                    $order_item->user_id = '';
                }
                
           
            if(!in_array(strtolower($newOrder->order_status),['ordered','confirmed','processing','shipping','open','qc'])){    
                // Updating Warehouse History
                Common::updateWarehouseHistory('order', $newOrder, "add_edit");

                // Notifying to Warehouse
                Notify::send(str_replace('-', '_', $newOrder->order_type)  . '_create', $newOrder);
            }
            
        } else if ($this->context == "update") {
            $productItems = $this->request["product_items"];
            $removedItems = $this->request["removed_items"];
            $object = Order::find($this->oldOrderId);
            $orderType = $object->order_type;
            $oldUserId = $object->user_id;
            $oldInvoiceNumber = $object->invoice_number;
            $oldWarehouseId = $orderType == 'stock-transfers' || $orderType == 'stock-transfer-returns' ? $object->from_warehouse_id : $object->warehouse_id;

            $oldExactWarehouseId = $object->warehouse_id;
            $oldExactFromWarehouseId = $object->from_warehouse_id;

            $orderPaymentCount = OrderPayment::where('order_id', $this->oldOrderId)->count();

            if ($orderPaymentCount > 0) {
                $object->order_status = $this->request["order_status"];
            } else {
                $object->fill($this->request);
            }

            $warehouseId = isset($this->request["warehouse_id"]) ? Common::getIdFromHash($this->request["warehouse_id"]) : null;
            $fromWarehouseId = isset($this->request["from_warehouse_id"]) ? Common::getIdFromHash($this->request["from_warehouse_id"]) : null;
            $userId = isset($this->request["user_id"]) ? Common::getIdFromHash($this->request["user_id"]) : null;
            
            $object->warehouse_id = $warehouseId;
            $object->from_warehouse_id = $fromWarehouseId;
            $object->user_id = $userId;

            $object->save();

            $newWarehouseId = $orderType == 'stock-transfers' || $orderType == 'stock-transfer-returns' ? $object->from_warehouse_id : $object->warehouse_id;

            // If user changed then
            // Update his order_count & order_return_count
            if ($oldUserId != $object->user_id) {
                Common::updateUserAmount($oldUserId, $object->warehouse_id);
            }

            if(!in_array(strtolower($newOrder->order_status),['ordered','confirmed','processing','shipping','open'])){    
                // Updating Warehouse History
                Common::updateWarehouseHistory('order', $object, "add_edit");

                // Update stock history's header
                Common::updateStockHistoryHeader($oldInvoiceNumber, $object);
            }

            // If warehouse changed
            // Recalculate product from old warehouse
            // if ($oldWarehouseId != $newWarehouseId) {
            //     $orderItems = OrderItem::where('order_id', $object->id)->get();
            //     foreach ($orderItems as $orderItem) {
            //         Common::recalculateOrderStock($oldWarehouseId, $orderItem->product_id);
            //     }
            // }
            
            $operation = Common::getOrderOperation($orderType, $warehouseId);
            $reversedOperation = $operation == 'add' ? 'subtract' : 'add';

            $oldWarehouseOperation = Common::getOrderOperation($orderType, $oldExactWarehouseId);
            $oldWarehouseReversedOperation = $oldWarehouseOperation == 'add' ? 'subtract' : 'add';

            $orderItems = OrderItem::where('order_id', $object->id)->get();
            foreach ($orderItems as $orderItem) {
                // If warehouse changed
                // Recalculate product from old warehouse
                if (($oldExactWarehouseId != $warehouseId) || ($oldExactFromWarehouseId != $fromWarehouseId)) {
                    if ($oldExactWarehouseId != $warehouseId) {
                        if ($orderType == "stock-transfers" || $orderType == "stock-transfer-returns") {
                            Common::asyncRecalculateOrderStock($fromWarehouseId, $operation, $orderItem->product_id, $orderItem->quantity);
                            Common::asyncRecalculateOrderStock($oldExactWarehouseId, $oldWarehouseReversedOperation, $orderItem->product_id, $orderItem->quantity);
                        } else {
                            Common::asyncRecalculateOrderStock($oldExactWarehouseId, $oldWarehouseReversedOperation, $orderItem->product_id, $orderItem->quantity);
                        }
                    }
                    if ($oldExactFromWarehouseId != $fromWarehouseId) {
                        if ($orderType == "stock-transfers" || $orderType == "stock-transfer-returns") {
                            Common::asyncRecalculateOrderStock($oldExactFromWarehouseId, $oldWarehouseOperation, $orderItem->product_id, $orderItem->quantity);
                            Common::asyncRecalculateOrderStock($warehouseId, $reversedOperation, $orderItem->product_id, $orderItem->quantity);
                        } else {
                            Common::asyncRecalculateOrderStock($oldExactWarehouseId, $oldWarehouseReversedOperation, $orderItem->product_id, $orderItem->quantity);
                        }
                    }
                } else {
                    // Rollback change caused by old quantity
                    if ($orderType == "stock-transfers" || $orderType == "stock-transfer-returns") {
                        Common::asyncRecalculateOrderStock($fromWarehouseId, $operation, $orderItem->product_id, $orderItem->quantity);
                        Common::asyncRecalculateOrderStock($warehouseId, $reversedOperation, $orderItem->product_id, $orderItem->quantity);
                    } else {
                        Common::asyncRecalculateOrderStock($warehouseId, $reversedOperation, $orderItem->product_id, $orderItem->quantity);
                    }
                }
            }

            Common::storeAndUpdateOrder($object, $object->id, $productItems, $removedItems, $this->userId);

            // Notifying to Warehouse
            Notify::send(str_replace('-', '_', $orderType) . '_update', $object);
        }
        
    }
    
    function incrementCombineDeliveryCode($delivery_code) {
        // Check if the code contains #
        if (strpos($delivery_code, '#') !== false) {
            // Extract the prefix and suffix
            list($base, $suffix) = explode('#', $delivery_code);

            // Increment the character if it's A–Y
            if (strlen($suffix) === 1 && ctype_upper($suffix)) {
                if ($suffix !== 'Z') {
                    $nextChar = chr(ord($suffix) + 1);
                    return $base . '#' . $nextChar;
                } else {
                    // If Z is reached, you can decide what to do
                    // Option 1: Reset to A
                    // return $base . '#A';

                    // Option 2: Throw an error
                    throw new Exception("Delivery code has reached the limit: $delivery_code");
                }
            } else {
                throw new Exception("Invalid delivery code suffix format: $delivery_code");
            }
        } else {
            // If no # exists, add #A
            return $delivery_code . '#A';
        }
    }

}
