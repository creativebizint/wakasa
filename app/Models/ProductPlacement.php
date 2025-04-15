<?php

namespace App\Models;

use App\Classes\Common;
use Illuminate\Notifications\Notifiable;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;
use App\Casts\Hash;
use Vinkla\Hashids\Facades\Hashids;

class ProductPlacement extends BaseModel
{
    protected $table = 'product_placements';

    protected $default = ['xid', 'x_product_id', 'x_warehouse_id', 'x_unit_id', 'row'];

    protected $guarded = ['id'];

    protected $hidden = ['id'];

    protected $appends = ['xid', 'x_product_id', 'x_warehouse_id', 'x_unit_id'];

    protected $filterable = ['id', 'product_id', 'product_placements.warehouse_id', 'row', 'products.name', 'products.item_id'];
    
    protected $hashableGetterFunctions = [
        'getXWarehouseIdAttribute' => 'warehouse_id',
        'getXProductIdAttribute' => 'product_id',
        'getXUnitIdAttribute' => 'unit_id',
        'getXProductIdAttribute' => 'product_id',
    ];

    protected $casts = [
        'warehouse_id' => Hash::class . ':hash',
        'product_id' => Hash::class . ':hash',
        'unit_id' => Hash::class . ':hash',
        'product_id' => Hash::class . ':hash',
    ];

    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    }

    
    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'warehouse_id', 'id');
    }
    
    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'id');
    }
    
    
}
