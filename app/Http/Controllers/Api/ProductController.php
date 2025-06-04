<?php

namespace App\Http\Controllers\Api;

use App\Classes\Common;
use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Product\CheckVariantRequest;
use App\Http\Requests\Api\Product\IndexRequest;
use App\Http\Requests\Api\Product\StoreRequest;
use App\Http\Requests\Api\Product\UpdateRequest;
use App\Http\Requests\Api\Product\DeleteRequest;
use App\Http\Requests\Api\Product\ImportRequest;
use App\Exports\ProductExport;
use App\Imports\ProductImport;
use App\Models\Product;
use App\Models\ProductDetails;
use App\Models\ProductVariant;
use App\Models\ProductPlacement;
use App\Models\Tax;
use App\Models\Unit;
use App\Models\Variation;
use App\Models\Warehouse;
use App\Models\Brand;
use App\Models\Barcode;
use App\Models\Category;
use Illuminate\Http\Request;
use Examyou\RestAPI\ApiResponse;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use Vinkla\Hashids\Facades\Hashids;
use Illuminate\Support\Str;
use Examyou\RestAPI\Exceptions\ApiException;

class ProductController extends ApiBaseController
{
    protected $model = Product::class;

    protected $indexRequest = IndexRequest::class;
    protected $storeRequest = StoreRequest::class;
    protected $updateRequest = UpdateRequest::class;
    protected $deleteRequest = DeleteRequest::class;

    public function modifyIndex($query)
    {
        $request = request();
        $warehouse = warehouse();

        if ($warehouse->products_visibility == 'warehouse') {
            $query->where('products.warehouse_id', '=', $warehouse->id);
        }

        if ($request->has('product_type') && $request->product_type == 'variable') {
            $query = $query->whereNull('products.parent_id')
                ->where('products.product_type', 'variable');
        } else if ($request->has('product_type') && $request->product_type == 'single') {
            $query = $query->join('product_details', 'product_details.product_id', '=', 'products.id')
                ->where('product_details.warehouse_id', $warehouse->id)
                ->whereNull('products.parent_id')
                ->where('products.product_type', 'single');
        } else {
            $query = $query->join('product_details', 'product_details.product_id', '=', 'products.id')
                ->where('product_details.warehouse_id', $warehouse->id);
        }

        if ($request->has('product_type') && $request->product_type == 'service') {
            $query = $query->whereNull('products.parent_id')
                ->where('products.product_type', 'service');
        }


        if ($request->has('fetch_stock_alert') && $request->fetch_stock_alert) {
            $query = $query->whereNotNull('stock_quantitiy_alert')
                ->whereRaw('product_details.current_stock <= product_details.stock_quantitiy_alert');
        };

        if ($request->has('x_id') && $request->x_id != '') {
            $query = $query->where('products.id', $this->getIdFromHash($request->x_id));
        };
//dd($query);
        return $query;
    }

