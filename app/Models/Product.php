<?php

namespace App\Models;

use App\Casts\Hash;
use App\Classes\Common;
use App\Models\BaseModel;
use App\Scopes\CompanyScope;
use Vinkla\Hashids\Facades\Hashids;

class Product extends BaseModel
{
    protected $table = 'products';

    protected $default = ['xid'];

    protected $guarded = ['id', 'warehouse_id', 'user_id', 'created_at', 'updated_at'];

    protected $hidden = ['id', 'category_id', 'brand_id', 'unit_id', 'uom_sale_in', 'uom_buy_in', 'kemasan_jual_unit', 'user_id', 'warehouse_id', 'variant_id', 'variant_value_id', 'parent_id'];

    protected $appends = ['xid', 'x_category_id', 'x_brand_id', 'x_part_id', 'x_unit_id', 'x_uom_sale_in', 'x_uom_buy_in', 'x_kemasan_jual_unit', 'x_user_id', 'x_warehouse_id', 'x_variant_id', 'x_variant_value_id', 'x_parent_id', 'image_url','x_supplier_id'];

    protected $filterable = ['id', 'products.id', 'products.name', 'name', 'item_code', 'category_id', 'brand_id','part_id','item_id'];

    protected $hashableGetterFunctions = [
        'getXCategoryIdAttribute' => 'category_id',
        'getXBrandIdAttribute' => 'brand_id',
        'getXUnitIdAttribute' => 'unit_id',
        'getXUomSaleInAttribute' => 'uom_sale_in',
        'getXUomBuyInAttribute' => 'uom_buy_in',
        'getXKemasanJualUnitAttribute' => 'kemasan_jual_unit',
        'getXPartIdAttribute' => 'part_id',
        'getXUserIdAttribute' => 'user_id',
        'getXWarehouseIdAttribute' => 'warehouse_id',
        'getXVariantIdAttribute' => 'variant_id',
        'getXVariantValueIdAttribute' => 'variant_value_id',
        'getXParentIdAttribute' => 'parent_id',
        'getXSupplierIdAttribute' => 'supplier_id',
    ];

    protected $casts = [
        'category_id' => Hash::class . ':hash',
        'brand_id' => Hash::class . ':hash',
        'part_id' => Hash::class . ':hash',
        'unit_id' => Hash::class . ':hash',
        'uom_sale_in' => Hash::class . ':hash',
        'uom_buy_in' => Hash::class . ':hash',
        'kemasan_jual_unit' => Hash::class . ':hash',
        'user_id' => Hash::class . ':hash',
        'warehouse_id' => Hash::class . ':hash',
        'variant_id' => Hash::class . ':hash',
        'variant_value_id' => Hash::class . ':hash',
        'parent_id' => Hash::class . ':hash',
        'supplier_id' => Hash::class . ':hash',
    ];

    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new CompanyScope);
    }

    public function getImageUrlAttribute()
    {
        $productImagePath = Common::getFolderPath('productImagePath');

        return $this->image == null ? asset('images/product.png') : Common::getFileUrl($productImagePath, $this->image);
    }

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id', 'id');
    }

    public function brand()
    {
        return $this->belongsTo(Brand::class, 'brand_id', 'id');
    }
    
    public function part()
    {
        return $this->belongsTo(Part::class, 'part_id', 'id');
    }
    
    public function supplier()
    {
        return $this->belongsTo(Supplier::class, 'supplier_id', 'id');
    }

    public function unit()
    {
        return $this->belongsTo(Unit::class, 'unit_id', 'id');
    }

    public function user()
    {
        return $this->belongsTo(StaffMember::class, 'user_id', 'id');
    }

    public function warehouseStocks()
    {
        return $this->hasMany(WarehouseStock::class, 'product_id', 'id');
    }

    public function items()
    {
        return $this->hasMany(OrderItem::class, 'product_id', 'id');
    }

    public function productVariations()
    {
        return $this->hasMany(ProductVariant::class, 'product_id', 'id');
    }

    public function variations()
    {
        return $this->hasMany(Product::class, 'parent_id', 'id');
    }

    public function variation()
    {
        return $this->belongsTo(Variation::class, 'variant_id', 'id');
    }

    public function variationType()
    {
        return $this->belongsTo(Variation::class, 'variant_value_id', 'id');
    }

    public function stockHistory()
    {
        return $this->hasMany(StockHistory::class, 'product_id', 'id');
    }

    public function customFields()
    {
        return $this->hasMany(ProductCustomField::class, 'product_id', 'id');
    }

    public function details()
    {
        return $this->belongsTo(ProductDetails::class, 'id', 'product_id');
    }

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class);
    }
}
