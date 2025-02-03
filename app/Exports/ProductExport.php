<?php

namespace App\Exports;

use App\Models\Product;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use Maatwebsite\Excel\Concerns\WithColumnFormatting;
use Maatwebsite\Excel\Concerns\WithStrictNullComparison;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;

class ProductExport implements FromCollection, WithHeadings, WithStyles, WithColumnFormatting, WithStrictNullComparison
{

    public function headings(): array
    {
        return [
            'item_id',
            'item_code',
            'barcode_symbology',
            'name',
            'type',          
            'brand_code',
            'category_code',
            'part_code',
            'description',
            'stock_quantitiy_alert',
            'opening_stock',
            'opening_stock_date',
            'purchase_price',
            'sales_price',
            'priority',
            'supplier_code',
            'variant_code',
            'subgroup1',
            'subgroup2',
            'subgroup3',
            'subgroup4',
            'subgroup5',
            'subgroup6',
            'subgroup7',
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
        return [];
    }

    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        return Product::join('product_details', 'product_details.product_id', '=', 'products.id')
            ->leftJoin('brands', 'brands.id', '=', 'products.brand_id')
            ->leftJoin('categories', 'categories.id', '=', 'products.category_id')
            ->leftJoin('parts', 'parts.id', '=', 'products.part_id')
            ->leftJoin('users as S', 'S.id', '=', 'products.supplier_id')
            ->leftJoin('users as V', 'V.id', '=', 'products.variant_id')
            ->where('product_details.warehouse_id', '=', 1)
            ->select('products.item_id',
                'products.item_code', 
                'products.barcode_symbology', 
                'products.name',
                'products.type',
                'brands.code',
                'categories.category_id name as category_code',
                'parts.code as part_code',
                'products.description',
                'product_details.stock_quantitiy_alert',
                'product_details.opening_stock',
                'product_details.opening_stock_date',
                'product_details.purchase_price',                
                'product_details.sales_price',                
                'products.priority',                 
                'S.code as supplier_code',
                'V.code as variant_code',
                'products.subgroup1',
                'products.subgroup2',
                'products.subgroup3',
                'products.subgroup4',
                'products.subgroup5',
                'products.subgroup6',
                'products.subgroup7',
                  )
            ->get()
            ->makeHidden(['xid', 'x_category_id', 'x_brand_id', 'x_group_id', 'x_color_id', 'x_unit_id', 'x_user_id', 'x_warehouse_id', 'x_variant_id', 'x_variant_value_id', 'x_parent_id', 'image_url']);
    }
}
