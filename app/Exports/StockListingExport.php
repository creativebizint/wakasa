<?php

namespace App\Exports;

use App\Classes\Common;
use App\Models\Product;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use Maatwebsite\Excel\Concerns\WithColumnFormatting;
use Maatwebsite\Excel\Concerns\WithStrictNullComparison;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;

class StockListingExport implements FromArray, WithHeadings, WithStyles, WithColumnFormatting, WithStrictNullComparison
{

    public function headings(): array
    {
        return [
            'warehouse_code',
            'item_id',
            'item_code',
            'name',
            'brand_code',
            'category_name',
            'description',
            'stock_quantitiy_alert',
            'opening_stock',
            'opening_stock_date',
            'purchase_price',
            'current_stock'
        ];
    }

    public function styles(Worksheet $sheet)
    {
        return [
            1 => ['font' => ['bold' => true]]
        ];
    }

    public function columnFormats(): array
    {
        $RupiahFormat = '"Rp"#,##0';
        return [
            'H' => NumberFormat::FORMAT_TEXT,
            'L' => NumberFormat::FORMAT_NUMBER,
        ];
    }

    public function array(): array
    {
        $request = request();

        $query = Product::leftJoin('brands', 'brands.id', '=', 'products.brand_id')
            ->leftJoin('categories', 'categories.id', '=', 'products.category_id')
            ->join('product_details', 'product_details.product_id', '=', 'products.id')
            ->join('warehouses', 'warehouses.id', '=', 'product_details.warehouse_id')
            ->whereNull('products.parent_id')
            ->where('products.product_type', 'single')
            ->where('product_details.current_stock', '>', 0)
            ->select('warehouses.code','products.id', 'products.item_id','products.item_code', 'products.name', DB::raw('brands.code as brand_code'), DB::raw('categories.name as category_name'),
                'products.description', 'product_details.stock_quantitiy_alert', 'product_details.opening_stock','product_details.opening_stock_date',
                'product_details.purchase_price',
                'product_details.current_stock')
            ->orderBy('products.name', 'asc')
            ->orderBy('product_details.product_id', 'asc');

        if ($request->has('searchTerm') && $request->searchTerm != null && $request->searchTerm != "" && $request->searchTerm != "undefined") {
            $searchTerm = $request->searchTerm;
            $query = $query->where(
                function ($query) use ($searchTerm) {
                    $query->where('products.name', 'LIKE', "%$searchTerm%")
                        ->orWhere('products.item_code', trim($searchTerm))
                        ->orWhere('products.item_id', trim($searchTerm))
                        ->orWhere('products.parent_item_code', trim($searchTerm));
                }
            );
        }

         if ($request->has('warehouse_id') && $request->warehouse_id != null && $request->warehouse_id != "" && $request->warehouse_id != "undefined") {
            $query = $query->where('product_details.warehouse_id', Common::getIdFromHash($request->warehouse_id));
        }

        if ($request->has('brand_id') && $request->brand_id != null && $request->brand_id != "" && $request->brand_id != "undefined") {
            $query = $query->where('brands.id', Common::getIdFromHash($request->brand_id));
        }

        if ($request->has('category_id') && $request->category_id != null && $request->category_id != "" && $request->category_id != "undefined") {
            $query = $query->where('categories.id', Common::getIdFromHash($request->category_id));
        }


        $results = [];
       if ($request->has('stock_listing_date') && $request->stock_listing_date != null && $request->stock_listing_date != "" && $request->stock_listing_date != "undefined") {
            $parsedDate = explode(' ', $request->stock_listing_date);
            $products = $query->get();

            foreach ($products as $product) {
                $item = Common::getProductStockChanges(Common::getIdFromHash($request->warehouse_id), $product->id, null, $parsedDate[0]);
                if ($item['calculated_stock'] > 0) {
                    $product->current_stock = $item['calculated_stock'];
                    $results[] = $product;
                }
            }            
        } else {
            $results = $query->get()->makeHidden(['xid', 'image_url'])->toArray();
        }

        return $results;
                
    }
}
