<?php

namespace App\Exports;

use App\Models\Color;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class ColorExport implements FromCollection, WithHeadings, WithStyles
{

    public function headings(): array
    {
        return [
            'code',
            'name',
            'brand_code'
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
        return Color::join('brands', 'brands.id', '=', 'colors.brand_id')
            ->select('colors.code', 'colors.name', DB::raw('brands.code as brand_code'))
            ->get()
            ->makeHidden(['xid', 'image_url', 'x_brand_id']);
    }
}
