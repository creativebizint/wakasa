<?php

namespace App\Imports;

use App\Models\ProductPlacementShelfGroup;
use App\Models\ProductPlacementShelfNumber;
use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\ToArray;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Support\Str;

class ShelfNumberImport implements ToArray, WithHeadingRow, WithChunkReading, ShouldQueue
{
    protected $cacheKey;
    protected $userId;

    public function __construct($cacheKey, $userId)
    {
        $this->cacheKey = $cacheKey;
        $this->userId = $userId;
    }
    
    public function chunkSize(): int
    {
        return 100;
    }

	public function array(array $rows)
	{

		DB::transaction(function () use ($rows) {
            $errMessage = "";
                  $line = 2;
			foreach ($rows as $row) {
                    $value = trim($row['value']);
                    $shelf_group = trim($row['shelf_group']);
                    if($value != '' && $shelf_group !=''){
                      $shelf_group_detail = ProductPlacementShelfGroup::where('value', $shelf_group)->first();
                      if ($shelf_group_detail == null) {
                        $errMessage = "[row ". $line ."]: can't find shelf group";
                        Cache::put($this->cacheKey, $errMessage);
                        return;
                      }

                      $data_ = new ProductPlacementShelfNumber();
                      $data_->value = $value;
                      $data_->product_placement_shelf_group_id = $shelf_group_detail->id;
                      $data_->save();
                      
                    }
                    else{
                      $errMessage = "[row ". $line ."]: value or Shelf Group is empty";
                      Cache::put($this->cacheKey, $errMessage);
                      return;
                    }
                    $line++;
                    
                  }
                  // Forget cache
			Cache::forget($this->cacheKey);
		});
	}
}
