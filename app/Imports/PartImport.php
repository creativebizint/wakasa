<?php

namespace App\Imports;

use App\Models\Part;
use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\ToArray;
use Illuminate\Support\Str;

class PartImport implements ToArray, WithHeadingRow
{
	public function array(array $parts)
	{
		DB::transaction(function () use ($parts) {

			foreach ($parts as $part) {

				if (
					!array_key_exists('name', $part)
				) {
					throw new ApiException('Field missing from header.');
				}

				$partName = trim($part['name']);
				$partCode = trim($part['code']);
				$partDescription = trim($part['description']);
				$partDescription2 = trim($part['description2']);
				$partType = trim($part['type']);
				$partCount = Part::where('code','=', $partCode)->count();
                                if ($partCount > 0) {
					throw new ApiException('Part ' . $partName . ' Already Exists');
				}

				$newParts = new Part();
				$newParts->name = $partName;
				$newParts->code = $partCode;
				$newParts->description = $partDescription; 
				$newParts->description2 = $partDescription2;
				$newParts->type = $partType;
				$newParts->slug = Str::slug($partName, '-');
				$newParts->save();
			}
		});
	}
}
