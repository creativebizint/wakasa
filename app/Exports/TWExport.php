<?php
namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithTitle;
use Maatwebsite\Excel\Concerns\WithStyles;
use Maatwebsite\Excel\Concerns\WithStrictNullComparison;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;


class TWExport implements FromArray, WithHeadings, ShouldAutoSize, WithTitle, WithStyles, WithStrictNullComparison
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
    
    public function styles(Worksheet $sheet)
    {
        foreach ($sheet->getRowIterator() as $row) {
            $cellCoordinate = 'B'.$row->getRowIndex();
            $cellValue = $sheet->getCell($cellCoordinate)->getValue();
            $highestColumn = $sheet->getHighestColumn();
            
            // Example condition: set background if cell value is 'Admin'
            if (strpos($cellValue, 'Total Category') !== false) {
                $sheet->getStyle($cellCoordinate.':'.$highestColumn.$row->getRowIndex())->applyFromArray([
                    'font' => [
                        'bold' => true,
                        'color' => ['argb' => 'FF0000'], 
                    ],
                ]);
            }
            
            if (strpos($cellValue, 'Total Sub') !== false) {
                $sheet->getStyle($cellCoordinate.':'.$highestColumn.$row->getRowIndex())->applyFromArray([
                    'font' => [
                        'bold' => true,
                        'color' => ['argb' => '6f60bd'], 
                    ],
                ]);
            }
        }
        
        
        $highestColumn = $sheet->getHighestColumn();
        $highestColumnIndex = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::columnIndexFromString($highestColumn);

        $columnLetter = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex('39');
        $sheet->getStyle($columnLetter . '1:' . $columnLetter . $sheet->getHighestRow())
            ->applyFromArray([
                'fill' => [
                    'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                    'color' => ['argb' => 'e5c3c6'], // Grey
                ]
            ]);
        
        $columnLetter = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex('42');
        $sheet->getStyle($columnLetter . '1:' . $columnLetter . $sheet->getHighestRow())
            ->applyFromArray([
                'fill' => [
                    'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                    'color' => ['argb' => 'ff77aa'], // Pink
                ]
            ]);
        
        $columnLetter = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex('43');
        $sheet->getStyle($columnLetter . '1:' . $columnLetter . $sheet->getHighestRow())
            ->applyFromArray([
                'fill' => [
                    'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                    'color' => ['argb' => 'c9c9ff'], // blue
                ]
            ]);
        
        $columnLetter = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex('44');
        $sheet->getStyle($columnLetter . '1:' . $columnLetter . $sheet->getHighestRow())
            ->applyFromArray([
                'fill' => [
                    'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                    'color' => ['argb' => 'b2ec5d'], // green
                ]
            ]);
        
        $columnLetter = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex('48');
        $sheet->getStyle($columnLetter . '1:' . $columnLetter . $sheet->getHighestRow())
            ->applyFromArray([
                'fill' => [
                    'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                    'color' => ['argb' => 'bae1ff'], // blue
                ]
            ]);
        
        
        for ($column = 54; $column <= $highestColumnIndex; $column++) {
            if (($column-54) % 11 == 0) { // Apply style to every 5th column
                $columnLetter = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($column);
                $sheet->getStyle($columnLetter . '1:' . $columnLetter . $sheet->getHighestRow())
                    ->applyFromArray([
                        'fill' => [
                            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                            'color' => ['argb' => 'ffe135'], //green
                        ]
                    ]);
                
            }
        }
        for ($column = 55; $column <= $highestColumnIndex; $column++) {
            if (($column-55) % 11 == 0) { // Apply style to every 5th column
                $columnLetter = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($column);
                $sheet->getStyle($columnLetter . '1:' . $columnLetter . $sheet->getHighestRow())
                    ->applyFromArray([
                        'fill' => [
                            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                            'color' => ['argb' => 'b2ec5d'], //green
                        ]
                    ]);
                
            }
        }
        
        for ($column = 57; $column <= $highestColumnIndex; $column++) {
            if (($column-57) % 11 == 0) { // Apply style to every 5th column
                $columnLetter = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($column);
                $sheet->getStyle($columnLetter . '1:' . $columnLetter . $sheet->getHighestRow())
                    ->applyFromArray([
                        'fill' => [
                            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                            'color' => ['argb' => '87cefa'], //blue
                        ]
                    ]);
                
            }
        }
        
        for ($column = 62; $column <= $highestColumnIndex; $column++) {
            if (($column-62) % 11 == 0) { // Apply style to every 5th column
                $columnLetter = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($column);
                $sheet->getStyle($columnLetter . '1:' . $columnLetter . $sheet->getHighestRow())
                    ->applyFromArray([
                        'fill' => [
                            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                            'color' => ['argb' => 'ffa500'], //blue
                        ]
                    ]);
                
            }
        }
        
        for ($column = 63; $column <= $highestColumnIndex; $column++) {
            if (($column-63) % 11 == 0) { // Apply style to every 5th column
                $columnLetter = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($column);
                $sheet->getStyle($columnLetter . '1:' . $columnLetter . $sheet->getHighestRow())
                    ->applyFromArray([
                        'fill' => [
                            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                            'color' => ['argb' => '000000'], //black
                        ]
                    ]);
                
            }
        }
        return $sheet;
    }
    
}