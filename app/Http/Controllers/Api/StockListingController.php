<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\StockListing\StoreRequest;
use App\Classes\Common;
use App\Models\Product;
use App\Models\ProductDetails;
use App\Models\OrderItem;
use App\Models\StockAdjustment;
use App\Exports\StockListingExport;
use Examyou\RestAPI\ApiResponse;
use Maatwebsite\Excel\Facades\Excel;
use DB;

class StockListingController extends ApiBaseController
{

    public function stockListing()
    {
        $processingStartTime = microtime(true);

        $request = request();
        $warehouseId = $request->warehouse_id ? Common::getIdFromHash($request->warehouse_id) : null;
        $results = [];

        $query = Product::leftJoin('brands', 'products.brand_id', 'brands.id')
                ->leftJoin('categories', 'products.category_id', 'categories.id')
                ->join('units', 'products.unit_id', 'units.id')
                ->join('product_details', 'product_details.product_id', '=', 'products.id')
                ->join('warehouses', 'product_details.warehouse_id', '=', 'warehouses.id')
                ->whereNull('products.parent_id')
                ->where('products.product_type', 'single')
                ->where('product_details.current_stock', '>', 0);

        if ($warehouseId) {
            $query = $query->where('product_details.warehouse_id', $warehouseId);
        }
                
        $query = $query->select('products.id', 'products.item_code', 'products.item_id', 'products.name', 'product_details.purchase_price', 'product_details.current_stock', 'product_details.opening_stock',
                    'brands.name as brand_name', 'categories.name as category_name', 'warehouses.name as warehouse_name',
                    'units.short_name as unit_short_name')
                ->orderBy('products.name', 'asc')
                ->orderBy('product_details.product_id', 'asc');

        if ($request->has('searchTerm') && $request->searchTerm != null && $request->searchTerm != "" && $request->searchTerm != "undefined") {
            $searchTerm = $request->searchTerm;
            $query = $query->where(
                function ($query) use ($searchTerm) {
                    $query->where('products.name', 'LIKE', "%$searchTerm%")
                        ->orWhere('products.item_code', trim($searchTerm))
                        ->orWhere('products.parent_item_code', trim($searchTerm));
                }
            );
        }
        
        if ($request->has('brand_id') && $request->brand_id != null && $request->brand_id != "" && $request->brand_id != "undefined") {
            $query = $query->where('products.brand_id', Common::getIdFromHash($request->brand_id));
        }

        if ($request->has('category_id') && $request->category_id != null && $request->category_id != "" && $request->category_id != "undefined") {
            $query = $query->where('products.category_id', Common::getIdFromHash($request->category_id));
        }

        if ($request->has('group_id') && $request->group_id != null && $request->group_id != "" && $request->group_id != "undefined") {
            $query = $query->where('products.group_id', Common::getIdFromHash($request->group_id));
        }

        if ($request->has('color_id') && $request->color_id != null && $request->color_id != "" && $request->color_id != "undefined") {
            $query = $query->where('products.color_id', Common::getIdFromHash($request->color_id));
        }

       if ($request->has('stock_listing_date') && $request->stock_listing_date != null && $request->stock_listing_date != "" && $request->stock_listing_date != "undefined") {
            $parsedDate = explode(' ', $request->stock_listing_date);
            $products = $query->get();

            foreach ($products as $product) {
                $item = Common::getProductStockChanges($warehouseId, $product->id, null, $parsedDate[0]);
                if ($item['calculated_stock'] > 0) {
                    $product->current_stock = $item['calculated_stock'];
                    $results[] = $product;
                }
            }            
        } else {
            $results = $query->get()->toArray();
        }
                
        $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];

