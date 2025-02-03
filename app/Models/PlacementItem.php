<?php

namespace App\Models;

use App\Classes\Common;
use Illuminate\Notifications\Notifiable;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;
use App\Casts\Hash;
use Vinkla\Hashids\Facades\Hashids;

class PlacementItem extends BaseModel
{
    protected $table = 'placement_items';

    protected $default = ['xid', 'id', 'x_user_id', 'user_id', 'x_placement_id', 'x_product_id', 'product_id', 'x_unit_id', 'unit_id', 'floor','shelf_number','row'];

    protected $guarded = ['id'];

    protected $hidden = ['id'];

    protected $appends = ['xid', 'x_user_id', 'x_placement_id', 'x_product_id', 'x_unit_id'];

    protected $filterable = ['id', 'product_id', 'warehouse_id', 'floor', 'shelf_number', 'row'];

    protected $hashableGetterFunctions = [
        'getXUserIdAttribute' => 'user_id',
        'getXPlacementIdAttribute' => 'placement_id',
        'getXProductIdAttribute' => 'product_id',
        'getXUnitIdAttribute' => 'unit_id',
    ];

    protected $casts = [
        'user_id' => Hash::class . ':hash',
        'placement_id' => Hash::class . ':hash',
        'product_id' => Hash::class . ':hash',
        'unit_id' => Hash::class . ':hash',
    ];

    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    }

}
