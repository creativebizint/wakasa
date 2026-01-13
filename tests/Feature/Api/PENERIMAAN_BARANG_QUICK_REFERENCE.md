# Penerimaan Barang (Goods Receipt) - Quick Reference Guide

## Overview
Quick reference for the OrderItemController API and Penerimaan Barang feature.

**Full Documentation**: See `FSD_PenerimaanBarang_OrderItemController.md`

---

## API Endpoints

### 1. List Order Items
```
GET /api/v1/order-items
```

**Purpose**: Retrieve order items with filtering and pagination

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `warehouse_id` | string (hashed) | No | Filter by warehouse |
| `dates` | string | No | Date range: "YYYY-MM-DD,YYYY-MM-DD" |
| `offset` | integer | No | Pagination offset |
| `limit` | integer | No | Results per page (default: 10) |
| `order` | string | No | Sort order |
| `custom_sorter` | string | No | Custom SQL ORDER BY |

**Example Request**:
```bash
GET /api/v1/order-items?warehouse_id=abc123&dates=2026-01-01,2026-01-31&limit=20
```

**Example Response**:
```json
{
  "data": [
    {
      "xid": "xyz789",
      "x_order_id": "ord123",
      "x_product_id": "prd456",
      "quantity": 10.00,
      "unit_price": 50000.00,
      "subtotal": 475000.00,
      "product": {
        "name": "Product Name",
        "item_code": "ITEM-001"
      },
      "order": {
        "invoice_number": "INV-001",
        "order_date": "2026-01-03T00:00:00.000000Z"
      }
    }
  ],
  "meta": {
    "paging": {
      "total": 100
    }
  }
}
```

### 2. Product Sales Summary
```
GET /api/v1/order-items?product_sales_summary=true
```

**Purpose**: Generate aggregated sales data by product

**Parameters**:
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `product_sales_summary` | boolean | Yes | Must be `true` |
| `dates` | string | No | Date range filter |
| `category_id` | string (hashed) | No | Filter by category |
| `warehouse_id` | string (hashed) | No | Filter by warehouse |
| `custom_sorter` | string | No | Custom sorting |

**Example Request**:
```bash
GET /api/v1/order-items?product_sales_summary=true&dates=2026-01-01,2026-01-31&category_id=cat123
```

**Example Response**:
```json
{
  "data": [
    {
      "x_product_id": "prd456",
      "name": "Product Name",
      "item_code": "ITEM-001",
      "unit_sold": 150.00,
      "total_sales_price": 7500000.00,
      "product": {
        "name": "Product Name",
        "image": "product.jpg",
        "unit": {
          "name": "Piece",
          "short_name": "pcs"
        },
        "details": {
          "purchase_price": 40000.00,
          "sales_price": 50000.00
        }
      }
    }
  ]
}
```

---

## Common Use Cases

### Use Case 1: View Today's Receipts
```bash
GET /api/v1/order-items?dates=2026-01-03,2026-01-03
```

### Use Case 2: View Warehouse Receipts
```bash
GET /api/v1/order-items?warehouse_id=wh123
```

### Use Case 3: Monthly Sales Summary
```bash
GET /api/v1/order-items?product_sales_summary=true&dates=2026-01-01,2026-01-31
```

### Use Case 4: Top Selling Products
```bash
GET /api/v1/order-items?product_sales_summary=true&custom_sorter=total_sales_price DESC&limit=10
```

### Use Case 5: Category Sales Analysis
```bash
GET /api/v1/order-items?product_sales_summary=true&category_id=cat123&dates=2026-01-01,2026-01-31
```

---

## Business Rules

### Warehouse Filtering
- Uses OR logic: `warehouse_id` OR `from_warehouse_id`
- Shows items in both source and destination warehouses
- Defaults to user's current warehouse if not specified

### Date Filtering
- Format: `YYYY-MM-DD,YYYY-MM-DD` (start,end)
- Inclusive range: `>= start_date AND <= end_date`
- Applied to `order_date` field
- Invalid dates are ignored

### Sales Summary
- Only includes `order_type = 'sales'`
- Groups by `product_id`
- Calculates:
  - `unit_sold` = SUM(quantity)
  - `total_sales_price` = SUM(subtotal)

### Security
- All IDs are hashed (Hashids)
- Authentication required
- Company scope enforced
- Warehouse access controlled

---

## Data Model

