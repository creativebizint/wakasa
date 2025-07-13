<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Row\IndexRequest;
use App\Http\Requests\Api\Row\StoreRequest;
use App\Http\Requests\Api\Row\UpdateRequest;
use App\Http\Requests\Api\Row\DeleteRequest;
use App\Http\Requests\Api\Row\ImportRequest;
use App\Imports\RowImport;
use App\Exports\RowExport;
use App\Models\ProductPlacementRow;
use App\Models\PlacementItem;
use Examyou\RestAPI\ApiResponse;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Cache;
use Examyou\RestAPI\Exceptions\ApiException;

class RowController extends ApiBaseController
{
  protected $model = ProductPlacementRow::class;

  protected $indexRequest = IndexRequest::class;
  protected $storeRequest = StoreRequest::class;
  protected $updateRequest = UpdateRequest::class;
  protected $deleteRequest = DeleteRequest::class;

  public function import(ImportRequest $request)
  {
        if ($request->hasFile('file')) {
              Cache::forget('import-current-row');
              Excel::import(new RowImport, request()->file('file'));
        }

        return ApiResponse::make('Imported Successfully', []);
  }
  
  public function storing(ProductPlacementRow $product_placement_row)
  {
        $request = request();
        $product_placement_row->product_placement_shelf_number_id = $this->getIdFromHash($request->product_placement_shelf_number_id);

        return $product_placement_row;
  }

  public function updating(ProductPlacementRow $product_placement_row)
  {
      $request = request();
      $row_used = PlacementItem::where('row', $product_placement_row->id)->count();
      
      if ($row_used > 0) {
          throw new ApiException('Baris Rak telah digunakan dan tidak bisa diubah');
      }
      $product_placement_row->product_placement_shelf_number_id = $this->getIdFromHash($request->product_placement_shelf_number_id);

      return $product_placement_row;
  }

  public function export()
  {
        return Excel::download(new RowExport, 'rows.xlsx');
  }
  
  public function destroying(ProductPlacementRow $product_placement_row)
  {
    $row_used = PlacementItem::where('row', $product_placement_row->id)->count();
    if ($row_used > 0) {
        throw new ApiException('Baris Rak telah digunakan dan tidak bisa dihapus');
    }

        return $product_placement_row;
  }
}
