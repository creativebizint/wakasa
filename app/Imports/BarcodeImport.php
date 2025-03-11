<?php

namespace App\Imports;

use App\Models\Barcode;
use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\ToArray;
use Illuminate\Support\Str;

class BarcodeImport implements ToArray, WithHeadingRow
{
	public function array(array $barcode)
	{
		DB::transaction(function () use ($barcode) {

			foreach ($barcode as $barcode_detail) {

				if (
					!array_key_exists('string', $barcode_detail)
				) {
					throw new ApiException('Field missing from header.');
				}

				$string = trim($barcode_detail['string']);
				$barcodeCount = Barcode::where('string', $string)->count();
				if ($barcodeCount > 0) {
					throw new ApiException('String ' . $string . ' Already Exists');
				}

				$newBarcode = new Barcode();
				$newBarcode->string = $string;
				$newBarcode->isactive = 0;
				$newBarcode->save();
			}
		});
	}
}
