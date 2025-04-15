<?php

namespace App\Models;

use App\Casts\Hash;
use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;

class ScannedHistoryItems extends BaseModel
{
    protected $table = 'scanned_history_items';

    protected $default = ['id', 'xid', 'xscannedhistoryid','qty'];

    protected $guarded = ['id','scanned_history_id','barcode_id'];

    protected $appends = ['xid', 'xscannedhistoryid','xbarcodeid'];

    protected $hidden = ['id'];

    protected $filterable = ['id'];

    public $timestamps = false;
    
    protected $hashableGetterFunctions = [
        'getXScannedHistoryId' => 'scanned_history_id',
        'getXBarcodeId' => 'barcode_id'
    ];
    protected $casts = [
        'scanned_history_id' => Hash::class . ':hash',   
        'barcode_id' => Hash::class . ':hash'   
    ];
    
    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    }

}
