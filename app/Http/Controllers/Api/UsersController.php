<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\User\IndexRequest;
use App\Http\Requests\Api\User\StoreRequest;
use App\Http\Requests\Api\User\UpdateRequest;
use App\Http\Requests\Api\User\DeleteRequest;
use App\Models\User;
use App\Traits\UserTraits;
use Examyou\RestAPI\ApiResponse;
use Examyou\RestAPI\Exceptions\ApiException;
use Examyou\RestAPI\Exceptions\ResourceNotFoundException;
use App\Exports\UserExport;
use Maatwebsite\Excel\Facades\Excel;

class UsersController extends ApiBaseController
{
	use UserTraits;

	protected $model = User::class;

	protected $indexRequest = IndexRequest::class;
	protected $storeRequest = StoreRequest::class;
	protected $updateRequest = UpdateRequest::class;
	protected $deleteRequest = DeleteRequest::class;

	public function __construct()
	{
		parent::__construct();

		$this->userType = "staff_members";
	}
        
        public function export()
        {
                return Excel::download(new UserExport, 'users.xlsx');
        }
}
