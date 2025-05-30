<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Customer\IndexRequest;
use App\Http\Requests\Api\Customer\StoreRequest;
use App\Http\Requests\Api\Customer\UpdateRequest;
use App\Http\Requests\Api\Customer\DeleteRequest;
use App\Models\Customer;
use App\Traits\PartyTraits;
use App\Exports\CustomerExport;
use Maatwebsite\Excel\Facades\Excel;

class CustomersController extends ApiBaseController
{
	use PartyTraits;

	protected $model = Customer::class;

	protected $indexRequest = IndexRequest::class;
	protected $storeRequest = StoreRequest::class;
	protected $updateRequest = UpdateRequest::class;
	protected $deleteRequest = DeleteRequest::class;

	public function __construct()
	{
		parent::__construct();

		$this->userType = "customers";
	}
        
        public function export()
        {
                return Excel::download(new CustomerExport, 'customers.xlsx');
        }
      
}
