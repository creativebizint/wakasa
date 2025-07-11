<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\ShelfGroup\IndexRequest;
use App\Http\Requests\Api\ShelfGroup\StoreRequest;
use App\Http\Requests\Api\ShelfGroup\UpdateRequest;
use App\Http\Requests\Api\ShelfGroup\DeleteRequest;
use App\Http\Requests\Api\ShelfGroup\ImportRequest;
use App\Imports\ShelfGroupImport;
use App\Exports\ShelfGroupExport;
use App\Models\ProductPlacementShelfGroup;
use App\Models\PlacementItem;
use Examyou\RestAPI\ApiResponse;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Cache;
use Examyou\RestAPI\Exceptions\ApiException;

class ShelfGroupController extends ApiBaseController
{
	protected $model = ProductPlacementShelfGroup::class;

	protected $indexRequest = IndexRequest::class;
	protected $storeRequest = StoreRequest::class;
	protected $updateRequest = UpdateRequest::class;
	protected $deleteRequest = DeleteRequest::class;

	public function import(ImportRequest $request)
	{
		if ($request->hasFile('file')) {
			Cache::forget('import-current-row');
			Excel::import(new ShelfGroupImport, request()->file('file'));
		}

		return ApiResponse::make('Imported Successfully', []);
	}

	public function export()
    {
		return Excel::download(new ShelfGroupExport, 'shelf-group.xlsx');
    }
    
    public function storing(ProductPlacementShelfGroup $product_placement_shelf_group)
	{
		$request = request();
		$product_placement_shelf_group->product_placement_floor_id = $this->getIdFromHash($request->product_placement_floor_id);
		
		return $product_placement_shelf_group;
	}
      
      public function updating(ProductPlacementShelfGroup $product_placement_shelf_group)
	{
		$request = request();
            $shelf_group_used = PlacementItem::join('product_placement_row','product_placement_row.id','=','placement_items.row')
                                ->join('product_placement_shelf_number','product_placement_shelf_number.id','product_placement_row.product_placement_shelf_number_id')
                                ->join('product_placement_shelf_group','product_placement_shelf_group.id','product_placement_shelf_number.product_placement_shelf_group_id')
                                ->where('product_placement_shelf_group.id','=',$product_placement_shelf_group->id )->count();
            if ($shelf_group_used > 0) {
                throw new ApiException('Lorong telah terpakai dan tidak bisa diedit');
            }
		$product_placement_shelf_group->product_placement_floor_id = $this->getIdFromHash($request->product_placement_floor_id);
		
		return $product_placement_shelf_group;
	}
      
      public function destroying(ProductPlacementShelfGroup $product_placement_shelf_group)
      {
        $shelf_group_used = PlacementItem::join('product_placement_row','product_placement_row.id','=','placement_items.row')
                                ->join('product_placement_shelf_number','product_placement_shelf_number.id','product_placement_row.product_placement_shelf_number_id')
                                ->join('product_placement_shelf_group','product_placement_shelf_group.id','product_placement_shelf_number.product_placement_shelf_group_id')
                                ->where('product_placement_shelf_group.id','=',$product_placement_shelf_group->id )->count();
        if ($shelf_group_used > 0) {
            throw new ApiException('Lorong telah terpakai dan tidak bisa diedit');
        }

            return $product_placement_shelf_group;
      }
      
}
