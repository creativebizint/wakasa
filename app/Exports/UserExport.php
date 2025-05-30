<?php

namespace App\Exports;

use App\Models\User;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class UserExport implements FromCollection, WithHeadings, WithStyles
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
        return User::select('code', 'name', 'email', 'phone', 'address')
            ->where('user_type','staff_members')    
            ->get()
            ->makeHidden(['xid','profile_image_url']);
    }
}
