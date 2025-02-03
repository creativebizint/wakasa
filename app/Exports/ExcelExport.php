<?php
namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithTitle;

class ExcelExport implements FromArray, WithHeadings, ShouldAutoSize, WithTitle
{
    private $setData;
    private $setHeadings;
    private $setSheetTitle;

    public function __construct($data = [], $headings = [], $title = null)
    {
        $this->setData = $data;
        $this->setHeadings = $headings;
        $this->setSheetTitle = $title;
    }

    public function array(): array
    {
        return $this->setData;
    }

    public function headings(): array
    {
        return $this->setHeadings;
    }

    public function title(): string
    {
        return is_null($this->setSheetTitle) ? 'Main' : $this->setSheetTitle;
    }
}