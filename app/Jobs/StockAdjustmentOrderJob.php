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
use Carbon\Carbon;
use App\Classes\Common;
use App\Classes\Notify;
use App\Models\StockAdjustmentOrder;
use App\Models\StockAdjustment;

class StockAdjustmentOrderJob implements ShouldQueue, ShouldBeUnique
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

            $newStockAdjustmentOrder = new StockAdjustmentOrder();
            $newStockAdjustmentOrder->adjustment_type = $this->request["adjustment_type"];
            $newStockAdjustmentOrder->date = Carbon::parse($this->request["date"]);
            $newStockAdjustmentOrder->company_id = $this->companyId;
            $newStockAdjustmentOrder->unique_id = Common::generateOrderUniqueId();
            $newStockAdjustmentOrder->warehouse_id = Common::getIdFromHash($this->request["warehouse_id"]);
            $newStockAdjustmentOrder->created_by = $this->userId;
			$newStockAdjustmentOrder->notes = $this->request["notes"];
			$newStockAdjustmentOrder->total_items = count($productItems);
			$newStockAdjustmentOrder->total_quantity = $totalQuantities;
			$newStockAdjustmentOrder->invoice_number = $this->request["invoice_number"];
            
            if (!$newStockAdjustmentOrder->invoice_number || $newStockAdjustmentOrder->invoice_number == "") {
                $type = 'stock-adjustment-' . $newStockAdjustmentOrder->adjustment_type;
                $newStockAdjustmentOrder->invoice_number = Common::getTransactionNumber($type);
            }

            $newStockAdjustmentOrder->save();

            // Update Stock
			$newStockAdjustmentOrder = Common::storeAndUpdateStockAdjustmentOrder($newStockAdjustmentOrder, "", $productItems);
			
			// Notifying to Warehouse
			Notify::send('stock_adjustment_create', $newStockAdjustmentOrder);
        } else if ($this->context == "update") {
            $productItems = $this->request["product_items"];
            $removedItems = $this->request["removed_items"];
            $object = StockAdjustmentOrder::find($this->oldOrderId);

            $oldAdjustmentType = $object->adjustment_type;
            $oldReversedAdjustmentType = $oldAdjustmentType == 'add' ? 'subtract' : 'add';

            $oldUserId = $object->user_id;
            $oldInvoiceNumber = $object->invoice_number;
            $oldWarehouseId = $object->warehouse_id;

            $object->fill($this->request);
            $object->warehouse_id = Common::getIdFromHash($this->request["warehouse_id"]);
            $object->save();

            $newWarehouseId = $object->warehouse_id;

            // Update stock history's header
            Common::updateStockHistoryHeader($oldInvoiceNumber, $object);

            
            // if ($oldWarehouseId != $newWarehouseId) {
            //     $orderItems = StockAdjustment::where('stock_adjustment_order_id', $object->id)->get();
            //     foreach ($orderItems as $orderItem) {
            //         Common::recalculateOrderStock($oldWarehouseId, $orderItem->product_id);
            //     }
            // }

            $orderItems = StockAdjustment::where('stock_adjustment_order_id', $object->id)->get();
            foreach ($orderItems as $orderItem) {
                // If warehouse changed
                // Recalculate product from old warehouse
                if ($oldWarehouseId != $newWarehouseId) {
                    Common::asyncRecalculateOrderStock($oldWarehouseId, $oldReversedAdjustmentType, $orderItem->product_id, $orderItem->quantity);
                } else {
                    // Rollback change caused by old quantity
                    Common::asyncRecalculateOrderStock($newWarehouseId, $oldReversedAdjustmentType, $orderItem->product_id, $orderItem->quantity);
                }
            }

            // Update stock
            Common::storeAndUpdateStockAdjustmentOrder($object, $object->id, $productItems, $removedItems, $this->userId);

            // Notifying to Warehouse
            Notify::send('stock_adjustment_update', $object);

        }
        
    }
}
