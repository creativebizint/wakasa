<?php

namespace App\Exports;

use App\Models\Customer;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class CustomerExport implements FromCollection, WithHeadings, WithStyles
{

    public function headings(): array
    {
        return [
            'code',
            'name',
            'email',
            'phone',
            'address',
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
        return Customer::select('code', 'name', 'email', 'phone', 'address')
            ->where('user_type','customers')    
            ->get()
            ->makeHidden(['xid', 'profile_image_url']);
    }
}
