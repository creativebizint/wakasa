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

    protected $default = ['xid', 'id',  'x_placement_id', 'x_product_id', 'product_id','row'];

    protected $guarded = ['id'];

    protected $hidden = ['id'];

    protected $appends = ['xid', 'x_placement_id', 'x_product_id'];

    protected $filterable = ['id', 'product_id', 'warehouse_id', 'row'];

    protected $hashableGetterFunctions = [
        'getXPlacementIdAttribute' => 'placement_id',
        'getXProductIdAttribute' => 'product_id'
    ];

    protected $casts = [
        'placement_id' => Hash::class . ':hash',
        'product_id' => Hash::class . ':hash'
    ];

    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    }

}
