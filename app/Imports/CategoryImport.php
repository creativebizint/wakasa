<?php

namespace App\Imports;

use App\Models\Category;
use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\ToArray;
use Illuminate\Support\Str;

class CategoryImport implements ToArray, WithHeadingRow
{
	public function array(array $categories)
	{
		DB::transaction(function () use ($categories) {
			foreach ($categories as $category) {

				if (
					!array_key_exists('name', $category)
				) {
					throw new ApiException('Field missing from header.');
				}

				$categoryName = trim($category['name']);
				$category_id = trim($category['category_id']);
                                
                                //file_put_contents(storage_path('logs') . '/category.log', "[" . date('Y-m-d H:i:s') . "]name : \n" . print_r($categoryName,1) . "\n\n", FILE_APPEND);
				$categoryCount = Category::where('name', $categoryName)->count();
				if ($categoryCount > 0) {
					throw new ApiException('Category ' . $categoryName . ' Already Exists');
				}

				$newCategory = new Category();
				$newCategory->name = $categoryName;
				$newCategory->slug = Str::slug($categoryName, '-');
				$newCategory->parent_id = null;
				$newCategory->category_id = $category_id;
				$newCategory->save();
			}
		});
	}
}
