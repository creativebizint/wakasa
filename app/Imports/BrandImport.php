<?php

namespace App\Imports;

use App\Models\Brand;
use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\ToArray;
use Illuminate\Support\Str;

class BrandImport implements ToArray, WithHeadingRow
{
	public function array(array $brands)
	{
		DB::transaction(function () use ($brands) {

			foreach ($brands as $brand) {

				if (
					!array_key_exists('name', $brand)
				) {
					throw new ApiException('Field missing from header.');
				}

				$brandName = trim($brand['name']);
				$brandCode = trim($brand['code']);
				$brandDescription = trim($brand['description']);
				$brandDescription2 = trim($brand['description2']);
				$brandType = trim($brand['type']);
				$brandCount = Brand::where('code', $brandCode)->count();
				if ($brandCount > 0) {
					throw new ApiException('Brand ' . $brandName . ' Already Exists');
				}

				$newBrand = new Brand();
				$newBrand->name = $brandName;
				$newBrand->code = $brandCode;
				$newBrand->description = $brandDescription;
				$newBrand->description2 = $brandDescription2;
				$newBrand->type = $brandType;
				$newBrand->slug = Str::slug($brandName, '-');
				$newBrand->save();
			}
		});
	}
}
