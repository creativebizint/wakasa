<?php

namespace App\Models;


use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;

class Barcode extends BaseModel
{
    protected $table = 'barcode';

    protected $default = ['id', 'xid', 'string','isactive','reason','comment'];

    protected $guarded = ['id', 'created_at', 'updated_at'];

    protected $appends = ['xid'];

    protected $hidden = ['id'];

    protected $filterable = ['id', 'string'];

    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    }
    
    public function order_item()
    {
        return $this->belongsTo(OrderItem::class, 'order_item_id', 'id');
    }
    
    public function order_item_out()
    {
        return $this->belongsTo(OrderItem::class, 'order_item_out_id', 'id');
    }
}
