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
use Session;

class SessionController extends ApiBaseController
{
    public function index()
    {
      dd(Session::get(null));
    }
      
}
