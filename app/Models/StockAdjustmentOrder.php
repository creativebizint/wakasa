<?php

namespace App\Models;

use App\Casts\Hash;
use App\Models\BaseModel;
use App\Models\StaffMember;
use App\Scopes\CompanyScope;

class StockAdjustmentOrder extends BaseModel
{
    protected $table = 'stock_adjustment_orders';

    protected $default = ['xid'];

    protected $guarded = ['id', 'warehouse_id', 'created_by', 'created_at', 'updated_at'];

    protected $hidden = ['id', 'warehouse_id', 'product_id', 'created_by'];

    protected $appends = ['xid', 'x_warehouse_id', 'x_product_id', 'x_created_by'];

    protected $dates = ['date'];

    protected $filterable = ['warehouse_id', 'product_id', 'invoice_number', 'date', 'created_by'];

    protected $hashableGetterFunctions = [
        'getXWarehouseIdAttribute' => 'warehouse_id',
        'getXProductIdAttribute' => 'product_id',
        'getXCreatedByAttribute' => 'created_by',
    ];

    protected $casts = [
        'warehouse_id' => Hash::class . ':hash',
        'product_id' => Hash::class . ':hash',
        'created_by' => Hash::class . ':hash',
        'quantity' => 'double',
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

    public function createdBy()
    {
        return $this->belongsTo(StaffMember::class, 'created_by', 'id');
    }

    public function items()
    {
        return $this->hasMany(StockAdjustment::class, 'stock_adjustment_order_id', 'id')->orderBy('id', 'asc');
    }
}