### OrderItem Fields
```
id                  - Primary key
order_id            - Foreign key to orders
product_id          - Foreign key to products
user_id             - Foreign key to users
unit_id             - Foreign key to units
tax_id              - Foreign key to taxes
quantity            - float(8,2)
unit_price          - double
single_unit_price   - double
tax_rate            - float(8,2)
discount_rate       - float(8,2)
total_tax           - double
total_discount      - double
subtotal            - double
mrp                 - double (Maximum Retail Price)
created_at          - timestamp
updated_at          - timestamp
```

### Relationships
```
OrderItem
  ├── Order
  │   ├── Warehouse
  │   └── FromWarehouse
  ├── Product
  │   ├── Category
  │   └── Unit
  ├── Unit
  └── Tax
```

---

## Calculations

### Subtotal Calculation
```
subtotal = (quantity × single_unit_price) - total_discount + total_tax
```

### Tax Calculation
```
total_tax = (quantity × single_unit_price) × (tax_rate / 100)
```

### Discount Calculation
```
total_discount = (quantity × single_unit_price) × (discount_rate / 100)
```

---

## Error Handling

### Common Errors

**401 Unauthorized**
```json
{
  "code": 401,
  "message": "Unauthenticated"
}
```

**403 Forbidden**
```json
{
  "code": 403,
  "message": "Access denied to warehouse"
}
```

**422 Validation Error**
```json
{
  "code": 422,
  "message": "Invalid date format",
  "errors": {
    "dates": ["Date format must be YYYY-MM-DD,YYYY-MM-DD"]
  }
}
```

---

## Performance Tips

### Optimize Queries
1. Use pagination (`limit` parameter)
2. Filter by warehouse to reduce dataset
3. Use date ranges to limit results
4. Avoid overly complex custom sorting

### Caching
- Sales summaries can be cached
- Cache key: `sales_summary_{warehouse}_{dates}_{category}`
- TTL: 1 hour for current day, 24 hours for past dates

### Indexing
- Ensure indexes on: `order_id`, `product_id`, `created_at`
- Composite index on: `(order_id, product_id)`

---

## Testing

### Test Scenarios

**1. Basic Listing**
```php
$response = $this->get('/api/v1/order-items');
$response->assertStatus(200);
$response->assertJsonStructure(['data', 'meta']);
```

**2. Warehouse Filtering**
```php
$response = $this->get('/api/v1/order-items?warehouse_id=' . $warehouseHash);
$response->assertStatus(200);
```

**3. Date Range**
```php
$response = $this->get('/api/v1/order-items?dates=2026-01-01,2026-01-31');
$response->assertStatus(200);
```

**4. Sales Summary**
```php
$response = $this->get('/api/v1/order-items?product_sales_summary=true');
$response->assertStatus(200);
$response->assertJsonStructure([
    'data' => [
        '*' => ['unit_sold', 'total_sales_price']
    ]
]);
```

---

## Troubleshooting

### Issue: No results returned
**Check**:
- User has warehouse access
- Date range is valid
- Warehouse has order items
- Company scope is correct

### Issue: Incorrect totals in sales summary
**Check**:
- Order type is 'sales'
- Date range includes the orders
- Category filter is correct
- Calculations are using correct fields

### Issue: Performance is slow
**Check**:
- Add pagination
- Reduce date range
- Check database indexes
- Review custom sorting complexity

---

## Code References

### Controller
```php
// File: app/Http/Controllers/Api/OrderItemController.php
public function modifyIndex($query)
{
    // Warehouse filtering (lines 21-36)
    // Date range filtering (lines 39-46)
    // Product sales summary (lines 49-63)
    // Custom sorting (lines 65-67)
}
```

### Model
```php
// File: app/Models/OrderItem.php
protected $casts = [
    'quantity' => 'double',
    'unit_price' => 'double',
    'subtotal' => 'double',
    // ... other casts
];

public function product() {
    return $this->belongsTo(Product::class);
}

public function order() {
    return $this->belongsTo(Order::class);
}
```

---

## Related Documentation

- **Full FSD**: `FSD_PenerimaanBarang_OrderItemController.md`
- **Tests**: `OrderItemControllerTest.php`
- **README**: `README_FSD_Documentation.md`
- **Analysis**: `INVENTORY_IN_ANALYSIS.md`, `QC_PICKING_ANALYSIS.md`

---

## Support

For detailed information, refer to the complete FSD document.

**Last Updated**: 2026-01-03
**Version**: 1.0
