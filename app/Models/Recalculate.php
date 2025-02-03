<?php

namespace App\Models;

use App\Casts\Hash;
use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;
use Vinkla\Hashids\Facades\Hashids;

class Recalculate extends BaseModel
{
    protected $table = 'recalculates';

    protected $default = ['xid'];

    protected $guarded = ['id', 'created_at', 'updated_at'];

    protected $hidden = ['id', 'product_detail_id'];

    protected $appends = ['xid', 'x_product_detail_id'];

    protected $filterable = ['id',];

    protected $hashableGetterFunctions = [
        'getXProductDetailIdAttribute' => 'product_detail_id',
    ];

    protected $casts = [
        'product_detail_id' => Hash::class . ':hash',
    ];

    protected static function boot()
    {
        parent::boot();
    }

    public function productDetail()
    {
        return $this->belongsTo(ProductDetails::class, 'product_detail_id', 'id');
    }
}
