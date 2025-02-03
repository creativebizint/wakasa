<?php

namespace App\Models;


use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;
use App\Casts\Hash;

class ProductPlacementShelfNumber extends BaseModel
{
    protected $table = 'product_placement_shelf_number';

    protected $default = ['id', 'xid', 'value','product_placement_shelf_group_id','x_product_placement_shelf_group_id'];

    protected $guarded = ['id','product_placement_shelf_group_id'];

    protected $appends = ['xid','x_product_placement_shelf_group_id'];

    protected $hidden = [];

    protected $filterable = ['id', 'value'];

    public $timestamps = false;
    
    protected $hashableGetterFunctions = [
        'getXProductPlacementShelfGroupIdAttribute' => 'product_placement_shelf_group_id',
    ];
    
    protected $casts = [
        'product_placement_shelf_group_id' => Hash::class . ':hash',
    ];
    
    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    }

    public function product_placement_shelf_group()
    {
        return $this->belongsTo(ProductPlacementShelfGroup::class, 'product_placement_shelf_group_id', 'id');
    }
    
}