        return ApiResponse::make(null, $results, $meta);
    }
    
    public function placementListing()
    {
        $processingStartTime = microtime(true);

        $request = request();
        $warehouseId = $request->warehouse_id ? Common::getIdFromHash($request->warehouse_id) : null;
        $results = [];

        $query = Product::leftJoin('brands', 'products.brand_id', 'brands.id')
                ->leftJoin('categories', 'products.category_id', 'categories.id')
                ->join('units', 'products.unit_id', 'units.id')
                ->join('product_details', 'product_details.product_id', '=', 'products.id')
                ->join('barcode', 'barcode.item_id', '=', 'products.item_id')
                ->join('product_placements', 'product_placements.barcode_id', '=', 'barcode.id')
                ->join('warehouses', 'product_details.warehouse_id', '=', 'warehouses.id')
                ->whereNull('products.parent_id')
                ->where('products.product_type', 'single')
                ->where('product_details.current_stock', '>', 0);

        if ($warehouseId) {
            $query = $query->where('product_details.warehouse_id', $warehouseId);
        }
                
        $query = $query->select('products.id', 'products.item_code', 'products.item_id', 'products.name', 'product_details.purchase_price', 'product_details.current_stock', 'product_details.opening_stock',
                    'brands.name as brand_name', 'categories.name as category_name', 'warehouses.name as warehouse_name','product_placements.row',DB::Raw("sum(barcode.qty_bungkus) as qty_bungkus"))
                ->orderBy('products.name', 'asc')
                ->orderBy('product_details.product_id', 'asc');

        if ($request->has('searchTerm') && $request->searchTerm != null && $request->searchTerm != "" && $request->searchTerm != "undefined") {
            $searchTerm = $request->searchTerm;
            $query = $query->where(
                function ($query) use ($searchTerm) {
                    $query->where('products.name', 'LIKE', "%$searchTerm%")
                        ->orWhere('products.item_code', trim($searchTerm))
                        ->orWhere('products.parent_item_code', trim($searchTerm));
                }
            );
        }
        
        if ($request->has('brand_id') && $request->brand_id != null && $request->brand_id != "" && $request->brand_id != "undefined") {
            $query = $query->where('products.brand_id', Common::getIdFromHash($request->brand_id));
        }

        if ($request->has('category_id') && $request->category_id != null && $request->category_id != "" && $request->category_id != "undefined") {
            $query = $query->where('products.category_id', Common::getIdFromHash($request->category_id));
        }

        if ($request->has('group_id') && $request->group_id != null && $request->group_id != "" && $request->group_id != "undefined") {
            $query = $query->where('products.group_id', Common::getIdFromHash($request->group_id));
        }

       if ($request->has('stock_listing_date') && $request->stock_listing_date != null && $request->stock_listing_date != "" && $request->stock_listing_date != "undefined") {
            $parsedDate = explode(' ', $request->stock_listing_date);
            $products = $query->get();

            foreach ($products as $product) {
                $item = Common::getProductStockChanges($warehouseId, $product->id, null, $parsedDate[0]);
                if ($item['calculated_stock'] > 0) {
                    $product->current_stock = $item['calculated_stock'];
                    $results[] = $product;
                }
            }            
        } else {
            $results = $query->get()->toArray();
        }
                
        $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];

        return ApiResponse::make(null, $results, $meta);
    }

    public function recalculateStockListing(StoreRequest $request)
    {
        ini_set('max_execution_time', -1);
        ini_set('memory_limit', -1);
        $warehouseId = Common::getIdFromHash($request->warehouse_id);
        $query = ProductDetails::withoutGlobalScope('current_warehouse')
            ->where('warehouse_id', '=', $warehouseId)
            ->get();

        foreach ($query as $productDetails) {
            $warehouseId = $productDetails->warehouse_id;
            $productId = $productDetails->product_id;
            $currentStock = $productDetails->opening_stock ? $productDetails->opening_stock : 0;

            $orderItems = OrderItem::join('orders', 'orders.id', '=', 'order_items.order_id')
                ->where(
                    function ($query) use ($warehouseId) {
                        $query->where('orders.warehouse_id', '=', $warehouseId)
                            ->orWhere('orders.from_warehouse_id', '=', $warehouseId);
                    }
                )
                ->where('order_items.product_id', '=', $productId);

            $stockAdjustments = StockAdjustment::join('stock_adjustment_orders', 'stock_adjustment_orders.id', '=', 'stock_adjustments.stock_adjustment_order_id')
                ->where('stock_adjustment_orders.warehouse_id', '=', $warehouseId)
                ->where('stock_adjustments.product_id', '=', $productId);

            $orderItems = $orderItems->get();
            $stockAdjustments = $stockAdjustments->get();

            $productStockChanges = [];


            foreach ($orderItems as $orderItem) {
                $operation = 'add';
                if ($orderItem->order->order_type == 'purchase-returns' || $orderItem->order->order_type == 'sales' || $orderItem->order->from_warehouse_id == $warehouseId) {
                    $operation = 'subtract';
                }
            
                $productStockChanges[] = [
                    'company_id' => $orderItem->order->company_id,
                    'invoice_number' => $orderItem->order->invoice_number,
                    'order_type' => $orderItem->order->order_type,
                    'warehouse' => $orderItem->order->warehouse->name,
                    'from_warehouse' => $orderItem->order->fromWarehouse ? $orderItem->order->fromWarehouse->name : null,
                    'user' => $orderItem->order->user ? $orderItem->order->user->name : null,
                    'order_date' => $orderItem->order->order_date,
                    'operation' => $operation,
                    'quantity' => $orderItem->quantity,
                    'unit' => $productDetails->product->unit->short_name
                ];
            }

            foreach ($stockAdjustments as $stockAdjustment) {
                $operation = $stockAdjustment->adjustment_type;

                $productStockChanges[] = [
                    'company_id' => $stockAdjustment->stockAdjustmentOrder->company_id,
                    'invoice_number' => $stockAdjustment->stockAdjustmentOrder->invoice_number,
                    'order_type' => 'stock-adjustment',
                    'warehouse' => $stockAdjustment->stockAdjustmentOrder->warehouse->name,
                    'from_warehouse' => null,
                    'user' => null,
                    'order_date' => $stockAdjustment->stockAdjustmentOrder->date,
                    'operation' => $operation,
                    'quantity' => $stockAdjustment->quantity,
                    'unit' => $productDetails->product->unit->short_name
                ];
            }

            // Calculate balance
            foreach ($productStockChanges as $key => $item) {
                if ($item['operation'] == 'add') {
                    $currentStock = $currentStock + $item['quantity'];
                } else {
                    $currentStock = $currentStock - $item['quantity'];
                }

                $item['balance'] = $currentStock;
            }

            $productDetails->current_stock = $currentStock;

            if ($productDetails->stock_quantitiy_alert != null && $currentStock < $productDetails->stock_quantitiy_alert) {
                $productDetails->status = 'out_of_stock';
            } else {
                $productDetails->status = 'in_stock';
            }

            $productDetails->save();
        }

        return ApiResponse::make('Recalculated Successfully', [ 'warehouse_id' => $warehouseId]); 
    }

    public function export()
    {
        return Excel::download(new StockListingExport, 'stock-listing.xlsx');
    }

}


