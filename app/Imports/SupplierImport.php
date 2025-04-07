<?php

namespace App\Imports;

use App\Classes\Common;
use App\Models\Supplier;
use App\Models\UserDetails;
use App\Models\Warehouse;

use Examyou\RestAPI\Exceptions\ApiException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithMultipleSheets;
use Maatwebsite\Excel\Concerns\ToArray;

class SupplierImport implements ToArray, WithHeadingRow, WithMultipleSheets
{
    protected $cacheKey;
	protected $userId;

	public function __construct($cacheKey, $userId)
    {
		$this->cacheKey = $cacheKey;
        $this->userId = $userId;
    }

	public function sheets(): array
    {
        return [
            0 => $this,
        ];
    }

    public function array(array $parties)
    {
        DB::transaction(function () use ($parties) {

            $currentRow = 2;
			$errMessage = "";
            $userType = "suppliers";

            foreach ($parties as $party) {

                if (
                    !array_key_exists('code', $party) || !array_key_exists('name', $party)
                ) {
                    $errMessage = '[row ' . $currentRow . ']: Field missing from header.';
					Cache::put($this->cacheKey, $errMessage);
					return;
                }

                file_put_contents(storage_path('logs') . '/supplier.log', "[" . date('Y-m-d H:i:s') . "]party : \n" . print_r($party,1) . "\n\n", FILE_APPEND);
                
                $user = Supplier::withoutGlobalScope('type');

                $code = trim($party['code']);
                if ($code == '') {
					$errMessage = '[row ' . $currentRow . ']: code Cannot Be Empty.';
                    Cache::put($this->cacheKey, $errMessage);
					return;
				} else {
                    $codeCount = $user->where('code', $code)->where('user_type', $userType)->count();
                    if ($codeCount > 0) {
                        $errMessage = '[row ' . $currentRow . ']: code *' . $code . '* Already Exists.';
                        Cache::put($this->cacheKey, $errMessage);return;
                    }
                }

                $name = trim($party['name']);
                if ($name == '') {
                    $errMessage = '[row ' . $currentRow . ']: name Cannot Be Empty.';
                    Cache::put($this->cacheKey, $errMessage);
					return;
                }

                $email = trim($party['email']);
//                if ($email != '') {
//                    $emailCount = $user->where('email', $email)->where('user_type', $userType)->count();
//                    if ($emailCount > 0) {
//                        $errMessage = '[row ' . $currentRow . ']: email *' . $email . '* Already Exists.';
//                        Cache::put($this->cacheKey, $errMessage);
//					    return;
//                    }
//                }

                $phone = trim($party['phone']);
//                if ($phone != '') {
//                    $phoneCount = $user->where('phone', $phone)->where('user_type', $userType)->count();
//                    if ($phoneCount > 0) {
//                        $errMessage = '[row ' . $currentRow . ']: phone *' . $phone . '* Already Exists.';
//                        Cache::put($this->cacheKey, $errMessage);
//					    return;
//                    }
//                }

                $address = trim($party['billing_address']);
//                $shippingAddress = trim($party['shipping_address']);
//               
//                // Details
//                $openingBalance = trim($party['opening_balance']);
//                $openingBalanceType = strtolower(trim($party['opening_balance_type']));
//                if ($openingBalance != "" && !in_array($openingBalanceType, ['pay', 'receive'])) {
//                    $errMessage = '[row ' . $currentRow. ']: opening_balance_type Must Be *pay* Or *receive*.';
//                    Cache::put($this->cacheKey, $errMessage);
//					return;
//                }

                $creditPeriod = trim($party['credit_period']);
                $creditLimit = trim($party['credit_limit']);

                $user = new Supplier();
                $user->company_id = company()->id;
                $user->warehouse_id = company()->warehouse->id;
                $user->user_type = $userType;
                $user->name = $name;
                $user->code = $code;
                $user->email = $email;
                $user->phone = $phone;
                $user->address = $address != "" ? $address : "";
                $user->save();

                $allWarehouses = Warehouse::select('id')->get();

                foreach ($allWarehouses as $allWarehouse) {
                    $userDetails = new UserDetails();
                    $userDetails->warehouse_id = $allWarehouse->id;
                    $userDetails->user_id = $user->id;
                    $userDetails->opening_balance = 0;
                    $userDetails->opening_balance_type = '';
                    $userDetails->credit_period = 30;
                    $userDetails->credit_limit = 0;
                    $userDetails->save();

                    Common::updateUserAmount($user->id, $allWarehouse->id);
                }

                $currentRow++;
            }
          
            // Forget cache
			Cache::forget($this->cacheKey);
        });
    }
}
