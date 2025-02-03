<?php

namespace App\Imports;

use App\Models\StockAdjustmentOrder;
use App\Models\StockAdjustment;
use App\Models\Product;
use App\Models\ProductDetails;
use App\Models\Warehouse;
use App\Models\User;
use App\Models\Unit;

use App\Classes\Common;
use App\Classes\Notify;

use Carbon\Carbon;

use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithMultipleSheets;
use Maatwebsite\Excel\Concerns\ToArray;

class StockAdjustmentOrderImport implements ToArray, WithHeadingRow, WithMultipleSheets
{
	protected $cacheKey;
	protected $userId;

	public function __construct($cacheKey, $userId)
    {
		$this->cacheKey = $cacheKey;
        $this->userId = $userId;
    }

	public function sheets(): array
    {
        return [
            0 => $this,
        ];
    }

	public function array(array $stockAdjustments)
	{
		DB::transaction(function () use ($stockAdjustments) {
			$currentRow = 2;
			$errMessage = "";

			$company = company();
			$totalQuantities = 0;

			if (
				!array_key_exists('invoice_number', $stockAdjustments[0]) || !array_key_exists('warehouse_code', $stockAdjustments[0]) || !array_key_exists('adjustment_type_code', $stockAdjustments[0]) ||
				!array_key_exists('adjustment_date', $stockAdjustments[0]) || !array_key_exists('adjustment_notes', $stockAdjustments[0])
			) {
                            
                            file_put_contents(storage_path('logs') . '/adjustment.log', "[" . date('Y-m-d H:i:s') . "]name : aaa \n" . "\n\n", FILE_APPEND);
				$errMessage = '[row ' . $currentRow . ']: Field missing from header.';
				Cache::put($this->cacheKey, $errMessage);
				return;
			}

			// Warehouse Code
			$warehouse = null;
			$warehouseCode = trim($stockAdjustments[0]['warehouse_code']);
			if ($warehouseCode == '') {
                            file_put_contents(storage_path('logs') . '/adjustment.log', "[" . date('Y-m-d H:i:s') . "]1 : aaa \n" . "\n\n", FILE_APPEND);
				$errMessage = '[row ' . $currentRow . ']: warehouse_code Cannot Be Empty.';
				Cache::put($this->cacheKey, $errMessage);
				return;
			} else {
				$warehouse = Warehouse::where('code', $warehouseCode)->first();
				if (!$warehouse) {
                                    file_put_contents(storage_path('logs') . '/adjustment.log', "[" . date('Y-m-d H:i:s') . "]2 : \n" . $warehouseCode. "\n\n", FILE_APPEND);
					$errMessage = '[row ' . $currentRow . ']: warehouse_code *' . $warehouseCode . '* Not Found.';
					Cache::put($this->cacheKey, $errMessage);
					return;
				}
			}

			$adjustmentType = trim($stockAdjustments[0]['adjustment_type_code']);
			$invoiceNumber = trim($stockAdjustments[0]['invoice_number']);
			$adjustmentDate = trim($stockAdjustments[0]['adjustment_date']) ? Carbon::createFromFormat('Y-m-d H:i:s', trim($stockAdjustments[0]['adjustment_date']), $company->timezone)->setTimezone('UTC') : Carbon::now();
			$notes = trim($stockAdjustments[0]['adjustment_notes']);

			$newStockAdjustmentOrder = new StockAdjustmentOrder();
			$newStockAdjustmentOrder->adjustment_type = $adjustmentType;
			$newStockAdjustmentOrder->date = $adjustmentDate;
			$newStockAdjustmentOrder->company_id = $company->id;
			$newStockAdjustmentOrder->unique_id = Common::generateOrderUniqueId();
			$newStockAdjustmentOrder->warehouse_id = $warehouse->id;
			$newStockAdjustmentOrder->notes = $notes;
			$newStockAdjustmentOrder->total_items = count($stockAdjustments);
			$newStockAdjustmentOrder->total_quantity = 0;
			$newStockAdjustmentOrder->invoice_number = $invoiceNumber;
			$newStockAdjustmentOrder->save();

			$productItems = [];

            foreach ($stockAdjustments as $stockAdjustment) {

				if (
					!array_key_exists('item_id', $stockAdjustment) || !array_key_exists('item_notes', $stockAdjustment) || !array_key_exists('item_quantity', $stockAdjustment)
				) {
                                    file_put_contents(storage_path('logs') . '/adjustment.log', "[" . date('Y-m-d H:i:s') . "] 3 \n" . "\n\n", FILE_APPEND);
					$errMessage = '[row ' . $currentRow . ']: Field missing from header.';
					Cache::put($this->cacheKey, $errMessage);
					return;
				}

				$product = null;

				// Item Code
				$item_id = trim($stockAdjustment['item_id']);
				if ($item_id == '') {
                                    file_put_contents(storage_path('logs') . '/adjustment.log', "[" . date('Y-m-d H:i:s') . "]4 \n" . "\n\n", FILE_APPEND);
					$errMessage = '[row ' . $currentRow . ']: item_id Cannot Be Empty.';
					Cache::put($this->cacheKey, $errMessage);
					return;
				} else {
					$product = Product::where('item_id', $item_id)->first();
					if (!$product) {
                                            file_put_contents(storage_path('logs') . '/adjustment.log', "[" . date('Y-m-d H:i:s') . "]5 \n" . "\n\n", FILE_APPEND);
						$errMessage = '[row ' . $currentRow . ']: item_id *' . $item_id . '* Not Found.';
						Cache::put($this->cacheKey, $errMessage);
						return;
					}
				}

				$productDetails = ProductDetails::withoutGlobalScope('current_warehouse')
								->where('warehouse_id', '=', $warehouse->id)
								->where('product_id', '=', $product->id)
								->first();
				$currentStock = $productDetails ? $productDetails->current_stock : 0;

				// Item Quantity
				$itemQuantity = (int) trim($stockAdjustment['item_quantity']);
				if (!$itemQuantity) {
                                    file_put_contents(storage_path('logs') . '/adjustment.log', "[" . date('Y-m-d H:i:s') . "] 7 \n" . "\n\n", FILE_APPEND);
					$errMessage = '[row ' . $currentRow . ']: item_quantity Cannot Be Empty Or 0.';
					Cache::put($this->cacheKey, $errMessage);
					return;
				} else if ($itemQuantity > $currentStock && $adjustmentType == "subtract") {
                                    file_put_contents(storage_path('logs') . '/adjustment.log', "[" . date('Y-m-d H:i:s') . "] 8 \n" . "\n\n", FILE_APPEND);
					$errMessage = '[row ' . $currentRow . ']: item_quantity Exceed Stock.';
					Cache::put($this->cacheKey, $errMessage);
					return;
				}

				$itemNotes = trim($stockAdjustment['item_notes']);
				$maxQuantity = $productDetails->current_stock;

				if ($adjustmentType == 'subtract') {
					$maxQuantity = $itemQuantity + $maxQuantity;
				}

				$productItems[] = (object) [
					'xid'    =>  Common::getHashFromId($product->id),
					'item_id'    =>  '',
					'name'    =>  $product->name,
					'image'    =>  $product->image,
					'image_url'    =>  $product->image_url,
					'x_tax_id'    =>  null,
					'discount_rate'    =>  0,
					'total_discount'    => 0,
					'total_tax'    =>  0,
					'unit_price'    =>  0,
					'single_unit_price'    =>  0,
					'subtotal'    =>  0,
					'quantity'    =>  $itemQuantity,
					'tax_rate'    =>  0,
					'tax_type'    =>  0,
					'x_unit_id'    =>  null,
					'unit'    =>  null,
					'stock_quantity' => $maxQuantity,
					'unit_short_name' => '',

					//* ADDENDUM
					'item_code' => $product->item_code,
					'brand' => $product->brand,
					'category' => $product->category,
					'group' => $product->group,
					'color' => $product->color,
					'purchase_price' => $productDetails->purchase_price,
					'retail_counter_price' => $productDetails->retail_counter_price,
					'special_counter_price' => $productDetails->special_counter_price,
					'discount_counter_price' => $productDetails->discount_counter_price,
					'retail_online_price' => $productDetails->retail_online_price,
					'special_online_price' => $productDetails->special_online_price,
					'discount_online_price' => $productDetails->discount_online_price,
					'discount_rate' => 0,
					'price_type' => '',
					'notes' => $itemNotes,
				];

				$totalQuantities += $itemQuantity;

                $currentRow++;
            }

			if (!$newStockAdjustmentOrder->invoice_number || $newStockAdjustmentOrder->invoice_number == "") {
				$type = 'stock-adjustment-' . $newStockAdjustmentOrder->adjustment_type;
				$newStockAdjustmentOrder->invoice_number = Common::getTransactionNumber($type);
			}

			$newStockAdjustmentOrder->total_quantity = $totalQuantities;
			$newStockAdjustmentOrder->created_by = $this->userId;
			$newStockAdjustmentOrder->save();

			// Update Stock
			$newStockAdjustmentOrder = Common::storeAndUpdateStockAdjustmentOrder($newStockAdjustmentOrder, "", $productItems);
			
			// Notifying to Warehouse
			Notify::send('stock_adjustment_create', $newStockAdjustmentOrder);

			// Forget cache
			Cache::forget($this->cacheKey);
		});
	}
}
