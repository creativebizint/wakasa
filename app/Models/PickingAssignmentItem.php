<?php

namespace App\Models;

use App\Casts\Hash;
use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Builder;

class PickingAssignmentItem extends BaseModel
{
    protected $table = 'picking_assignment_item';

    public $timestamps = false;
    protected $default = ['xid'];

    protected $guarded = ['id', 'picking_assignment_id', 'order_item_id', 'product_id'];

    protected $hidden = ['id'];

    protected $appends = ['xid', 'x_picking_assignment_id','x_order_item_id','x_product_id'];

    protected $filterable = ['id', 'invoice_number'];

    protected $hashableGetterFunctions = [
        'getXPickingAssignmentIdAttribute' => 'picking_assignment_id',
        'getXOrderItemIdAttribute' => 'order_item_id',
        'getXProductIdAttribute' => 'product_id',
    ];

    protected $casts = [
        'picking_assignment_id' => Hash::class . ':hash',  
        'order_item_id' => Hash::class . ':hash',
        'product_id' => Hash::class . ':hash'        
    ];

    protected static function boot()
    {
        parent::boot();

        
    }

}
