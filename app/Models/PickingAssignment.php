<?php

namespace App\Models;

use App\Casts\Hash;
use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Builder;

class PickingAssignment extends BaseModel
{
    protected $table = 'picking_assignment';

    protected $default = ['xid'];

    protected $guarded = ['id', 'user_id', 'created_at', 'updated_at'];

    protected $hidden = ['id', 'user_id'];

    protected $appends = ['xid', 'x_user_id'];

    protected $filterable = ['id', 'code'];

    protected $hashableGetterFunctions = [
        'getXUserIdAttribute' => 'user_id',
    ];

    protected $casts = [
        'user_id' => Hash::class . ':hash'        
    ];

    protected static function boot()
    {
        parent::boot();
    }

}
