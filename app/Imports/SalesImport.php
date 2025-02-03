<?php

namespace App\Imports;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use App\Models\ProductDetails;
use App\Models\Warehouse;
use App\Models\User;
use App\Models\Unit;

use App\Classes\Common;
use App\Classes\Notify;

use Carbon\Carbon;

use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithMultipleSheets;
use Maatwebsite\Excel\Concerns\ToArray;

class SalesImport implements ToArray, WithHeadingRow, WithMultipleSheets
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

	public function array(array $orderItems)
	{
        DB::transaction(function () use ($orderItems) {
            $currentRow = 2;
			$errMessage = "";

			$company = company();
			$userType = 'customer';
			$warehouseType = 'from_warehouse';
			$orderType = 'sales';
			$orderStatus = 'delivered';

			$orderSubtotal = 0;
			$totalQuantities = 0;

			if (
				!array_key_exists('invoice_number', $orderItems[0]) || !array_key_exists($userType . '_code', $orderItems[0]) || !array_key_exists($warehouseType . '_code', $orderItems[0]) ||
				!array_key_exists('order_date', $orderItems[0]) || !array_key_exists('order_notes', $orderItems[0])
			) {
                                //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]test 2: \n"  .  "\n\n", FILE_APPEND);
                $errMessage = '[row ' . $currentRow . ']: Field missing from header.';
				Cache::put($this->cacheKey, $errMessage);
				return;
			}

			// User Code
			$userCode = trim($orderItems[0][$userType . '_code']);
			if ($userCode == '') {
				$errMessage = '[row ' . $currentRow . ']: ' . $userType . '_code Cannot Be Empty.';
                                //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]test 4: \n"  .  "\n\n", FILE_APPEND);
				Cache::put($this->cacheKey, $errMessage);
				return;
			} else {
				$user = User::where('code', $userCode)->first();
				if (!$user) {
                                        //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]test 3: \n"  .  "\n\n", FILE_APPEND);
					$errMessage = '[row ' . $currentRow . ']: ' . $userType . '_code *' . $userCode . '* Not Found.';
					Cache::put($this->cacheKey, $errMessage);
					return;
				}
			}

			// Warehouse Code
			$warehouse = null;
			$warehouseCode = trim($orderItems[0][$warehouseType . '_code']);
			if ($warehouseCode == '') {
                                //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]test 4: \n"  .  "\n\n", FILE_APPEND);
				$errMessage = '[row ' . $currentRow . ']: ' . $warehouseType . '_code Cannot Be Empty.';
				Cache::put($this->cacheKey, $errMessage);
				return;
			} else {
				$warehouse = Warehouse::where('code', $warehouseCode)->first();
				if (!$warehouse) {
                                        //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]test 5: \n"  .  "\n\n", FILE_APPEND);
					$errMessage = '[row ' . $currentRow . ']: ' . $warehouseType . '_code *' . $warehouseCode . '* Not Found.';
					Cache::put($this->cacheKey, $errMessage);
					return;
				}
			}


			$invoiceNumber = trim($orderItems[0]['invoice_number']);
			$orderDate = trim($orderItems[0]['order_date']) ? Carbon::createFromFormat('Y-m-d H:i:s', trim($orderItems[0]['order_date']), $company->timezone)->setTimezone('UTC') : Carbon::now();
			$notes = trim($orderItems[0]['order_notes']);

			$newOrder = new Order();
			$newOrder->company_id = $company->id;
			$newOrder->unique_id = Common::generateOrderUniqueId();
			$newOrder->order_type = $orderType;
			$newOrder->order_date = $orderDate;
			$newOrder->warehouse_id = $warehouse->id;
			$newOrder->user_id = $user->id;
			$newOrder->tax_id = null;
			$newOrder->tax_rate = 0;
			$newOrder->discount = 0;
			$newOrder->shipping = 0;
			$newOrder->paid_amount = 0;
			$newOrder->order_status = $orderStatus;
			$newOrder->notes = $notes;
			$newOrder->payment_status = 'unpaid';
			$newOrder->total_items = count($orderItems);
			$newOrder->total_quantity = 0;
			$newOrder->subtotal = 0;
			$newOrder->total = 0;
			$newOrder->due_amount = 0;
			$newOrder->invoice_number = $invoiceNumber;
			$newOrder->save();
                        //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]order : \n" . print_r($newOrder,1) . "\n\n", FILE_APPEND);
			$productItems = [];
			$processedItemCodes = [];

            foreach ($orderItems as $orderItem) {

				if (
					!array_key_exists('item_code', $orderItem) || !array_key_exists('item_quantity', $orderItem) ||
					!array_key_exists('item_id', $orderItem)
				) {
                    $errMessage = '[row ' . $currentRow . ']: Field missing from header.';
					Cache::put($this->cacheKey, $errMessage);
					$newOrder->delete();
					return;
				}

				$product = null;

				// Item Code
				$itemCode = trim($orderItem['item_code']);
				if ($itemCode == '') {
                                        //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]1 : \n"  . "\n\n", FILE_APPEND);
					$errMessage = '[row ' . $currentRow . ']: item_code Cannot Be Empty.';
					Cache::put($this->cacheKey, $errMessage);
					$newOrder->delete();
					return;
				} 
				// else if (Str::contains($itemCode, $processedItemCodes)) {
				// 	$errMessage = '[row ' . $currentRow . ']: Duplicate item_code *' . $itemCode .  '*.';
				// 	Cache::put($this->cacheKey, $errMessage);
				// 	$newOrder->delete();
				// 	return;
				// } 
				else {
					$product = Product::where('item_code', $itemCode)->first();
					if (!$product) {
                                                //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]2 : \n"  . "\n\n", FILE_APPEND);
						$errMessage = '[row ' . $currentRow . ']: item_code *' . $itemCode . '* Not Found.';
						Cache::put($this->cacheKey, $errMessage);
						$newOrder->delete();
						return;
					}
				}

				$productDetails = ProductDetails::withoutGlobalScope('current_warehouse')
								->where('warehouse_id', '=', $warehouse->id)
								->where('product_id', '=', $product->id)
								->first();
				$currentStock = $productDetails ? $productDetails->current_stock : 0;

				// Item Quantity
				$itemQuantity = (int) trim($orderItem['item_quantity']);
				if (!$itemQuantity) {
                                        //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]3 : \n"  . "\n\n", FILE_APPEND);
					$errMessage = '[row ' . $currentRow . ']: item_quantity Cannot Be Empty Or 0.';
					Cache::put($this->cacheKey, $errMessage);
					$newOrder->delete();
					return;
				} else if ($itemQuantity > $currentStock) {
                                        //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]4 : \n"  . "\n\n", FILE_APPEND);
					$errMessage = '[row ' . $currentRow . ']: item_quantity Exceed Stock.';
					Cache::put($this->cacheKey, $errMessage);
					$newOrder->delete();
					return;
				}

				//sales_price
                                $unitPrice = isset($orderItem['sales_price']) && $orderItem['sales_price'] != '' ? trim($orderItem['sales_price']) : $productDetails->sales_price;
				$subtotal = $unitPrice * $itemQuantity;

				
				$unit = $product->unit;

				$productItems[] = (object) [
					'xid'    =>  Common::getHashFromId($product->id),
					'item_id'    =>  '',
					'name'    =>  $product->name,
					'image'    =>  $product->image,
					'image_url'    =>  $product->image_url,
					'x_tax_id'    =>   Common::getHashFromId($productDetails->tax_id),
					'total_tax'    =>  0,
					'discount_rate'    =>  0,
					'total_discount'    =>  0,
					'unit_price'    =>  $unitPrice,
					'single_unit_price'    =>  $unitPrice,
					'subtotal'    =>  $subtotal,
					'quantity'    =>  $itemQuantity,
					'tax_rate'    =>  0,
					'tax_type'    =>  $productDetails->purchase_tax_type,
					'x_unit_id'    =>  Common::getHashFromId($unit->id),
					'unit'    =>  $unit,
					'stock_quantity' =>  $currentStock,
					'unit_short_name' => $unit && $unit->short_name ? $unit->short_name : '',

					//* ADDENDUM
					'item_code' => $product->item_code,
					'brand' => $product->brand,
					'category' => $product->category,
					'group' => $product->group,
					'color' => $product->color,
					
				];

				$orderSubtotal += $subtotal;
				$totalQuantities += $itemQuantity;
				
               $currentRow++;

			   $processedItemCodes[] = $itemCode;
            }

			$newOrder->total_quantity = $totalQuantities;
			$newOrder->subtotal = $orderSubtotal;
			$newOrder->total = $orderSubtotal;
			$newOrder->due_amount = $orderSubtotal;
			$newOrder->staff_user_id = $this->userId;

			if (!$newOrder->invoice_number || $newOrder->invoice_number == "") {
				$newOrder->invoice_number = Common::getTransactionNumber($orderType);
			}
			
			$newOrder->save();

			// Update Stock
			$newOrder = Common::storeAndUpdateOrder($newOrder, "", $productItems);
                        //file_put_contents(storage_path('logs') . '/sales.log', "[" . date('Y-m-d H:i:s') . "]5 : \n"  . print_r($newOrder,1). "\n\n", FILE_APPEND);
			// Updating Warehouse History
			Common::updateWarehouseHistory('order', $newOrder, "add_edit");

			// Notifying to Warehouse
			Notify::send(str_replace('-', '_', $orderType)  . '_create', $newOrder);

			// Forget cache
			Cache::forget($this->cacheKey);
		});
	}
}
