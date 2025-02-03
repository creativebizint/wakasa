<?php

namespace App\Exports;

use App\Models\ProductPlacementShelfGroup;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class ShelfGroupExport implements FromCollection, WithHeadings, WithStyles
{

    public function headings(): array
    {
        return [
            'id',
            'value',
            'product_placement_floor_id'
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
        return ProductPlacementShelfGroup::select('id', 'value','product_placement_floor_id')
            ->get()->makeHidden(['xid','x_product_placement_floor_id']);
    }
}
