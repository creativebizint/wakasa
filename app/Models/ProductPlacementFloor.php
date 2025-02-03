<?php

namespace App\Models;


use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;

class ProductPlacementFloor extends BaseModel
{
    protected $table = 'product_placement_floor';

    protected $default = ['id', 'xid','value'];

    protected $guarded = ['id'];

    protected $appends = ['xid'];

    protected $hidden = [];

    protected $filterable = ['id', 'value'];

    public $timestamps = false;
    
    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    }    
}
