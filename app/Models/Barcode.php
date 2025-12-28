<?php

namespace App\Models;


use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;

class Barcode extends BaseModel
{
    protected $table = 'barcode';

    protected $default = ['id', 'xid', 'string','isactive','reason','comment','reg_bungkus_id','fk_reg_bungkus_id','nik','box_id','qty_bungkus'];

    protected $guarded = ['id', 'created_at', 'updated_at'];

    protected $appends = ['xid'];

    protected $hidden = ['id'];

    protected $filterable = ['string','item_id', 'isactive'];

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
    
    public function product()
    {
        return $this->belongsTo(Product::class, 'item_id', 'item_id');
    }
    
    
    public function product_placements()
    {
        return $this->belongsTo(ProductPlacement::class, 'id', 'barcode_id');
    }
    
    const STATUS_OPEN = 1;
    const STATUS_SCANNED = 2;
    const STATUS_IN = 3;
    const STATUS_SO = 4;
    const STATUS_DO = 5;
  
}
