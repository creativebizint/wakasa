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
            $label = isset($this->request['label']) ? $this->request['label'] : null;
            $boxNumber = isset($this->request['box_number']) ? $this->request['box_number'] : null;
            $packingListNumber = isset($this->request['packing_list_number']) ? $this->request['packing_list_number'] : null;

            $orderType = $this->request["order_type"];
            
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
            $newOrder->label = $label;
            $newOrder->box_number = $boxNumber;
            $newOrder->packing_list_number = $packingListNumber;
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
            
            if (!$newOrder->invoice_number || $newOrder->invoice_number == "") {
                $newOrder->invoice_number = Common::getTransactionNumber($orderType);
            }

            $newOrder->save();

            // Update Stock
            $newOrder = Common::storeAndUpdateOrder($newOrder, "", $productItems);

            // Updating Warehouse History
            Common::updateWarehouseHistory('order', $newOrder, "add_edit");

            // Notifying to Warehouse
            Notify::send(str_replace('-', '_', $newOrder->order_type)  . '_create', $newOrder);
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

            // Updating Warehouse History
            Common::updateWarehouseHistory('order', $object, "add_edit");

            // Update stock history's header
            Common::updateStockHistoryHeader($oldInvoiceNumber, $object);

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
}
