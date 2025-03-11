<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Barcode\IndexRequest;
use App\Http\Requests\Api\Barcode\StoreRequest;
use App\Http\Requests\Api\Barcode\UpdateRequest;
use App\Http\Requests\Api\Barcode\DeleteRequest;
use App\Http\Requests\Api\Barcode\ImportRequest;
use App\Imports\BarcodeImport;
use App\Exports\BarcodeExport;
use App\Models\Barcode;
use Examyou\RestAPI\ApiResponse;
use Maatwebsite\Excel\Facades\Excel;

class BarcodeController extends ApiBaseController
{
	protected $model = Barcode::class;

	protected $indexRequest = IndexRequest::class;
	protected $storeRequest = StoreRequest::class;
	protected $updateRequest = UpdateRequest::class;
	protected $deleteRequest = DeleteRequest::class;

	public function import(ImportRequest $request)
	{
		if ($request->hasFile('file')) {
			Excel::import(new BarcodeImport, request()->file('file'));
		}

		return ApiResponse::make('Imported Successfully', []);
	}
        public function export()
        {
                    return Excel::download(new BarcodeExport, 'barcode.xlsx');
        }
        
        public function storing(Barcode $barcode)
	{
		$barcode->isactive=0;

		return $barcode;
	}
        
}