    public function storing(Product $product)
    {
        $request = request();
        $loggedUser = user();
        $warehouse = warehouse();
        
        $product->user_id = $loggedUser->id;
        $product->warehouse_id = $loggedUser->hasRole('admin') && $request->warehouse_id != '' ? $request->warehouse_id : $warehouse->id;

        return $product;
    }
    public function stored(Product $product)
    {
        $request = request();
        $allWarehouses = Warehouse::select('id')->get();
        $productType = $product->product_type;

        if ($productType == 'variable') {
            $allVariations = $request->variations;

            foreach ($allVariations as $allVariation) {
                // $variantValueId = $this->getIdFromHash($allVariation['variant_value_id']);
                // $variantValue = Variation::find($variantValueId);

                $allRequestVariantTypes = $allVariation['variant_value_id'];
                $fullName = $product->name . ' - ';
                foreach ($allRequestVariantTypes as $allRequestVariantType) {
                    $convertedVariantValueId = $this->getIdFromHash($allRequestVariantType);
                    $variantValueRecord = Variation::find($convertedVariantValueId);

                    $fullName .= $variantValueRecord->name . ',';
                }


                $newVariantProduct = new Product();
                $newVariantProduct->image = isset($allVariation['image']) ? $allVariation['image'] : null;
                $newVariantProduct->warehouse_id = $product->warehouse_id;
                $newVariantProduct->product_type = 'single';
                $newVariantProduct->name = trim($fullName, ',');
                $newVariantProduct->slug = Str::slug($newVariantProduct->name, '-').'-'.date('His');
                $newVariantProduct->barcode_symbology = $product->barcode_symbology;
                $newVariantProduct->item_code = $allVariation['item_code'];
                $newVariantProduct->parent_item_code = $product->item_code;
                $newVariantProduct->category_id = $product->category_id;
                $newVariantProduct->brand_id = $product->brand_id;
                $newVariantProduct->unit_id = $product->unit_id;
                $newVariantProduct->kemasan_jual_packing = $product->kemasan_jual_packing;
                $newVariantProduct->kemasan_jual_qty = $product->kemasan_jual_qty;
                $newVariantProduct->kemasan_jual_unit = $product->kemasan_jual_unit;
                $newVariantProduct->kemasan_jual_weight = $product->kemasan_jual_weight;
                $newVariantProduct->intruksi_packing = $product->intruksi_packing;
                $newVariantProduct->text1 = $product->text1;
                $newVariantProduct->text2 = $product->text2;
                $newVariantProduct->uom_sale_in = $this->getIdFromHash($product->uom_sale_in);
                $newVariantProduct->uom_buy_in = $this->getIdFromHash($product->uom_buy_in);
                $newVariantProduct->numeric1 = $product->numeric1;
                $newVariantProduct->user_id = user()->id;
                // $newVariantProduct->variant_id = $allVariation['variant_id'];
                // $newVariantProduct->variant_value_id = $allVariation['variant_value_id'];
                $newVariantProduct->parent_id = $product->id;
                $newVariantProduct->save();

                file_put_contents(storage_path('logs') . '/product.log', "[" . date('Y-m-d H:i:s') . "]test 1 : \n" . $this->getIdFromHash($product->uom_sale_in) . "\n\n", FILE_APPEND);
                    acsac:qfile_put_contents(storage_path('logs') . '/product.log', "[" . date('Y-m-d H:i:s') . "]test 1 : \n" . $this->getIdFromHash($product->uom_buy_in) . "\n\n", FILE_APPEND);
                    file_put_contents(storage_path('logs') . '/product.log', "[" . date('Y-m-d H:i:s') . "]test 1 : \n" . $this->getIdFromHash($product->kemasan_jual_unit) . "\n\n", FILE_APPEND);
                    
                foreach ($allRequestVariantTypes as $allRequestVariantType) {
                    $convertedVariantValueId = $this->getIdFromHash($allRequestVariantType);
                    $variantValueRecord = Variation::find($convertedVariantValueId);

                    $newProductVariant = new ProductVariant();
                    $newProductVariant->product_id = $newVariantProduct->id;
                    $newProductVariant->variant_id = $variantValueRecord->parent_id;
                    $newProductVariant->variant_value_id = $variantValueRecord->id;
                    $newProductVariant->save();
                }

                foreach ($allWarehouses as $allWarehouse) {
                    $productDetails = new ProductDetails();
                    $productDetails->warehouse_id = $allWarehouse->id;
                    $productDetails->product_id = $newVariantProduct->id;

                    $productDetails->tax_id = isset($allVariation['tax_id']) && $allVariation['tax_id'] != '' ? $allVariation['tax_id'] : null;
                    //$productDetails->mrp = $allVariation['mrp'];
                    $productDetails->purchase_price = $allVariation['purchase_price'];
                    $productDetails->sales_price = $allVariation['sales_price'];
                    //$productDetails->purchase_tax_type = $allVariation['purchase_tax_type'];
                    //$productDetails->sales_tax_type = $allVariation['sales_tax_type'];
                    $productDetails->stock_quantitiy_alert = isset($allVariation['stock_quantitiy_alert']) ? $allVariation['stock_quantitiy_alert'] : null;
                    // $productDetails->wholesale_price = $request->wholesale_price;
                    // $productDetails->wholesale_quantity = $request->wholesale_quantity;
                    $productDetails->save();

                    // Common::updateProductCustomFields($product, $allWarehouse->id);
                }

                // Saving Opening Stock and date for current product
                // Becuase these values will be different for each product
                // At warehouse
                $currentProductDetails = $newVariantProduct->details;
                $currentProductDetails->opening_stock = $allVariation['opening_stock'];
                $currentProductDetails->opening_stock_date = isset($allVariation['opening_stock_date']) ? $allVariation['opening_stock_date'] : null;
                $currentProductDetails->save();

                Common::recalculateOrderStock($currentProductDetails->warehouse_id, $newVariantProduct->id);
            }
        } else {
            foreach ($allWarehouses as $allWarehouse) {
                $productDetails = new ProductDetails();
                $productDetails->warehouse_id = $allWarehouse->id;
                $productDetails->product_id = $product->id;

                $productDetails->tax_id = $request->has('tax_id') && $request->tax_id != '' ? $request->tax_id : null;
                $productDetails->mrp = $request->mrp;
                $productDetails->purchase_price = $request->purchase_price;
                $productDetails->sales_price = $request->sales_price;
                $productDetails->purchase_tax_type = $request->purchase_tax_type;
                $productDetails->sales_tax_type = $request->sales_tax_type;
                $productDetails->stock_quantitiy_alert = $request->has('stock_quantitiy_alert') && $request->stock_quantitiy_alert != '' ? $request->stock_quantitiy_alert : null;
                $productDetails->wholesale_price = $request->wholesale_price;
                $productDetails->wholesale_quantity = $request->wholesale_quantity;
                $productDetails->save();

                Common::updateProductCustomFields($product, $allWarehouse->id);
            }

            // Saving Opening Stock and date for current product
            // Becuase these values will be different for each product
            // At warehouse
            $currentProductDetails = $product->details;
            $currentProductDetails->opening_stock = $request->opening_stock;
            $currentProductDetails->opening_stock_date = $request->has('opening_stock_date') ? $request->opening_stock_date : null;
            $currentProductDetails->save();

            Common::recalculateOrderStock($currentProductDetails->warehouse_id, $product->id);
        }
    }

