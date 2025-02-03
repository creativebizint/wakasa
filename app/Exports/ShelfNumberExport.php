<?php

namespace App\Exports;

use App\Models\ProductPlacementShelfNumber;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class ShelfNumberExport implements FromCollection, WithHeadings, WithStyles
{

    public function headings(): array
    {
        return [
            'id',
            'value',
            'product_placement_shelf_group_id'
        ];
    }

    public function styles(Worksheet $sheet)
    {
        return [
            1 => ['font' => ['bold' => true]]
        ];
    }

    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        return ProductPlacementShelfNumber::select('id', 'value','product_placement_shelf_group_id')
            ->get()->makeHidden(['xid','x_product_placement_shelf_group_id']);
    }
}
