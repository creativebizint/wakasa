<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Brand\IndexRequest;
use App\Http\Requests\Api\Brand\StoreRequest;
use App\Http\Requests\Api\Brand\UpdateRequest;
use App\Http\Requests\Api\Brand\DeleteRequest;
use App\Http\Requests\Api\Brand\ImportRequest;
use App\Imports\BrandImport;
use App\Exports\BrandExport;
use App\Models\Brand;
use Examyou\RestAPI\ApiResponse;
use Maatwebsite\Excel\Facades\Excel;
use DB;

class TestController extends ApiBaseController
{
    public function connectSqlServer(){
        $result = DB::connection('sqlsrv')->select(
            "EXEC Sales.ViewSalesOrderDocPickingDetailReport @SalesOrderNo = 'SO24121290'"
        );
        dd($result);
    }
}
