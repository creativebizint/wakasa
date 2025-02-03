<?php

namespace App\Models;


use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;
use App\Casts\Hash;

class ProductPlacementRow extends BaseModel
{
    protected $table = 'product_placement_row';

    protected $default = ['id', 'xid', 'value','product_placement_shelf_number_id','x_product_placement_shelf_number_id'];

    protected $guarded = ['id','product_placement_shelf_number_id'];

    protected $appends = ['xid','x_product_placement_shelf_number_id'];

    protected $hidden = [];

    protected $filterable = ['id', 'value'];

    public $timestamps = false;
    
    protected $hashableGetterFunctions = [
        'getXProductPlacementShelfNumberIdAttribute' => 'product_placement_shelf_number_id',
    ];
    
    protected $casts = [
        'product_placement_shelf_number_id' => Hash::class . ':hash',
    ];
    
    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    } 
    
    
    public function product_placement_shelf_number()
    {
        return $this->belongsTo(ProductPlacementShelfNumber::class, 'product_placement_shelf_number_id', 'id');
    }
}