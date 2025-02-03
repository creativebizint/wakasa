<?php

namespace App\Http\Controllers\Api;

use App\Classes\Common;
use App\Classes\Notify;
use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\StockAdjustmentOrder\IndexRequest;
use App\Http\Requests\Api\StockAdjustmentOrder\StoreRequest;
use App\Http\Requests\Api\StockAdjustmentOrder\UpdateRequest;
use App\Http\Requests\Api\StockAdjustmentOrder\DeleteRequest;
use App\Http\Requests\Api\StockAdjustmentOrder\ImportRequest;
use App\Models\ProductDetails;
use App\Models\StockAdjustment;
use App\Models\StockAdjustmentOrder;
use App\Models\StockHistory;
use App\Models\Brand;
use App\Models\Category;
use App\Models\Group;
use App\Models\Color;
use App\Models\Warehouse;
use Examyou\RestAPI\ApiResponse;
use Examyou\RestAPI\Exceptions\ApiException;
use Vinkla\Hashids\Facades\Hashids;
use Carbon\Carbon;
use App\Imports\StockAdjustmentOrderImport;
use Maatwebsite\Excel\Facades\Excel;
use DB;
use PDF;
use PHPExcel_Style_Fill;
use App\Exports\ExcelExport;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Bus;


class StockAdjustmentOrderController extends ApiBaseController
{

	protected $model = StockAdjustmentOrder::class;

	protected $indexRequest = IndexRequest::class;
	protected $storeRequest = StoreRequest::class;
	protected $updateRequest = UpdateRequest::class;
	protected $deleteRequest = DeleteRequest::class;

	public function modifyIndex($query)
	{
        $request = request();
        $warehouse = warehouse();

		// Get only current warehouse stocks
		// $query = $query->where('warehouse_id', $warehouse->id);

        // Dates Filters
        if ($request->has('dates') && $request->dates != "") {
            $dates = explode(',', $request->dates);
            $startDate = $dates[0];
            $endDate = $dates[1];

            $query = $query->whereRaw('date >= ?', [$startDate])
                ->whereRaw('date <= ?', [$endDate]);
        }

		return $query;
	}

    public function show(...$args)
    {
        $xid = last(func_get_args());
        $id = Common::getIdFromHash($xid);

        $stockAdjustmentOrder = StockAdjustmentOrder::find($id);
        $adjustmentType = $stockAdjustmentOrder->adjustment_type;
        $allProducs = [];
        $selectProductIds = [];
        $sn = 1;

        $allOrderIteams = StockAdjustment::with('product')->where('stock_adjustment_order_id', $id)->get();

        foreach ($allOrderIteams as $allOrderIteam) {

            $productDetails = ProductDetails::withoutGlobalScope('current_warehouse')
                ->where('warehouse_id', '=', $stockAdjustmentOrder->warehouse_id)
                ->where('product_id', '=', $allOrderIteam->product_id)
                ->first();

            $maxQuantity = $productDetails->current_stock;
            $unit = null;

            if ($adjustmentType == 'subtract') {
                $maxQuantity = $allOrderIteam->quantity + $maxQuantity;
            }

            $brand = $allOrderIteam->product->brand_id != null ? Brand::where('id', $allOrderIteam->product->brand_id)->first() : null;
            $category = $allOrderIteam->product->category_id != null ? Category::where('id', $allOrderIteam->product->category_id)->first() : null;
            $group = $allOrderIteam->product->group_id != null ? Group::where('id', $allOrderIteam->product->group_id)->first() : null;
            $color = $allOrderIteam->product->color_id != null ? Color::where('id', $allOrderIteam->product->color_id)->first() : null;

            $allProducs[] = [
                'sn'    =>  $sn,
                'xid'    =>  Common::getHashFromId($allOrderIteam->product_id),
                'item_id'    =>  $allOrderIteam->xid,
                'name'    =>  $allOrderIteam->product->name,
                'image'    =>  $allOrderIteam->product->image,
                'image_url'    =>  $allOrderIteam->product->image_url,
                'x_tax_id'    =>   null,
                'discount_rate'    =>  0,
                'total_discount'    => 0,
                'total_tax'    =>  0,
                'unit_price'    =>  0,
                'single_unit_price'    =>  0,
                'subtotal'    =>  0,
                'quantity'    =>  $allOrderIteam->quantity,
                'tax_rate'    =>  0,
                'tax_type'    =>  0,
                'x_unit_id'    =>  null,
                'unit'    =>  null,
                'stock_quantity' => $maxQuantity,
                'unit_short_name' => '',

                //* ADDENDUM
                'item_code' => $allOrderIteam->product->item_code,
                'brand' => $brand,
                'category' => $category,
                'group' => $group,
                'color' => $color,
                'purchase_price' => $productDetails->purchase_price,
                'retail_counter_price' => $productDetails->retail_counter_price,
                'special_counter_price' => $productDetails->special_counter_price,
                'discount_counter_price' => $productDetails->discount_counter_price,
                'retail_online_price' => $productDetails->retail_online_price,
                'special_online_price' => $productDetails->special_online_price,
                'discount_online_price' => $productDetails->discount_online_price,
                'discount_rate' => 0,
                'price_type' => '',
                'notes' => $allOrderIteam->notes,
            ];

            $selectProductIds[] = Common::getHashFromId($allOrderIteam->product_id);
            $sn++;
        }

        //* ADDENDUM
        $warehouse = Warehouse::select('id', 'name', 'phone')->find($stockAdjustmentOrder->warehouse_id);

        return ApiResponse::make('Data fetched', [
            'order' => $stockAdjustmentOrder,
            'items' => $allProducs,
            'ids' => $selectProductIds,
            'user' => null,

            //* ADDENDUM
            'warehouse' => $warehouse,
        ]);
    }

