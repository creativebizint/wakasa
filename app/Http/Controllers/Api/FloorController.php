<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Floor\IndexRequest;
use App\Http\Requests\Api\Floor\StoreRequest;
use App\Http\Requests\Api\Floor\UpdateRequest;
use App\Http\Requests\Api\Floor\DeleteRequest;
use App\Http\Requests\Api\Floor\ImportRequest;
use App\Imports\FloorImport;
use App\Exports\FloorExport;
use App\Models\ProductPlacementFloor;
use Examyou\RestAPI\ApiResponse;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Cache;
use App\Models\ProductPlacement;
use Examyou\RestAPI\Exceptions\ApiException;

class FloorController extends ApiBaseController
{
	protected $model = ProductPlacementFloor::class;

	protected $indexRequest = IndexRequest::class;
	protected $storeRequest = StoreRequest::class;
	protected $updateRequest = UpdateRequest::class;
	protected $deleteRequest = DeleteRequest::class;

	public function import(ImportRequest $request)
	{
		if ($request->hasFile('file')) {
			Cache::forget('import-current-row');
			Excel::import(new FloorImport, request()->file('file'));
		}

		return ApiResponse::make('Imported Successfully', []);
	}

	public function export()
    {
		return Excel::download(new FloorExport, 'floors.xlsx');
    }
    
    public function updating(ProductPlacementFloor $product_placement_floor)
    {
      $floor_used = ProductPlacement::where('floor', $product_placement_floor->id)->count();
      if ($floor_used > 0) {
          throw new ApiException('Floor already have placement cannot be updated');
      }

          return $product_placement_floor;
    }
    
    public function destroying(ProductPlacementFloor $product_placement_floor)
    {
      $floor_used = ProductPlacement::where('floor', $product_placement_floor->id)->count();
      if ($floor_used > 0) {
          throw new ApiException('Floor already have placement cannot be deleted');
      }

          return $product_placement_floor;
    }
      
}
