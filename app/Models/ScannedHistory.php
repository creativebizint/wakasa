<?php

namespace App\Models;

use App\Casts\Hash;
use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;

class ScannedHistory extends BaseModel
{
    protected $table = 'scanned_history';

    protected $default = ['id', 'xid', 'batch'];

    protected $guarded = ['id', 'created_at', 'updated_at','staff_user_id','order_id','order_item_id'];

    protected $appends = ['xid'];

    protected $hidden = ['id'];

    protected $filterable = ['order_id', 'order_item_id'];

    protected $hashableGetterFunctions = [
        'getXStaffUserIdAttribute' => 'staff_user_id',
        'getXOrderId' => 'order_id',
        'getXOrderItemId' => 'order_item_id',
    ];
    protected $casts = [
        'staff_user_id' => Hash::class . ':hash',
        'order_id' => Hash::class . ':hash',
        'order_item_id' => Hash::class . ':hash'        
    ];
    
    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    }

}
