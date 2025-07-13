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
use App\Models\PlacementItem;
use App\Models\ProductPlacementShelfGroup;
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
      $floor_used = PlacementItem::join('product_placement_row','product_placement_row.id','=','placement_items.row')
                                ->join('product_placement_shelf_number','product_placement_shelf_number.id','product_placement_row.product_placement_shelf_number_id')
                                ->join('product_placement_shelf_group','product_placement_shelf_group.id','product_placement_shelf_number.product_placement_shelf_group_id')
                                ->join('product_placement_floor','product_placement_floor.id','product_placement_shelf_group.product_placement_floor_id')
                                ->where('product_placement_floor.id','=',$product_placement_floor->id )->count();
      if ($floor_used > 0) {
          throw new ApiException('Lantai telah digunakan dan tidak bisa diubah');
      }

          return $product_placement_floor;
    }
    
    public function destroying(ProductPlacementFloor $product_placement_floor)
    {
      $floor_used = PlacementItem::join('product_placement_row','product_placement_row.id','=','placement_items.row')
                                ->join('product_placement_shelf_number','product_placement_shelf_number.id','product_placement_row.product_placement_shelf_number_id')
                                ->join('product_placement_shelf_group','product_placement_shelf_group.id','product_placement_shelf_number.product_placement_shelf_group_id')
                                ->join('product_placement_floor','product_placement_floor.id','product_placement_shelf_group.product_placement_floor_id')
                                ->where('product_placement_floor.id','=',$product_placement_floor->id )->count();
      if ($floor_used > 0) {
          throw new ApiException('Lantai telah digunakan dan tidak bisa dihapus');
      }

          return $product_placement_floor;
    }
      
}
