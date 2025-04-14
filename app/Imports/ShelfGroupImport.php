<?php

namespace App\Imports;

use App\Models\ProductPlacementFloor;
use App\Models\ProductPlacementShelfGroup;
use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\ToArray;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Support\Str;

class ShelfGroupImport implements ToArray, WithHeadingRow, WithChunkReading, ShouldQueue
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

	public function array(array $shelf_groups)
	{

		DB::transaction(function () use ($shelf_groups) {
            $errMessage = "";

                  $line = 2;
			foreach ($shelf_groups as $shelf_group) {
                    $value = trim($shelf_group['value']);
                    $floor = trim($shelf_group['floor']);
                    if($value != '' && $floor !=''){
                      $floor_detail = ProductPlacementFloor::where('value', $floor)->first();
                      if ($floor_detail == null) {
                        $errMessage = "[row ". $line ."]: can't find floor";
                        Cache::put($this->cacheKey, $errMessage);
                        return;
                      }

                      $data_ = new ProductPlacementShelfGroup();
                      $data_->value = $value;
                      $data_->product_placement_floor_id = $floor_detail->id;
                      $data_->save();
                      
                    }
                    else{
                      $errMessage = '[row '. $line .']: value or floor is empty';
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