    public function updating($product)
    {
        $request = request();
        $loggedUser = user();

        if ($loggedUser->hasRole('admin') && $request->warehouse_id != '') {
            $product->warehouse_id = $request->warehouse_id;
        }
        file_put_contents(storage_path('logs') . '/product.log', "[" . date('Y-m-d H:i:s') . "]test 1 : \n" . print_r($request->uom_buy_in,1) . "\n\n", FILE_APPEND);
        $product->uom_sale_in = isset($request->uom_sale_in) && is_string($request->uom_sale_in) ? $this->getIdFromHash($request->uom_sale_in) : 1;
        $product->uom_buy_in = isset($request->uom_buy_in) && is_string($request->uom_buy_in) ? $this->getIdFromHash($request->uom_buy_in) : 1;
        $product->kemasan_jual_unit = isset($request->kemasan_jual_unit) && is_string($request->kemasan_jual_unit) ? $this->getIdFromHash($request->kemasan_jual_unit) : 1;
            
        return $product;
    }

    public function updated(Product $product)
    {
        $request = request();
        $productType = $product->product_type;
        $allWarehouses = Warehouse::select('id')->get();
//        file_put_contents(storage_path('logs') . '/product.log', "[" . date('Y-m-d H:i:s') . "]test 1 : \n" . $productType . "\n\n", FILE_APPEND);
        if ($productType == 'variable') {
            $allVariations = $request->variations;

            foreach ($allVariations as $allVariation) {
                // This is newly added variant product
                if ($allVariation['xid'] == '') {
                    // $variantValueId = $this->getIdFromHash($allVariation['variant_value_id']);
                    // $variantValue = Variation::find($variantValueId);

                    $allRequestVariantTypes = $allVariation['variant_value_id'];
                    $fullName = $product->name . ' - ';
                    foreach ($allRequestVariantTypes as $allRequestVariantType) {
                        $convertedVariantValueId = $this->getIdFromHash($allRequestVariantType);
                        $variantValueRecord = Variation::find($convertedVariantValueId);

                        $fullName .= $variantValueRecord->name . ',';
                    }

                    $newVariantProduct = new Product();
                    $newVariantProduct->image = isset($allVariation['image']) ? $allVariation['image'] : null;
                    $newVariantProduct->warehouse_id = $product->warehouse_id;
                    $newVariantProduct->product_type = 'single';
                    $newVariantProduct->name = trim($fullName, ',');
                    $newVariantProduct->slug = Str::slug($newVariantProduct->name, '-');
                    $newVariantProduct->barcode_symbology = $product->barcode_symbology;
                    $newVariantProduct->item_code = $allVariation['item_code'];
                    $newVariantProduct->parent_item_code = $product->item_code;
                    $newVariantProduct->category_id = $product->category_id;
                    $newVariantProduct->brand_id = $product->brand_id;
                    $newVariantProduct->unit_id = $product->unit_id;
                    $newVariantProduct->user_id = user()->id;
                    $newVariantProduct->kemasan_jual_packing = $product->kemasan_jual_packing;
                    $newVariantProduct->kemasan_jual_qty = $product->kemasan_jual_qty;
                    $newVariantProduct->kemasan_jual_weight = $product->kemasan_jual_weight;
                    $newVariantProduct->intruksi_packing = $product->intruksi_packing;
                    $newVariantProduct->text1 = $product->text1;
                    $newVariantProduct->text2 = $product->text2;
                    $newVariantProduct->uom_sale_in = $this->getIdFromHash($product->uom_sale_in);
                    $newVariantProduct->uom_buy_in = $this->getIdFromHash($product->uom_buy_in);
                    $newVariantProduct->kemasan_jual_unit = $this->getIdFromHash($product->kemasan_jual_unit);
                    $newVariantProduct->numeric1 = $product->numeric1;
                    // $newVariantProduct->variant_id = $allVariation['variant_id'];
                    // $newVariantProduct->variant_value_id = $allVariation['variant_value_id'];
                    $newVariantProduct->parent_id = $product->id;
                    $newVariantProduct->save();

                    // Deleting Previous ProductVariants
                    ProductVariant::where('product_id', $newVariantProduct->id)->delete();
                    foreach ($allRequestVariantTypes as $allRequestVariantType) {
                        $convertedVariantValueId = $this->getIdFromHash($allRequestVariantType);
                        $variantValueRecord = Variation::find($convertedVariantValueId);

                        $newProductVariant = new ProductVariant();
                        $newProductVariant->product_id = $newVariantProduct->id;
                        $newProductVariant->variant_id = $variantValueRecord->parent_id;
                        $newProductVariant->variant_value_id = $variantValueRecord->id;
                        $newProductVariant->save();
                    }

                    foreach ($allWarehouses as $allWarehouse) {
                        $productDetails = new ProductDetails();
                        $productDetails->warehouse_id = $allWarehouse->id;
                        $productDetails->product_id = $newVariantProduct->id;

                        $productDetails->tax_id = isset($allVariation['tax_id']) && $allVariation['tax_id'] != '' ? $allVariation['tax_id'] : null;
                        $productDetails->mrp = $allVariation['mrp'];
                        $productDetails->purchase_price = $allVariation['purchase_price'];
                        $productDetails->sales_price = $allVariation['sales_price'];
                        $productDetails->purchase_tax_type = $allVariation['purchase_tax_type'];
                        $productDetails->sales_tax_type = $allVariation['sales_tax_type'];
                        $productDetails->stock_quantitiy_alert = $request->stock_quantitiy_alert;
                        $productDetails->wholesale_price = $request->wholesale_price;
                        $productDetails->wholesale_quantity = $request->wholesale_quantity;
                        $productDetails->save();

                        // Common::updateProductCustomFields($product, $allWarehouse->id);
                    }

                    // Saving Opening Stock and date for current product
                    // Becuase these values will be different for each product
                    // At warehouse
                    $currentProductDetails = $newVariantProduct->details;
                    $currentProductDetails->opening_stock = $allVariation['opening_stock'];
                    $currentProductDetails->opening_stock_date = isset($allVariation['opening_stock_date']) ? $allVariation['opening_stock_date'] : null;
                    $currentProductDetails->save();

                    Common::recalculateOrderStock($currentProductDetails->warehouse_id, $newVariantProduct->id);
                } else {
                    // This is old variant product
                    $variantProductId =  $this->getIdFromHash($allVariation['xid']);

                    $variantProduct = Product::find($variantProductId);

                    // $variantValueId = $variantProduct->variant_value_id;
                    // $variantValue = Variation::find($variantValueId);
                    $allRequestVariantTypes = $allVariation['variant_value_id'];
                    $fullName = $product->name . ' - ';
                    foreach ($allRequestVariantTypes as $allRequestVariantType) {
                        $convertedVariantValueId = $this->getIdFromHash($allRequestVariantType);
                        $variantValueRecord = Variation::find($convertedVariantValueId);

                        $fullName .= $variantValueRecord->name . ',';
                    }

                    $variantProduct->name = trim($fullName, ',');
                    $variantProduct->slug = Str::slug($variantProduct->name, '-');
                    $variantProduct->item_code = $allVariation['item_code'];
                    $variantProduct->image = isset($allVariation['image']) ? $allVariation['image'] : null;
                    $variantProduct->category_id = $product->category_id;
                    $variantProduct->brand_id = $product->brand_id;
                    $variantProduct->unit_id = $product->unit_id;
                    $variantProduct->save();

                    $currentProductDetails = $variantProduct->details;
                    $currentProductDetails->tax_id = isset($allVariation['tax_id']) && $allVariation['tax_id'] != '' ? $allVariation['tax_id'] : null;
                    $currentProductDetails->mrp = $allVariation['mrp'];
                    $currentProductDetails->purchase_price = $allVariation['purchase_price'];
                    $currentProductDetails->sales_price = $allVariation['sales_price'];
                    $currentProductDetails->purchase_tax_type = $allVariation['purchase_tax_type'];
                    $currentProductDetails->sales_tax_type = $allVariation['sales_tax_type'];
                    $currentProductDetails->stock_quantitiy_alert = isset($allVariation['stock_quantitiy_alert']) ? $allVariation['stock_quantitiy_alert'] : null;;
                    // $currentProductDetails->wholesale_price = $request->wholesale_price;
                    // $currentProductDetails->wholesale_quantity = $request->wholesale_quantity;
                    $currentProductDetails->opening_stock = $allVariation['opening_stock'];
                    $currentProductDetails->opening_stock_date = isset($allVariation['opening_stock_date']) ? $allVariation['opening_stock_date'] : null;
                    $currentProductDetails->save();

                    Common::updateProductCustomFields($variantProduct, $currentProductDetails->warehouse_id);
                    Common::recalculateOrderStock($currentProductDetails->warehouse_id, $variantProduct->id);
                }
            }
        } else {
            $currentProductDetails = $product->details;
            $currentProductDetails->tax_id = $request->has('tax_id') && $request->tax_id != '' ? $request->tax_id : null;
            $currentProductDetails->mrp = $request->mrp;
            $currentProductDetails->purchase_price = $request->purchase_price;
            $currentProductDetails->sales_price = $request->sales_price;
            $currentProductDetails->purchase_tax_type = $request->purchase_tax_type;
            $currentProductDetails->sales_tax_type = $request->sales_tax_type;
            $currentProductDetails->stock_quantitiy_alert = $request->stock_quantitiy_alert;
            $currentProductDetails->wholesale_price = $request->wholesale_price;
            $currentProductDetails->wholesale_quantity = $request->wholesale_quantity;
            $currentProductDetails->opening_stock = $request->opening_stock;
            $currentProductDetails->opening_stock_date = $request->has('opening_stock_date') ? $request->opening_stock_date : null;
            $currentProductDetails->save();

            Common::updateProductCustomFields($product, $currentProductDetails->warehouse_id);
            Common::recalculateOrderStock($currentProductDetails->warehouse_id, $product->id);
        }
    }