    public function store()
    {
		$this->validate();

        $request = request();
		$meta = $this->getMetaData(true);

        $batch = Bus::batch([new \App\Jobs\StockAdjustmentOrderJob("store", $request->all(), null, company()->id, user()->id)])
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


	// public function storing(StockAdjustmentOrder $stockAdjustmentOrder)
	// {
    //     $request = request();
	// 	$warehouse = warehouse();
    //     $company = company();

    //     if (!$request->has('invoice_number') || ($request->has('invoice_number') && $request->invoice_number == "")) {
    //         $stockAdjustmentOrder->invoice_number = '';
    //     }

    //     $stockAdjustmentOrder->adjustment_type = $request->adjustment_type;
    //     $stockAdjustmentOrder->date = Carbon::parse($request->date);
    //     $stockAdjustmentOrder->company_id = $company->id;
    //     $stockAdjustmentOrder->unique_id = Common::generateOrderUniqueId();
    //     $stockAdjustmentOrder->warehouse_id = $warehouse->id;
    //     $stockAdjustmentOrder->created_by = auth('api')->user()->id;
	// 	return $stockAdjustmentOrder;
	// }

	// public function stored(StockAdjustmentOrder $stockAdjustmentOrder)
	// {
    //     $request = request();
    //     $oldStockAdjustmentOrderId = "";

    //     if ($stockAdjustmentOrder->invoice_number == '') {
    //         $type = 'stock-adjustment-' . $stockAdjustmentOrder->adjustment_type;
    //         $stockAdjustmentOrder->invoice_number = Common::getTransactionNumber($type);
    //     }

    //     $stockAdjustmentOrder->save();

    //     $stockAdjustmentOrder = Common::storeAndUpdateStockAdjustmentOrder($stockAdjustmentOrder, $oldStockAdjustmentOrderId);

	// 	// Notifying to Warehouse
	// 	Notify::send('stock_adjustment_create', $stockAdjustmentOrder);
	// }

	public function updating(StockAdjustmentOrder $stockAdjustmentOrder)
	{

        $loggedUser = user();
        $warehouse = warehouse();

        // If logged in user is not admin
        // then cannot update order who are
        // of other warehouse
        // if (!$loggedUser->hasRole('admin') && $stockAdjustmentOrder->warehouse_id != $warehouse->id) {
        //     throw new ApiException("Don't have valid permission");
        // }

        $request = request();
        $stockAdjustmentOrder->adjustment_type = $request->adjustment_type;
        $stockAdjustmentOrder->date = Carbon::parse($request->date);
        $stockAdjustmentOrder->warehouse_id = $request->warehouse_id;

        return $stockAdjustmentOrder;
	}

    public function update(...$args)
    {
        // \DB::beginTransaction();

        // Geting id from hashids
        $xid = last(func_get_args());
        $convertedId = Hashids::decode($xid);
        $id = $convertedId[0];

        $this->validate();

        // // Get object for update
        // $this->query = call_user_func($this->model . "::query");

        // /** @var ApiModel $object */
        // $object = $this->query->find($id);

        // if (!$object) {
        //     throw new ResourceNotFoundException();
        // }

        // $oldUserId = $object->user_id;
        // $oldInvoiceNumber = $object->invoice_number;
        // $oldWarehouseId = $object->warehouse_id;

        $request = request();

        // $object->fill(request()->all());

        // if (method_exists($this, 'updating')) {
        //     $object = call_user_func([$this, 'updating'], $object);
        // }

        // $object->save();

        $meta = $this->getMetaData(true);

        // \DB::commit();

        // if (method_exists($this, 'updated')) {
        //     call_user_func([$this, 'updated'], $object);
        // }

        // // Update stock history's header
        // Common::updateStockHistoryHeader($oldInvoiceNumber, $object);

        // // If warehouse changed
        // // Recalculate product from old warehouse
        // if ($oldWarehouseId != $object->warehouse_id) {
        //     $orderItems = StockAdjustment::where('stock_adjustment_order_id', $object->id)->get();
        //     foreach ($orderItems as $orderItem) {
        //         Common::recalculateOrderStock($oldWarehouseId, $orderItem->product_id);
        //     }
        // }

        $batch = Bus::batch([new \App\Jobs\StockAdjustmentOrderJob("update", $request->all(), $id, company()->id, user()->id)])
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

        return ApiResponse::make("Resource is being updated", $response, $meta);
    }

	// public function updated(StockAdjustmentOrder $stockAdjustmentOrder)
	// {
	// 	$oldStockAdjustmentOrderId = $stockAdjustmentOrder->id;
    //     Common::storeAndUpdateStockAdjustmentOrder($stockAdjustmentOrder, $oldStockAdjustmentOrderId);

	// 	// Notifying to Warehouse
	// 	Notify::send('stock_adjustment_update', $stockAdjustmentOrder);
	// }

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
        $adjustmentType = $order->adjustment_type;
        $warehouseId = $order->warehouse_id;

        // If logged in user is not admin
        // then cannot delete order who are
        // of other warehouse
        // if (!$loggedUser->hasRole('admin') && $order->warehouse_id != $loggedUser->warehouse_id) {
        //     throw new ApiException("Don't have valid permission");
        // }

        foreach ($orderItems as $orderItem) {
            $productId =  $orderItem->product_id;

            $productDetails = ProductDetails::withoutGlobalScope('current_warehouse')
                ->where('warehouse_id', '=', $warehouseId)
                ->where('product_id', '=', $productId)
                ->first();


            $stockHistory = new StockHistory();
            $stockHistory->warehouse_id = $warehouseId;
            $stockHistory->product_id = $productId;
            $stockHistory->quantity = $orderItem->quantity;
            $stockHistory->old_quantity = $productDetails->current_stock;
            $stockHistory->order_type = 'stock_adjustment';
            $stockHistory->stock_type = $adjustmentType == 'add' ? 'in' : 'out';
            $stockHistory->action_type = "delete";
            $stockHistory->created_by = $loggedUser->xid;
            $stockHistory->save();
        }

        // Notifying to Warehouse
        Notify::send('stock_adjustment_delete', $object);

        $object->delete();

        foreach ($orderItems as $orderItem) {
            $productId = $orderItem->product_id;

            // Update warehouse stock for product
            // Common::recalculateOrderStock($warehouseId, $productId);
            $reversedAdjustmentType = $adjustmentType == 'add' ? 'subtract' : 'add';
            Common::asyncRecalculateOrderStock($warehouseId, $reversedAdjustmentType, $productId, $orderItem->quantity);
        }

        $meta = $this->getMetaData(true);

        \DB::commit();

        return ApiResponse::make("Resource deleted successfully", null, $meta);
    }

    public function import(ImportRequest $request)
    {
        if ($request->hasFile('file')) {
            Cache::forget('import-current-row');
            Excel::import(new StockAdjustmentOrderImport, request()->file('file'));
        }

        return ApiResponse::make('Imported Successfully', []);
    }

}
