<?php

namespace App\Imports;

use App\Classes\Common;
use App\Models\Brand;
use App\Models\Category;
use App\Models\Product;
use App\Models\ProductDetails;
use App\Models\Tax;
use App\Models\Unit;
use App\Models\Warehouse;
use App\Models\Supplier;
use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\ToArray;
use Illuminate\Support\Str;
use Examyou\RestAPI\ApiResponse;

class ProductImport implements ToArray, WithHeadingRow
{
    public function array(array $products)
    {
        DB::transaction(function () use ($products) {
            $user = user();

            foreach ($products as $product) {

                if (
                    !array_key_exists('name', $product) || !array_key_exists('barcode_symbology', $product) || !array_key_exists('part_code', $product) || !array_key_exists('brand_code', $product) ||
                    !array_key_exists('category_code', $product) || !array_key_exists('item_code', $product) || !array_key_exists('item_id', $product) || !array_key_exists('description', $product)                       
                ) {
                    throw new ApiException('Field missing from header.');
                }

                $item_code = trim($product['item_code']);
                $item_id = trim($product['item_id']);

                if ($item_id !='') {
                    $productCount = Product::where('item_id',$item_id)
                                    ->count();
                    if ($productCount > 0) {
                        throw new ApiException('Product ' . $item_id . ' Already Exists');
                    }

                    // Category
                    $category_code = trim($product['category_code']);
                    $category = Category::where('category_id', $category_code)->first();
                    if (!$category) {
                        throw new ApiException('Category Not Found... ' . $category_code);
                    }
                    $category_id = $category->id;
                    
                    // Brand
                    $brand_code = trim($product['brand_code']);
                    $brand = Brand::where('code', $brand_code)->first();
                    if (!$brand) {
                        throw new ApiException('Brand Not Found... ' . $brand_code);
                    }
                    $brand_id = $brand->id;
                    
                    $variant_id = null;
                    $variant = isset($product['variant']) ? trim($product['variant']) : '';
                    if($variant != ''){
                        $variant_ = Supplier::where('code', $variant)->first();
                        $variant_id = $variant_->id;
                    }
                    
                    
                    $supplier_id = null;
                    $supplier_code = isset($product['supplier_code']) ? trim($product['supplier_code']) : '';
                    if($supplier_code != ''){
                        $supplier = Supplier::where('code', $supplier_code)->first();
                        if (!$supplier) {
                            throw new ApiException('Supplier Not Found... ' . $supplier_code);
                        }
                        $supplier_id = isset($supplier->id) ? $supplier->id : null;
                    }
                    
                    
                    // Unit
                    $unitName = trim($product['unit']);
                    $unit = Unit::where('name', $unitName)->first();
                    if (!$unit) {
                        throw new ApiException('Unit Not Found... ' . $unitName);
                    }
                    $unit_id = $unit->id;
                    
                    $barcodeSymbology = trim($product['barcode_symbology']);
                    if ($barcodeSymbology == "" || !in_array($barcodeSymbology, ['CODE128', 'CODE39'])) {
                        throw new ApiException('Barcode symoblogy must be CODE128 or CODE39');
                    }

                   
                    // Product Details
                    $openingStockDate = isset($product['opening_stock_date']) ? trim($product['opening_stock_date']) : null;
                    
                    $stockQuantityAlert = trim($product['stock_quantitiy_alert']);
                    $openingStock = trim($product['opening_stock']);
                    $wholesaleQuantity = null;
                    $wholesalePrice = null;
                    $allWarehouses = Warehouse::select('id')->get();

                    if (array_key_exists('warehouse', $product)) {
                        $warehouse = Warehouse::where('name', $product['warehouse'])->first();
                        $currentWarehouse = warehouse();

                        $createdWarehouseId = $warehouse && $warehouse->id ? $warehouse->id : $currentWarehouse->id;
                    } else {
                        $warehouse = warehouse();
                        $createdWarehouseId = $warehouse->id;
                    }

                    if(isset($product['uom_sale_in'])){
                        $unit_uom_sale_in = Unit::where('name',trim($product['uom_sale_in']))->first();
                        $uom_sale_in = $unit_uom_sale_in->id;
                    }
                    else{
                        $uom_sale_in = 1;
                    }
                    
                    if(isset($product['uom_buy_in'])){
                        $unit_uom_buy_in = Unit::where('name',trim($product['uom_buy_in']))->first();
                        $uom_buy_in = $unit_uom_buy_in->id;
                    }
                    else{
                        $uom_buy_in = 1;
                    }
                    
                    $newProduct = new Product();
                    $newProduct->name = trim($product['name']);
                    $newProduct->warehouse_id = $createdWarehouseId;
                    $newProduct->slug = Str::slug($product['name'], '-');
                    $newProduct->barcode_symbology = $barcodeSymbology;
                    $newProduct->item_code = $item_code;
                    $newProduct->item_id = $item_id;
                    $newProduct->category_id = $category->id;
                    $newProduct->brand_id = $brand->id;
                    $newProduct->unit_id = $unit_id;
                    $newProduct->user_id = $user->id;
                    $newProduct->variant_id = $variant_id;
                    $newProduct->description = trim($product['description']);
                    $newProduct->priority = isset($product['priority']) ? trim($product['priority']) : '';
                    $newProduct->type = trim($product['type']);
                    $newProduct->serial_number = trim($product['serial_number']) == 'TRUE' ? 1 : 0 ;
//                    $newProduct->cost_of_good_sold = trim($product['cost_of_good_sold']);
//                    $newProduct->last_buying_cost = trim($product['last_buying_cost']);
//                    $newProduct->last_buy_supplier_id = trim($product['last_buying_supplier']);
//                    $newProduct->valuation_method = trim($product['valuation_method']);
//                    $newProduct->reorder_point = trim($product['reorder_point']);
//                    $newProduct->stock_type = trim($product['stock_type']);
//                    $newProduct->purchase_lead_time  = trim($product['purchase_lead_time']);
//                    $newProduct->production_lead_time  = trim($product['production_lead_time']);
//                    $newProduct->minimum_purchase_qty = trim($product['minimum_purchase_qty']);
                    $newProduct->subgroup1  = trim($product['subgroup1']);
                    $newProduct->subgroup2  = trim($product['subgroup2']);
                    $newProduct->subgroup3  = trim($product['subgroup3']);
                    $newProduct->subgroup4  = trim($product['subgroup4']);
                    $newProduct->subgroup5  = trim($product['subgroup5']);
                    $newProduct->subgroup6  = trim($product['subgroup6']);
                    $newProduct->subgroup7  = trim($product['subgroup7']);
                    $newProduct->account_sales  = trim($product['account_sales']);
                    $newProduct->account_inventory  = trim($product['account_inventory']);
                    $newProduct->account_cogs  = trim($product['account_cogs']);
                    $newProduct->isactive  = trim($product['isactive']) == 'TRUE' ? 1 : 0 ;;
                    $newProduct->istemplate  = trim($product['istemplate']) == 'TRUE' ? 1 : 0 ;;
                    $newProduct->uom_sale_in   = $uom_sale_in;
                    $newProduct->uom_buy_in  = $uom_buy_in;
                    $newProduct->uom_reorder_point  = trim($product['uom_reorder_point']);
                    $newProduct->uom_order_qty  = trim($product['uom_order_qty']);
                    $newProduct->production_unit  = trim($product['production_unit']);
                    $newProduct->supplier_id  = $supplier_id;
                    $newProduct->date1  = trim($product['date1']);
                    $newProduct->receiving_tolerance  = isset($product['receiving_tolerance']) ? trim($product['receiving_tolerance']) : '';
                    $newProduct->reorder_qty  = isset($product['reorder_qty']) ? trim($product['reorder_qty']) : '';
                    $newProduct->notes  = isset($product['notes']) ? trim($product['notes']) : '';
                    $newProduct->kemasan_jual_packing  = trim($product['kemasan_jual_packing']);
                    $newProduct->kemasan_jual_qty  = trim($product['kemasan_jual_qty']);
                    $newProduct->kemasan_jual_unit  = trim($product['kemasan_jual_unit']);
                    $newProduct->kemasan_jual_weight  = trim($product['kemasan_jual_weight']);
                    $newProduct->intruksi_packing  = trim($product['intruksi_packing']);
                    $newProduct->save();

                    // MRP
                    $mrp = isset($product['mrp']) && $product['mrp'] && $product['mrp'] != '' ? trim($product['mrp']) : null;
                    if ($mrp != null) {
                        $mrp = str_replace(',', '', $mrp);
                        $mrp = str_replace('-', '', $mrp);
                        $mrp = is_numeric($mrp) ? $mrp : null;
                    }

                    // Purchase Price
//                    $purchasePrice = $product['purchase_price'] && $product['purchase_price'] != '' ?  trim($product['purchase_price']) : 0;
//                    $purchasePrice = str_replace(',', '', $purchasePrice);
//                    $purchasePrice = str_replace('-', '', $purchasePrice);
//                    $purchasePrice = is_numeric($purchasePrice) ? $purchasePrice : 0;

                    // Sales Price
//                    $salesPrice = $product['sales_price'] && $product['sales_price'] != '' ?  trim($product['sales_price']) : 0;
//                    $salesPrice = str_replace(',', '', $salesPrice);
//                    $salesPrice = str_replace('-', '', $salesPrice);
//                    $salesPrice = is_numeric($salesPrice) ? $salesPrice : 0;

                    // Wholesale Price
//                    $wholesalePrice = $product['sales_price'] && $product['sales_price'] != '' ?  trim($product['sales_price']) : null;
//                    if ($wholesalePrice != '') {
//                        $wholesalePrice = str_replace(',', '', $wholesalePrice);
//                        $wholesalePrice = str_replace('-', '', $wholesalePrice);
//                        $wholesalePrice = is_numeric($wholesalePrice) ? $wholesalePrice : null;
//                    }

                    $purchasePrice = 0;
                    $salesPrice = 0;
                    foreach ($allWarehouses as $allWarehouse) {
                        $newProductDetails = new ProductDetails();
                        $newProductDetails->warehouse_id = $allWarehouse->id;
                        $newProductDetails->product_id = $newProduct->id;
                        $newProductDetails->tax_id = 1;
                        $newProductDetails->purchase_tax_type = 'exclusive';
                        $newProductDetails->sales_tax_type = 'exclusive';
                        $newProductDetails->mrp = $mrp;
                        $newProductDetails->purchase_price = $purchasePrice;
                        $newProductDetails->sales_price = $salesPrice;
                        $newProductDetails->stock_quantitiy_alert = $stockQuantityAlert != "" ? (int) $stockQuantityAlert : null;
                        //$newProductDetails->opening_stock = $openingStock != "" ? (int) $openingStock : null;
                        //$newProductDetails->opening_stock_date = $openingStockDate != "" ? $openingStockDate : null;
                        $newProductDetails->wholesale_price = $wholesalePrice;
                        $newProductDetails->wholesale_quantity = $wholesaleQuantity == "" ? null : $wholesaleQuantity;
                        $newProductDetails->save();
                    }
                    
                    $currentProductDetails = $newProduct->details;
                    $currentProductDetails->opening_stock = $openingStock != "" ? (int) $openingStock : null;
                    $currentProductDetails->opening_stock_date = $openingStockDate != "" ? $openingStockDate : null;
                    $currentProductDetails->save();

                    Common::recalculateOrderStock($currentProductDetails->warehouse_id, $newProduct->id);
                }
            }
        });
    }       
}
