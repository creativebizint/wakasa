<?php

namespace App\Imports;

use App\Models\ProductPlacementFloor;
use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\ToArray;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Support\Str;

class FloorImport implements ToArray, WithHeadingRow, WithChunkReading, ShouldQueue
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

	public function array(array $floors)
	{

		DB::transaction(function () use ($floors) {
            $errMessage = "";

			foreach ($floors as $floor) {
                    $value = trim($floor['value']);
                    if($value != ''){
                      $data = new ProductPlacementFloor();
                      $data->value = $value;
                      $data->save();
                    }
                  }
		});
	}
}
