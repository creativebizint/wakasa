<?php

namespace App\Exports;

use App\Models\Part;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class PartExport implements FromCollection, WithHeadings, WithStyles
{

    public function headings(): array
    {
        return [
            'code',
            'name',
            'description',
            'description2',
            'type',
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
        return Part::select('code', 'name','description','description2','type')
            ->get()
            ->makeHidden(['xid', 'image_url']);
    }
}
