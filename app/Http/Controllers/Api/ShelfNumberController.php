<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\ShelfNumber\IndexRequest;
use App\Http\Requests\Api\ShelfNumber\StoreRequest;
use App\Http\Requests\Api\ShelfNumber\UpdateRequest;
use App\Http\Requests\Api\ShelfNumber\DeleteRequest;
use App\Http\Requests\Api\ShelfNumber\ImportRequest;
use App\Imports\ShelfNumberImport;
use App\Exports\ShelfNumberExport;
use App\Models\ProductPlacementShelfNumber;
use App\Models\Placement;
use \App\Models\PlacementItem;
use Examyou\RestAPI\ApiResponse;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Cache;
use Examyou\RestAPI\Exceptions\ApiException;

class ShelfNumberController extends ApiBaseController
{
	protected $model = ProductPlacementShelfNumber::class;

	protected $indexRequest = IndexRequest::class;
	protected $storeRequest = StoreRequest::class;
	protected $updateRequest = UpdateRequest::class;
	protected $deleteRequest = DeleteRequest::class;

      protected function modifyIndex($query)
      {
        
          $query = $query->join('product_placement_shelf_group', 'product_placement_shelf_number.product_placement_shelf_group_id', '=', 'product_placement_shelf_group.id')
                    ->join('product_placement_floor', 'product_placement_floor.id', '=', 'product_placement_shelf_group.product_placement_floor_id')
                    ->select('product_placement_floor.value as floor_name');
          return $query;
      }
    
	public function import(ImportRequest $request)
	{
		if ($request->hasFile('file')) {
			Cache::forget('import-current-row');
			Excel::import(new ShelfNumberImport, request()->file('file'));
		}

		return ApiResponse::make('Imported Successfully', []);
	}

      public function storing(ProductPlacementShelfNumber $product_placement_shelf_number)
	{
		$request = request();
		$product_placement_shelf_number->product_placement_shelf_group_id = $this->getIdFromHash($request->product_placement_shelf_group_id);
		
		return $product_placement_shelf_number;
	}
      
      public function updating(ProductPlacementShelfNumber $product_placement_shelf_number)
	{
		$request = request();
                $shelf_number_used = PlacementItem::join('product_placement_row','product_placement_row.id','=','placement_items.row')
                                ->join('product_placement_shelf_number','product_placement_shelf_number.id','product_placement_row.product_placement_shelf_number_id')
                                ->where('product_placement_shelf_number.id','=',$product_placement_shelf_number->id )->count();
            if ($shelf_number_used > 0) {
                throw new ApiException('Nomer Rak telah digunakan dan tidak bisa diubah');
            }
            $product_placement_shelf_number->product_placement_shelf_group_id = $this->getIdFromHash($request->product_placement_shelf_group_id);
		
		return $product_placement_shelf_number;
	}
      
	public function export()
    {
		return Excel::download(new ShelfNumberExport, 'shelf-numbers.xlsx');
    }
    
    public function destroying(ProductPlacementShelfNumber $product_placement_shelf_number)
      {
        $shelf_number_used = PlacementItem::join('product_placement_row','product_placement_row.id','=','placement_items.row')
                                ->join('product_placement_shelf_number','product_placement_shelf_number.id','product_placement_row.product_placement_shelf_number_id')
                                ->where('product_placement_shelf_number.id','=',$product_placement_shelf_number->id )->count();
        if ($shelf_number_used > 0) {
            throw new ApiException('Nomer Rak telah digunakan dan tidak bisa dihapus');
        }

            return $product_placement_shelf_number;
      }
}
