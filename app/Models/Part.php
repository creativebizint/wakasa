<?php

namespace App\Models;


use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;

class Part extends BaseModel
{
    protected $table = 'parts';

    protected $default = ['id', 'xid', 'name','code','description','description2','type'];

    protected $guarded = ['id', 'created_at', 'updated_at'];

    protected $appends = ['xid'];

    protected $hidden = ['id'];

    protected $filterable = ['id', 'name'];

    protected static function boot()
    {
        parent::boot();
    }

    
}