    public function searchProduct(Request $request)
    {
        $warehouse = warehouse();
        $searchTerm = trim(strtolower($request->search_term));
        $orderType = $request->order_type;
        $warehouseId = $warehouse->id;
        $salesId = isset($request->sales_id) ? $this->getIdFromHash($request->sales_id) : '';

        $products = Product::select('products.id', 'products.name', 'products.image', 'products.unit_id', 'products.product_type','products.product_type','products.description','products.item_code','products.item_id','products.subgroup2','products.text1','products.uom_sale_in','products.uom_buy_in','products.kemasan_jual_qty','products.text1')
            ->where(function ($query) use ($searchTerm) {
                $query->where(DB::raw('LOWER(products.name)'), 'LIKE', "%$searchTerm%")
                    ->orWhere(DB::raw('LOWER(products.item_code)'), 'LIKE', "%$searchTerm%")
                    ->orWhere(DB::raw('LOWER(products.item_id)'), 'LIKE', "%$searchTerm%")
                    ->orWhere(DB::raw('LOWER(products.parent_item_code)'), 'LIKE', "%$searchTerm%");
            });
            
        if($salesId != ''){
            $products->join('order_items','order_items.product_id', '=', 'products.id')
                     ->where('order_items.order_id','=', $salesId);
        }
        
        if ($warehouse->products_visibility == 'warehouse') {
            $products->where('products.warehouse_id', '=', $warehouse->id);
        }

        if ($request->has('products')) {
            $selectedProducts = $request->products;
            $convertedSelectedProducts = [];
            if (count($selectedProducts) > 0) {
                foreach ($selectedProducts as $selectedProduct) {
                    $convertedSelectedProducts[] = $this->getIdFromHash($selectedProduct);
                }
            }
            $products = $products->whereNotIn('products.id', $convertedSelectedProducts);
        }

        $products = $products->where('products.product_type', 'single')->get();

        $allProducs = [];

        if ($warehouseId == '') {
            return $allProducs;
        } else {
            $warehouseId = Common::getHashFromId($warehouseId);
        }

        foreach ($products as $product) {
            $productDetails = $product->details;
            $tax = Tax::find($productDetails->tax_id);

            if ($orderType == 'product-placement' || $orderType == 'purchases' || $orderType == 'quotations' || $orderType == 'sales' || $orderType == 'sales-returns' || $orderType == 'repeat-order'
                || $orderType == 'purchase-returns' || $orderType == 'stock-transfers' || $orderType == 'stock-transfer-returns'
                || $orderType == 'stock-adjustment-orders'
            ) {
                $stockQuantity = $productDetails->current_stock;
                $unit = $product->unit_id != null ? Unit::find($product->unit_id) : null;

                //* ADDENDUM
                $brand = $product->brand_id != null ? Brand::where('id', '=', $product->brand_id)->first() : null;
                $category = $product->category_id != null ? Category::where('id', '=', $product->category_id)->first() : null;
                $group = $product->group_id != null ? Group::where('id', '=', $product->group_id)->first() : null;
                $color = $product->color_id != null ? Color::where('id', '=', $product->color_id)->first() : null;
                $discountRate = $productDetails->discount_counter_price != 'SP' ? $productDetails->discount_counter_price : 0;
                $unit_buy_in = $product->uom_buy_in != null ? Unit::find($product->uom_buy_in) : null;
                $unit_sale_in = $product->uom_sale_in != null ? Unit::find($product->uom_sale_in) : null;
                
                if ($orderType == 'product-placement' || $orderType == 'purchases' || $orderType == 'purchase-returns' || $orderType == 'stock-adjustment-orders') {
                    $taxType = $productDetails->purchase_tax_type;
                } else if ($orderType == 'sales' || $orderType == 'sales-returns'
                    || $orderType == 'stock-transfers' || $orderType == 'stock-transfer-returns'
                    || $orderType == 'quotations'|| $orderType == 'repeat-order'
                ) {
                    $taxType = $productDetails->sales_tax_type;
                    
                }
                $unitPrice = $productDetails->retail_counter_price != null ? $productDetails->retail_counter_price : 0;
                $productType = 'retail_counter_price';
                $singleUnitPrice = $unitPrice;

                if ($tax && $tax->rate != '') {
                    $taxRate = $tax->rate;

                    if ($taxType == 'inclusive') {
                        $subTotal = $singleUnitPrice;
                        $singleUnitPrice =  ($singleUnitPrice * 100) / (100 + $taxRate);
                        $taxAmount = ($singleUnitPrice) * ($taxRate / 100);
                    } else {
                        $taxAmount =  ($singleUnitPrice * ($taxRate / 100));
                        $subTotal = $singleUnitPrice + $taxAmount;
                    }
                } else {
                    $taxAmount = 0;
                    $taxRate = 0;
                    $subTotal = $singleUnitPrice;
                }

                if ($discountRate > 0) {
                    $subTotal = (float)$subTotal - ((float)$subTotal * (float) $discountRate / 100);
                }

                $allProducs[] = [
                    'item_id'    =>  '',
                    'xid'    =>  $product->xid,
                    'product_item_id'    =>  $product->item_id,
                    'kem'    =>  $product->text1,
                    'name'    =>  $product->name,
                    'image'    =>  $product->image,
                    'image_url'    =>  $product->image_url,
                    'discount_rate'    =>  0,
                    'total_discount'    =>  0,
                    'x_tax_id'    =>  $tax ? $tax->xid : null,
                    'tax_type'    =>  $taxType,
                    'tax_rate'    =>  $taxRate,
                    'total_tax'    =>  $taxAmount,
                    'x_unit_id'    =>  Hashids::encode($product->unit_id),
                    'unit'    =>  $unit,
                    'unit_price'    =>  $unitPrice,
                    'single_unit_price'    =>  $singleUnitPrice,
                    'subtotal'    =>  $subTotal,
                    'quantity'    =>  1,
                    'stock_quantity'    =>  $stockQuantity,
                    'unit_short_name'    =>  $unit ? $unit->short_name : '',

                    //* ADDENDUM
                    'item_code'  =>  $product->item_code,
                    'qty_bungkus'  =>  $product->kemasan_jual_qty,
                    'description'  =>  $product->description,
                    'subgroup2'  =>  $product->subgroup2,
                    'text1'  =>  $product->text1,
                    'unit_buy_in'    =>  $unit_buy_in,
                    'unit_sale_in'    =>  $unit_sale_in,
                    'brand' => $brand,
                    'category' => $category,
                    'group' => $group,
                    'color' => $color,
                    'product_stock_quantity' => $stockQuantity,
                    //'placement_qty' => ProductPlacement::where('product_id', $this->getIdFromHash($product->xid))->count(),
                    'purchase_price' => $productDetails->purchase_price,
                    'retail_counter_price' => $productDetails->retail_counter_price,
                    'special_counter_price' => $productDetails->special_counter_price,
                    'discount_counter_price' => $productDetails->discount_counter_price,
                    'retail_online_price' => $productDetails->retail_online_price,
                    'special_online_price' => $productDetails->special_online_price,
                    'discount_online_price' => $productDetails->discount_online_price,
                    'discount_rate' => $discountRate,
                    'price_type' => $productType,
                    'notes' => null,
                    'order_type' => $orderType,
                    'adjustment_type' => $orderType == 'stock-adjustment-orders' ? 'add' : ''
                ];
            }

            // All Type products
            if (!$request->has('order_type')) {
                $allProducs[] = [
                    'xid'    =>  $product->xid,
                    'name'    =>  $product->name,
                    'image'    =>  $product->image,
                    'image_url'    =>  $product->image_url,
                    'stock_quantity'    =>  $productDetails->current_stock,

                    //* ADDENDUM
                    'item_code'  =>  $product->item_code,
                ];
            }
        }

        return ApiResponse::make('Fetched Successfully', $allProducs);
    }
    
