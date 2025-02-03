<?php

namespace App\Models;

use App\Classes\Common;
use Illuminate\Notifications\Notifiable;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;
use App\Casts\Hash;
use Vinkla\Hashids\Facades\Hashids;

class Placement extends BaseModel
{
    protected $table = 'placements';

    protected $default = ['xid', 'x_company_id', 'x_warehouse_id', 'floor','shelf_number','row'];

    protected $guarded = ['id'];

    protected $hidden = ['id'];

    protected $appends = ['xid', 'x_company_id', 'x_warehouse_id'];

    protected $filterable = ['id', 'invoice_number', 'warehouse_id', 'floor', 'shelf_number', 'row'];

    protected $hashableGetterFunctions = [
        'getXWarehouseIdAttribute' => 'warehouse_id',
        'getXCompanyIdAttribute' => 'company_id',
    ];

    protected $casts = [
        'placement_date' => 'datetime',
        'warehouse_id' => Hash::class . ':hash',
        'company_id' => Hash::class . ':hash',
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
    
    
}
