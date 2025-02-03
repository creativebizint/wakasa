<?php

namespace App\Models;

use App\Casts\Hash;
use App\Models\BaseModel;
use App\Models\StaffMember;
use App\Scopes\CompanyScope;

class StockAdjustment extends BaseModel
{
    protected $table = 'stock_adjustments';

    protected $default = ['xid'];

    protected $guarded = ['id', 'warehouse_id', 'created_by', 'created_at', 'updated_at'];

    protected $hidden = ['id', 'warehouse_id', 'product_id', 'created_by', 'stock_adjustment_order_id'];

    protected $appends = ['xid', 'x_warehouse_id', 'x_product_id', 'x_created_by', 'x_stock_adjustment_order_id'];

    protected $filterable = ['warehouse_id', 'product_id', 'invoice_number', 'date', 'created_by', 'stock_adjustment_order_id'];

    protected $hashableGetterFunctions = [
        'getXWarehouseIdAttribute' => 'warehouse_id',
        'getXProductIdAttribute' => 'product_id',
        'getXCreatedByAttribute' => 'created_by',
        'getXStockAdjustmentOrderIdAttribute' => 'stock_adjustment_order_id',
    ];

    protected $casts = [
        'warehouse_id' => Hash::class . ':hash',
        'product_id' => Hash::class . ':hash',
        'created_by' => Hash::class . ':hash',
        'stock_adjustment_order_id' => Hash::class . ':hash',
        'quantity' => 'double',
    ];

    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'id');
    }

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'warehouse_id', 'id');
    }

    public function createdBy()
    {
        return $this->belongsTo(StaffMember::class, 'created_by', 'id');
    }

    public function stockAdjustmentOrder()
    {
        return $this->belongsTo(StockAdjustmentOrder::class, 'stock_adjustment_order_id', 'id');
    }
}
