<?php

namespace App\Exports;

use App\Models\ProductPlacementFloor;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class FloorExport implements FromCollection, WithHeadings, WithStyles
{

    public function headings(): array
    {
        return [
            'id',
            'value',
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
        return ProductPlacementFloor::select('id', 'value')
            ->get()->makeHidden(['xid']);
    }
}
