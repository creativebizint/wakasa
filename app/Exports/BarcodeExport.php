<?php

namespace App\Exports;

use App\Models\Barcode;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class BarcodeExport implements FromCollection, WithHeadings, WithStyles
{

    public function headings(): array
    {
        return [
            'string',
            'isactive',
            'No BB',
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
        return Barcode::select('string','isactive','orders.invoice_number')
            ->leftJoin('order_items','barcode.order_item_id','=','order_items.id')
            ->leftJoin('orders','orders.id','=','order_items.order_id')
            ->get()
            ->makeHidden(['xid']);
    }
}
