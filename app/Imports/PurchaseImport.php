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
use DateTime;
use DateInterval;

class PurchaseImport implements ToArray, WithHeadingRow, WithMultipleSheets
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
			$warehouseType = 'warehouse';
			$orderType = 'purchases';
			$orderStatus = 'received';

			$orderSubtotal = 0;
			$totalQuantities = 0;
                        
                        // Warehouse Code default B15
			$warehouseCode = 'B15';
			$warehouse = Warehouse::where('code', $warehouseCode)->first();
                        
                        $productItems = [];
                        
                        foreach ($orderItems as $orderItem) {
                        
                            // User Code
                            $userCode = trim($orderItem['vendorid']);
                            if ($userCode == '') {
                                $errMessage = '[row ' . $currentRow . ']: VendorId Cannot Be Empty.';
                                Cache::put($this->cacheKey, $errMessage);
                                return;
                            } else {
                                $user = User::where('code', $userCode)->first();
                                if (!$user) {
                                        $errMessage = '[row ' . $currentRow . ']: VendorId  *' . $userCode . '* Not Found.';
                                        Cache::put($this->cacheKey, $errMessage);
                                        return;
                                }
                            }
                        
                            $date = $this->excelToDateTime(trim($orderItem['transactiondate']));
                            $refference = trim($orderItem['purchaseorderno']);
                            $invoiceNumber = trim($orderItem['receiveno']);
                            
                            $order = Order::where('invoice_number', $invoiceNumber)->count();
                            if($order == 0){
                                //new order
                                $newOrder = new Order();
                                $newOrder->company_id = $company->id;
                                $newOrder->unique_id = Common::generateOrderUniqueId();
                                $newOrder->order_type = $orderType;
                                $newOrder->order_date = $date;
                                $newOrder->warehouse_id = $warehouse->id;
                                $newOrder->user_id = $user->id;
                                $newOrder->tax_id = null;
                                $newOrder->tax_rate = 0;
                                $newOrder->discount = 0;
                                $newOrder->shipping = 0;
                                $newOrder->paid_amount = 0;
                                $newOrder->order_status = $orderStatus;
                                $newOrder->refference  = $refference ;
                                $newOrder->payment_status = 'unpaid';
                                $newOrder->total_items = 0;
                                $newOrder->total_quantity = 0;
                                $newOrder->subtotal = 0;
                                $newOrder->total = 0;
                                $newOrder->due_amount = 0;
                                $newOrder->invoice_number = $invoiceNumber;
                                $newOrder->staff_user_id = $this->userId;    
                                $newOrder->save();
                                
                                $item_id = trim($orderItem['itemid']);
                                $qty = (int) trim($orderItem['receiveqty']);
                                $product = Product::where('item_id', $item_id)->first();
                                if (!$product) {
                                        $errMessage = '[row ' .  $currentRow . ']: itemId  *' . $item_id . '* Not Found.';
                                        Cache::put($this->cacheKey, $errMessage);
                                        //file_put_contents(storage_path('logs') . '/purchases.log', "[" . date('Y-m-d H:i:s') . "]cccc : \n" . print_r($itemCode,1) . "\n\n", FILE_APPEND);
                                        return;
                                }
                                else{
                                    $productDetails = ProductDetails::withoutGlobalScope('current_warehouse')
					->where('warehouse_id', '=', $warehouse->id)
					->where('product_id', '=', $product->id)
					->first();
                                    
                                    $currentStock = $productDetails->current_stock;
                                    $itemPriceTypeCode = 'purchase_price';

                                    //purchase_price
                                    $unitPrice = 0;
                                    $subtotal = 0;
                                    
                                    $unit = $product->unit;
                                    $productItems[$invoiceNumber] = [];
                                     
                                    $productItems[$invoiceNumber][] = (object) [
					'xid'    =>  Common::getHashFromId($product->id),
					'item_id'    =>  '',
					'name'    =>  $product->name,
					'image'    =>  $product->image,
					'image_url'    =>  $product->image_url,
					'x_tax_id'    =>   Common::getHashFromId($productDetails->tax_id),
					'discount_rate'    =>  0,
					'total_discount'    =>  0,
					'total_tax'    =>  0,
					'unit_price'    =>  $unitPrice,
					'single_unit_price'    =>  $unitPrice,
					'subtotal'    =>  $subtotal,
					'quantity'    =>  $qty,
					'shelf'    =>  '',
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
					'price_type' => $itemPriceTypeCode,
                                    ];

                                }
                                
                                
                                
                            }
                            else{
                                //invoice order already create
                                $item_id = trim($orderItem['itemid']);
                                $qty = (int) trim($orderItem['receiveqty']);
                                $product = Product::where('item_id', $item_id)->first();
                                if (!$product) {
                                        $errMessage = '[row ' .  $currentRow . ']: itemId  *' . $item_id . '* Not Found.';
                                        Cache::put($this->cacheKey, $errMessage);
                                        //file_put_contents(storage_path('logs') . '/purchases.log', "[" . date('Y-m-d H:i:s') . "]cccc : \n" . print_r($itemCode,1) . "\n\n", FILE_APPEND);
                                        return;
                                }
                                else{
                                    $productDetails = ProductDetails::withoutGlobalScope('current_warehouse')
					->where('warehouse_id', '=', $warehouse->id)
					->where('product_id', '=', $product->id)
					->first();
                                    
                                    $currentStock = $productDetails->current_stock;
                                    $itemPriceTypeCode = 'purchase_price';

                                    //purchase_price
                                    $unitPrice = 0;
                                    $subtotal = 0;
                                    
                                    $unit = $product->unit;
                                    $productItems[$invoiceNumber][] = (object) [
					'xid'    =>  Common::getHashFromId($product->id),
					'item_id'    =>  '',
					'name'    =>  $product->name,
					'image'    =>  $product->image,
					'image_url'    =>  $product->image_url,
					'x_tax_id'    =>   Common::getHashFromId($productDetails->tax_id),
					'discount_rate'    =>  0,
					'total_discount'    =>  0,
					'total_tax'    =>  0,
					'unit_price'    =>  $unitPrice,
					'single_unit_price'    =>  $unitPrice,
					'subtotal'    =>  $subtotal,
					'quantity'    =>  $qty,
					'shelf'    =>  '',
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
					'price_type' => $itemPriceTypeCode,
                                    ];

                                }
                                
                            }
                            
                        
                            
                            
                            $currentRow++;
                        }
                        
                        
                        foreach($productItems as $key => $productItem){
                            $order = Order::where('invoice_number',$key)->first();
                            $order = Common::storeAndUpdateOrder($order, "", $productItem);

                            // Updating Warehouse History
                            Common::updateWarehouseHistory('order', $order, "add_edit");

                            // Notifying to Warehouse
                            Notify::send(str_replace('-', '_', $orderType)  . '_create', $order);
                        }
                        
			// Forget cache
			Cache::forget($this->cacheKey);
		});
	}
        

        function excelToDateTime($serialDate)
        {
            // Excel base date (1899-12-30)
            $baseDate = new DateTime('1899-12-30');

            // Add the serial date as days
            $interval = new DateInterval("P" . floor($serialDate) . "D");
            $baseDate->add($interval);

            // Convert fractional day to seconds (force integer)
            $seconds = (int) round(($serialDate - floor($serialDate)) * 86400);

            // Modify date with seconds
            $baseDate->modify("+{$seconds} seconds");

            return $baseDate->format('Y-m-d H:i:s');
        }

}
