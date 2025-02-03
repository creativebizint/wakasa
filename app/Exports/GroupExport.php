<?php

namespace App\Exports;

use App\Models\Group;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class GroupExport implements FromCollection, WithHeadings, WithStyles
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
        return Group::join('brands', 'brands.id', '=', 'groups.brand_id')
            ->select('groups.code', 'groups.name', DB::raw('brands.code as brand_code'))
            ->get()
            ->makeHidden(['xid', 'image_url', 'x_brand_id']);
    }
}
