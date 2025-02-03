<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Part\IndexRequest;
use App\Http\Requests\Api\Part\StoreRequest;
use App\Http\Requests\Api\Part\UpdateRequest;
use App\Http\Requests\Api\Part\DeleteRequest;
use App\Http\Requests\Api\Part\ImportRequest;
use App\Imports\PartImport;
use App\Exports\PartExport;
use App\Models\Part;
use Examyou\RestAPI\ApiResponse;
use Maatwebsite\Excel\Facades\Excel;

class partController extends ApiBaseController
{
	protected $model = Part::class;

	protected $indexRequest = IndexRequest::class;
	protected $storeRequest = StoreRequest::class;
	protected $updateRequest = UpdateRequest::class;
	protected $deleteRequest = DeleteRequest::class;

	public function import(ImportRequest $request)
	{
		if ($request->hasFile('file')) {
			Excel::import(new PartImport, request()->file('file'));
		}

		return ApiResponse::make('Imported Successfully', []);
	}
        public function export()
        {
                    return Excel::download(new PartExport, 'parts.xlsx');
        }
}
