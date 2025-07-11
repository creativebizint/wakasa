<?php

namespace App\Imports;

use App\Classes\Common;
use App\Models\Customer;
use App\Models\FrontWebsiteSettings;
use App\Models\Product;
use App\Models\ProductDetails;
use App\Models\User;
use App\Models\UserDetails;
use App\Models\Warehouse;
use App\Models\Store;

use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithMultipleSheets;
use Maatwebsite\Excel\Concerns\ToArray;
use Illuminate\Support\Str;

class WarehouseImport implements ToArray, WithHeadingRow, WithMultipleSheets
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

	public function array(array $warehouses)
	{
		DB::transaction(function () use ($warehouses) {

			$currentRow = 2;
			$errMessage = "";

			foreach ($warehouses as $warehouse) {

				if (
					!array_key_exists('code', $warehouse) || !array_key_exists('name', $warehouse) ||
					!array_key_exists('phone', $warehouse) || !array_key_exists('email', $warehouse) || !array_key_exists('address', $warehouse) 
					
				) {
					$errMessage = '[row ' . $currentRow . ']: Field missing from header.';
					Cache::put($this->cacheKey, $errMessage);
					return;
				}

				$warehouseCode = trim($warehouse['code']);
				if ($warehouseCode == '') {
                    $errMessage = '[row ' . $currentRow . ']: code Cannot Be Empty.';
					Cache::put($this->cacheKey, $errMessage);
					return;
                } else {
					$warehouseCodeCount = Warehouse::where('code', $warehouseCode)->count();
					if ($warehouseCodeCount > 0) {
						$errMessage = '[row ' . $currentRow . ']: code *' . $warehouseCode . '* Already Exists.';
						Cache::put($this->cacheKey, $errMessage);
						return;
					}
				}

				$warehouseName = trim($warehouse['name']);
                if ($warehouseName == '') {
                    $errMessage = '[row ' . $currentRow . ']: name Cannot Be Empty.';
					Cache::put($this->cacheKey, $errMessage);
					return;
                }

				$warehousePhone = trim($warehouse['phone']);
				$warehouseEmail = trim($warehouse['email']);
				$warehouseAddress = trim($warehouse['address']);
				$warehouseIsOnlineStoreEnabled = 0;
				
				
				$newWarehouse = new Warehouse();
				$newWarehouse->code = $warehouseCode;
				$newWarehouse->name = $warehouseName;
				$newWarehouse->slug = Str::slug($warehouseName, '-');
				$newWarehouse->phone = $warehousePhone;
				$newWarehouse->email = $warehouseEmail;
				$newWarehouse->address = $warehouseAddress;
				$newWarehouse->show_email_on_invoice = 1;
				$newWarehouse->show_phone_on_invoice = 1;
				$newWarehouse->customers_visibility = 'all';
				$newWarehouse->suppliers_visibility = 'all';
				$newWarehouse->products_visibility = 'all';
				$newWarehouse->default_pos_order_status = 'delivered';
				$newWarehouse->show_mrp_on_invoice = '1';
				$newWarehouse->show_discount_tax_on_invoice = '1';
				$newWarehouse->barcode_type = 'barcode';
				$newWarehouse->company_id = company()->id;
				$newWarehouse->online_store_enabled = $warehouseIsOnlineStoreEnabled;
                                $newWarehouse->save();

				// Fix - Issue fixed for variable type product
				$allProducts = Product::select('id')
					->where('product_type', 'single')
					->get();
	
				foreach ($allProducts as $allProduct) {
					// Getting product details for company default warehouse
					$defaultWarehouseProductDetails = ProductDetails::withoutGlobalScope('current_warehouse')
						->where('warehouse_id', '=', company()->warehouse->id)
						->where('product_id', '=', $allProduct->id)
						->first();
		
					// Inserting all products details for this warhouse
					$productDetails = new ProductDetails();
					$productDetails->warehouse_id = $newWarehouse->id;
					$productDetails->product_id = $allProduct->id;
					$productDetails->tax_id = $defaultWarehouseProductDetails->tax_id;
					$productDetails->mrp = $defaultWarehouseProductDetails->mrp;
					$productDetails->purchase_price = $defaultWarehouseProductDetails->purchase_price;
					$productDetails->sales_price = $defaultWarehouseProductDetails->sales_price;
					$productDetails->purchase_tax_type = $defaultWarehouseProductDetails->purchase_tax_type;
					$productDetails->sales_tax_type = $defaultWarehouseProductDetails->sales_tax_type;
					$productDetails->stock_quantitiy_alert = $defaultWarehouseProductDetails->stock_quantitiy_alert;
					$productDetails->wholesale_price = $defaultWarehouseProductDetails->wholesale_price;
					$productDetails->wholesale_quantity = $defaultWarehouseProductDetails->wholesale_quantity;
					$productDetails->save();
		
					// Common::updateProductCustomFields($allProduct, $productDetails->warehouse_id);
					Common::recalculateOrderStock($productDetails->warehouse_id, $allProduct->id);
				}
		
				// Creating user Details for each customer and supplier
				// For this created warehouse
				$allCustomerSuppliers = Customer::withoutGlobalScope('type')
					->where('user_type', 'suppliers')
					->orWhere('user_type', 'customers')
					->get();

				foreach ($allCustomerSuppliers as $allCustomerSupplier) {
					$userDetails = new UserDetails();
					$userDetails->warehouse_id = $newWarehouse->id;
					$userDetails->user_id = $allCustomerSupplier->id;
					$userDetails->credit_period = 30;
					$userDetails->save();
				}

				$currentRow++;
			}

			// Forget cache
			Cache::forget($this->cacheKey);
		});
	}
}