    public function searchBarcode(Request $request)
    {
        $searchTerm = trim(strtolower($request->search_term));
        $item_id = trim(strtolower($request->item_id));
        $isactive = isset($request->isactive) ? trim($request->isactive) : 0;
        
        $barcodes = Barcode::select('string','id','qty_bungkus')
            ->where(DB::raw('LOWER(string)'), 'LIKE', "%$searchTerm%")
            ->where('isactive',$isactive)->get()->toArray();

        $product = Product::where('item_id',$item_id)->select('kemasan_jual_qty')->first();
        if(count($barcodes)>0){
            foreach($barcodes as $k => $barcode){
                if($barcodes[$k]['qty_bungkus'] == null){
                    $barcodes[$k]['qty_bungkus'] = $product->kemasan_jual_qty;
                }
            }
        }
        
        
        
        return ApiResponse::make('Fetched Successfully', $barcodes);
    }
    
    
    public function searchProductPlacement(Request $request)
    {
        $warehouse = warehouse();
        $searchTerm = $request->search_term;
        $orderType = $request->order_type;
        $warehouseId_hash = $request->warehouse_id;
        $floor = $request->floor;
        $shelfGroup = $request->shelf_group;
        $shelfNumber = $request->shelf_number;
        $row = $request->row;

        $warehouseId = '';
        if($warehouseId_hash != '') {
            $warehouseId = Common::getIdFromHash($warehouseId_hash);
        }
        else{
            return [];
        }
        

        $products = Product::select('products.id', 'products.name', 'products.image', 'products.unit_id', 'products.item_code', 'products.brand_id', 'products.category_id')
            ->where(
                function ($query) use ($searchTerm) {
                    $query->where('products.name', 'LIKE', "%$searchTerm%")
                        ->orWhere('products.item_code', trim($searchTerm))
                        ->orWhere('products.item_id', trim($searchTerm))
                        ->orWhere('products.parent_item_code', trim($searchTerm));
                }
            )
            ->join('product_placements', 'products.id', '=', 'product_placements.product_id');

        if ($request->has('products')) {
            $selectedProducts = $request->products;
            $convertedSelectedProducts = [];
            if (count($selectedProducts) > 0) {
                foreach ($selectedProducts as $selectedProduct) {
                    $convertedSelectedProducts[] = $this->getIdFromHash($selectedProduct);
                }
            }
            $products = $products->whereNotIn('products.id', $convertedSelectedProducts);
        }

        if($warehouseId != '') {
            $products = $products->where('product_placements.warehouse_id', $warehouseId);
        }
        if($floor != '') {
            $products = $products->where('product_placements.floor', Common::getIdFromHash($floor));
        }
        if($shelfGroup != '') {
            $products = $products->where('product_placements.shelf_group', Common::getIdFromHash($shelfGroup));
        }
        if($shelfNumber != '') {
            $products = $products->where('product_placements.shelf_number', Common::getIdFromHash($shelfNumber));
        }
        if($row != '') {
            $products = $products->where('product_placements.row', Common::getIdFromHash($row));
        }


        //file_put_contents(storage_path('logs') . '/test.log', "[" . date('Y-m-d H:i:s') . "]test 1 : \n" . $products->toSql() . "\n\n", FILE_APPEND);
        $products = $products->where('products.product_type', 'single')->distinct()->get();
        //file_put_contents(storage_path('logs') . '/test.log', "[" . date('Y-m-d H:i:s') . "]test 1 : \n" . print_r($products, 1) . "\n\n", FILE_APPEND);
        $allProducs = [];

        foreach ($products as $product) {
            $productDetails = $product->details;

            $tax = $productDetails->tax_id != null ? Tax::find($productDetails->tax_id) : null;

            if ($orderType == 'product-placement' || $orderType == 'purchases' || $orderType == 'quotations' || ($orderType == 'sales' && $productDetails->current_stock > 0) || ($orderType == 'sales-returns')
                || ($orderType == 'purchase-returns' && $productDetails->current_stock > 0) || ($orderType == 'stock-transfers' && $productDetails->current_stock > 0) || ($orderType == 'stock-transfer-returns' && $productDetails->current_stock > 0)
            ) {
                $stockQuantity = $productDetails->current_stock;
                $unit = $product->unit_id != null ? Unit::find($product->unit_id) : null;
                $details = ProductDetails::find($product->id);
                //* ADDENDUM
                $brand = $product->brand_id != null ? Brand::where('id', '=', $product->brand_id)->first() : null;
                $category = $product->category_id != null ? Category::where('id', '=', $product->category_id)->first() : null;
                
                if ($orderType == 'product-placement' || $orderType == 'purchases' || $orderType == 'purchase-returns') {
                    $unitPrice = $productDetails->purchase_price;
                    $taxType = $productDetails->purchase_tax_type;
                } else if ($orderType == 'sales' || $orderType == 'sales-returns'
                    || $orderType == 'stock-transfers' || $orderType == 'stock-transfer-returns'
                    || $orderType == 'quotations'
                ) {
                    $unitPrice = $productDetails->sales_price;
                    $taxType = $productDetails->sales_tax_type;
                }

                $singleUnitPrice = $unitPrice;

                if ($tax && $tax->rate != '') {
                    $taxRate = $tax->rate;

                    if ($taxType == 'inclusive') {
                        $subTotal = $singleUnitPrice;
                        $singleUnitPrice =  ($singleUnitPrice * 100) / (100 + $taxRate);
                        $taxAmount = ($singleUnitPrice) * ($taxRate / 100);
                    } else {
                        $taxAmount =  ($singleUnitPrice * ($taxRate / 100));
                        $subTotal = $singleUnitPrice + $taxAmount;
                    }
                } else {
                    $taxAmount = 0;
                    $taxRate = 0;
                    $subTotal = $singleUnitPrice;
                }

                //                $qty = ProductPlacement::where('product_id',$product->id)
                //                       ->where('warehouse_id',$warehouseId);

                //                if($floor != ''){
                //                    $qty->where('floor',$floor);
                //                }
                //
                //                if($shelfGroup != ''){
                //                    $qty->where('shelf_group',$shelfGroup);
                //                }
                //
                //                if($shelfNumber != ''){
                //                    $qty->where('shelf_number',$shelfNumber);
                //                }
                //
                //                if($row != ''){
                //                    $qty->where('row',$row);
                //                }
                //
                //                $qty = $qty->count();

                $qty = 1;
                $placement_qty = ProductPlacement::where('product_id', $this->getIdFromHash($product->xid))->where('warehouse_id', $warehouseId);

                if($floor != '') {
                    $placement_qty->where('floor', Common::getIdFromHash($floor));
                }

                if($shelfGroup != '') {
                    $placement_qty->where('shelf_group', Common::getIdFromHash($shelfGroup));
                }

                if($shelfNumber != '') {
                    $placement_qty->where('shelf_number', Common::getIdFromHash($shelfNumber));
                }

                if($row != '') {
                    $placement_qty->where('row', Common::getIdFromHash($row));
                }

                $placement_qty = $placement_qty->count();

                $allProducs[] = [
                    'item_id'    =>  '',
                    'xid'    =>  $product->xid,
                    'name'    =>  $product->name,
                    'image'    =>  $product->image,
                    'image_url'    =>  $product->image_url,
                    'discount_rate'    =>  0,
                    'total_discount'    =>  0,
                    'x_tax_id'    =>  $tax ? $tax->xid : null,
                    'tax_type'    =>  $taxType,
                    'tax_rate'    =>  $taxRate,
                    'total_tax'    =>  $taxAmount,
                    'x_unit_id'    =>  Hashids::encode($product->unit_id),
                    'unit'    =>  $unit,
                    'unit_price'    =>  $unitPrice,
                    'single_unit_price'    =>  $singleUnitPrice,
                    'subtotal'    =>  $subTotal,
                    'quantity'    =>  $qty,
                    'stock_quantity'    =>  $stockQuantity,
                    'unit_short_name'    =>  $unit ? $unit->short_name : '',

                    //* ADDENDUM
                    'item_code'  =>  $product->item_code,
                    'brand' => $brand,
                    'category' => $category,
                    'details' => $details,
                    'retail_counter_price' => $productDetails->retail_counter_price,
                    'special_counter_price' => $productDetails->special_counter_price,
                    'discount_counter_price' => $productDetails->discount_counter_price,
                    'retail_online_price' => $productDetails->retail_online_price,
                    'special_online_price' => $productDetails->special_online_price,
                    'discount_online_price' => $productDetails->discount_online_price,
                    'placement_qty' => $placement_qty,
                ];
            }

            // All Type products
            if (!$request->has('order_type')) {
                $allProducs[] = [
                    'xid'    =>  $product->xid,
                    'name'    =>  $product->name,
                    'image'    =>  $product->image,
                    'image_url'    =>  $product->image_url,
                    'stock_quantity'    =>  $productDetails->current_stock,

                    //* ADDENDUM
                    'item_code'  =>  $product->item_code,
                ];
            }
        }

        return ApiResponse::make('Fetched Successfully', $allProducs);
    }

    public function getWarehouseStock(Request $request)
    {
        $warehouse = warehouse();
        $stockValue = "-";

        $warehouseId = $warehouse->id;
        $productId = $this->getIdFromHash($request->product_id);

        if ($warehouseId != '' && $productId != '') {
            $stock = ProductDetails::withoutGlobalScope('current_warehouse')
                ->where('warehouse_id', '=', $warehouseId)
                ->where('product_id', '=', $productId)
                ->first();

            if ($stock) {
                $stockValue = $stock->current_stock;
            }
        }

        return ApiResponse::make('Fetched Successfully', ['stock' => $stockValue]);
    }

    public function import(ImportRequest $request)
    {
        if ($request->hasFile('file')) {
            Cache::forget('import-current-row');
            Excel::import(new ProductImport, request()->file('file'));
        }

        return ApiResponse::make('Imported Successfully', []);
    }

    public function export()
    {
        return Excel::download(new ProductExport, 'products.xlsx');
    }

    public function checkProductVariant(CheckVariantRequest $request)
    {
        return ApiResponse::make('Added Successfully', []);
    }
}
