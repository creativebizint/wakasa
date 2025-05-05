<?php

namespace App\Models;

use App\Casts\Hash;
use App\Classes\Common;
use App\Models\BaseModel;
use App\Models\PickingAssignmentItem;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Builder;

class PickingAssignment extends BaseModel
{
    protected $table = 'picking_assignment';

    protected $default = ['xid','x_user_id'];

    protected $guarded = ['id', 'user_id', 'created_at', 'updated_at'];

    protected $hidden = ['id', 'user_id'];

    protected $appends = ['xid', 'x_user_id'];

    protected $filterable = ['id', 'code','users.name'];

    protected $hashableGetterFunctions = [
        'getXUserIdAttribute' => 'user_id',
    ];

    protected $casts = [
        'user_id' => Hash::class . ':hash'        
    ];

    protected static function boot()
    {
        parent::boot();
    }

    public function user()
    {
        return $this->belongsTo(StaffMember::class, 'user_id', 'id')->withoutGlobalScope('type');
    }
    
    public function items(){
        return $this->hasMany(PickingAssignmentItem::class, 'picking_assignment_id', 'id');
    }
    
}
