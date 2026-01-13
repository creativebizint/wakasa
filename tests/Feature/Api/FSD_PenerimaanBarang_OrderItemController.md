# Functional Specification Document: Penerimaan Barang (Goods Receipt)

## Document Information
- **Feature Name**: Penerimaan Barang (Goods Receipt / Order Items Management)
- **Component**: OrderItemController
- **Version**: 1.0
- **Last Updated**: 2026-01-03
- **Related Files**:
  - `app/Http/Controllers/Api/OrderItemController.php`
  - `app/Models/OrderItem.php`
  - `app/Models/Order.php`
  - `app/Http/Requests/Api/OrderItem/IndexRequest.php`
  - `tests/Feature/Api/OrderItemControllerTest.php`

---

## 1. System Overview & Purpose

### 1.1 Purpose
The Penerimaan Barang (Goods Receipt) system is a critical component of the warehouse management system that manages and tracks order items across various order types (purchases, sales, stock transfers). It provides comprehensive functionality for:

- Viewing and filtering order items by warehouse, date range, and product
- Generating product sales summaries and analytics
- Tracking inventory movements across warehouses
- Supporting quality control and picking operations
- Managing order item details including pricing, taxes, and discounts

### 1.2 Business Context
This system serves as the backbone for inventory tracking and order fulfillment operations. It enables:

- **Warehouse Managers**: Monitor incoming and outgoing goods across multiple warehouses
- **Purchasing Staff**: Track purchase order items and their receipt status
- **Sales Teams**: Analyze product sales performance and trends
- **Inventory Controllers**: Manage stock levels and movements
- **Quality Control Teams**: Track items through QC processes

### 1.3 System Integration
The Order Items system integrates with:

- **Order Management System**: Parent orders (purchases, sales, transfers)
- **Warehouse Management**: Multi-warehouse inventory tracking
- **Product Catalog**: Product details, pricing, and specifications
- **User Management**: Suppliers, customers, and staff members
- **Tax System**: Tax calculations and reporting
- **Barcode System**: Item tracking and scanning
- **Quality Control**: QC status tracking and workflow

---

## 2. User Personas & Use Cases

### 2.1 User Personas

#### Persona 1: Warehouse Manager (Manajer Gudang)
- **Role**: Oversees warehouse operations and inventory
- **Goals**:
  - Monitor all incoming goods receipts
  - Track inventory across multiple warehouses
  - Ensure accurate stock levels
  - Generate reports for management
- **Technical Proficiency**: Medium
- **Access Level**: Full warehouse access

#### Persona 2: Purchasing Officer (Petugas Pembelian)
- **Role**: Manages purchase orders and supplier relationships
- **Goals**:
  - Track purchase order items
  - Verify received quantities
  - Monitor supplier performance
  - Reconcile purchase orders with receipts
- **Technical Proficiency**: Medium
- **Access Level**: Purchase order access

#### Persona 3: Sales Analyst (Analis Penjualan)
- **Role**: Analyzes sales data and trends
- **Goals**:
  - Generate product sales summaries
  - Identify top-selling products
  - Analyze sales by category and time period
  - Support inventory planning
- **Technical Proficiency**: High
- **Access Level**: Read-only sales data

#### Persona 4: Inventory Controller (Pengendali Inventori)
- **Role**: Manages stock levels and movements
- **Goals**:
  - Track stock transfers between warehouses
  - Monitor inventory movements
  - Identify slow-moving items
  - Maintain optimal stock levels
- **Technical Proficiency**: Medium
- **Access Level**: Inventory management access

#### Persona 5: Quality Control Inspector (Inspektur QC)
- **Role**: Performs quality checks on received goods
- **Goals**:
  - Track items pending QC
  - Record QC results
  - Approve or reject received items
  - Maintain quality standards
- **Technical Proficiency**: Low to Medium
- **Access Level**: QC operations access

### 2.2 Use Cases

#### Use Case 1: View Order Items by Warehouse
**Actor**: Warehouse Manager

**Preconditions**:
- User is authenticated
- User has warehouse access permissions
- Warehouse exists in the system

**Main Flow**:
1. User accesses the order items listing
2. System displays order items for the user's default warehouse
3. User can filter by specific warehouse using warehouse_id parameter
4. System retrieves order items where the order's warehouse_id or from_warehouse_id matches
5. System displays filtered results with product, order, and warehouse details

**Postconditions**:
- Order items are displayed with complete details
- User can view items from both destination and source warehouses

**Alternative Flows**:
- If no warehouse_id is provided, system uses user's default warehouse
- If warehouse has no items, system displays empty result set

#### Use Case 2: Generate Product Sales Summary
**Actor**: Sales Analyst

**Preconditions**:
- User is authenticated
- Sales orders exist in the system
- Products have sales transactions

**Main Flow**:
1. User requests product sales summary with `product_sales_summary=true` parameter
2. User optionally specifies date range using `dates` parameter
3. User optionally filters by category using `category_id` parameter
4. System joins order_items with products table
5. System filters for order_type = 'sales'
6. System groups results by product_id
7. System calculates:
   - Total units sold (sum of quantities)
   - Total sales price (sum of subtotals)
8. System returns aggregated data with product details

**Postconditions**:
- Sales summary is generated with accurate totals
- Data is grouped by product
- Product details (name, code, unit, pricing) are included

**Alternative Flows**:
- If category_id is provided, results are filtered by product category
- If no sales exist, system returns empty result set
- If date range is invalid, system returns validation error

#### Use Case 3: Filter Order Items by Date Range
**Actor**: Purchasing Officer

**Preconditions**:
- User is authenticated
- Orders exist in the system

**Main Flow**:
1. User specifies date range using `dates` parameter (format: "YYYY-MM-DD,YYYY-MM-DD")
2. System parses start date and end date from comma-separated values
3. System filters orders where order_date >= start_date AND order_date <= end_date
4. System returns order items from filtered orders
5. System displays results with order date information

**Postconditions**:
- Only order items within specified date range are displayed
- Date filtering is applied at the order level

**Alternative Flows**:
- If dates parameter is empty or invalid, no date filtering is applied
- If no orders exist in date range, system returns empty result set

#### Use Case 4: Track Multi-Warehouse Transfers
**Actor**: Inventory Controller

**Preconditions**:
- User is authenticated
- Stock transfer orders exist
- Multiple warehouses are configured

**Main Flow**:
1. User accesses order items listing
2. System retrieves items where order has both warehouse_id and from_warehouse_id
3. System displays items showing source and destination warehouses
4. User can filter by specific warehouse to see incoming or outgoing transfers
5. System shows complete transfer details including quantities and status

**Postconditions**:
- Transfer items are visible from both source and destination perspectives
- User can track inventory movements between warehouses

**Alternative Flows**:
- If filtering by warehouse_id, shows items where warehouse is either source or destination
- If no transfers exist, system returns empty result set

#### Use Case 5: Sort and Custom Order Results
**Actor**: Any authenticated user

**Preconditions**:
- User is authenticated
- Order items exist in the system

**Main Flow**:
1. User specifies custom sorting using `custom_sorter` parameter
2. System applies custom SQL ORDER BY clause
3. System returns results in specified order
4. User views sorted results

**Postconditions**:
- Results are displayed in custom sort order
- Sorting is applied at database level for performance

**Alternative Flows**:
- If custom_sorter is not provided, default sorting is applied
- If custom_sorter contains invalid SQL, system returns error

---

## 3. Feature List & Workflows

### 3.1 Core Features

#### Feature 1: Order Items Listing
**Description**: Display paginated list of order items with filtering capabilities

**Functionality**:
- Retrieve order items from database
- Join with orders table for order details
- Apply warehouse filtering
- Apply date range filtering
- Support pagination and sorting
- Return formatted results with relationships

**API Endpoint**: `GET /api/v1/order-items`

**Request Parameters**:
- `warehouse_id` (optional, hashed): Filter by warehouse
- `dates` (optional, string): Date range filter (format: "start,end")
- `product_sales_summary` (optional, boolean): Enable sales summary mode
- `category_id` (optional, hashed): Filter by product category
- `custom_sorter` (optional, string): Custom SQL ORDER BY clause
- Standard pagination parameters (offset, limit, order)

**Response Structure**:
```json
{
  "data": [
    {
      "xid": "hashed_id",
      "x_order_id": "hashed_order_id",
      "x_product_id": "hashed_product_id",
      "x_unit_id": "hashed_unit_id",
      "x_tax_id": "hashed_tax_id",
      "quantity": 10.00,
      "unit_price": 50000.00,
      "single_unit_price": 50000.00,
      "tax_rate": 10.00,
      "discount_rate": 5.00,
      "total_tax": 5000.00,
      "total_discount": 2500.00,
      "subtotal": 475000.00,
      "product": {
        "xid": "hashed_product_id",
        "name": "Product Name",
        "item_code": "ITEM-001"
      },
      "order": {
        "xid": "hashed_order_id",
        "invoice_number": "INV-001",
        "order_date": "2026-01-03T00:00:00.000000Z",
        "order_type": "purchases"
      },
      "unit": {
        "xid": "hashed_unit_id",
        "name": "Piece",
        "short_name": "pcs"
      }
    }
  ],
  "meta": {
    "paging": {
      "total": 100,
      "links": {
        "next": "...",
        "previous": "..."
      }
    }
  }
}
```

#### Feature 2: Product Sales Summary
**Description**: Generate aggregated sales data by product

**Functionality**:
- Filter for sales orders only
- Group by product_id
- Calculate total units sold
- Calculate total sales revenue
- Include product details and pricing
- Support category filtering
- Support date range filtering

**API Endpoint**: `GET /api/v1/order-items?product_sales_summary=true`

**Request Parameters**:
- `product_sales_summary=true` (required): Enable summary mode
- `dates` (optional): Date range filter
- `category_id` (optional, hashed): Filter by category
- `warehouse_id` (optional, hashed): Filter by warehouse
- `custom_sorter` (optional): Custom sorting

**Response Structure**:
```json
{
  "data": [
    {
      "x_product_id": "hashed_product_id",
      "name": "Product Name",
      "item_code": "ITEM-001",
      "unit_sold": 150.00,
      "total_sales_price": 7500000.00,
      "product": {
        "xid": "hashed_product_id",
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

#### Feature 3: Multi-Warehouse Filtering
**Description**: Filter order items by source or destination warehouse

**Functionality**:
- Support filtering by warehouse_id parameter
- Include items where order.warehouse_id matches
- Include items where order.from_warehouse_id matches
- Use OR logic to capture both incoming and outgoing items
- Default to user's current warehouse if not specified

**Business Logic**:
```sql
WHERE (orders.warehouse_id = ? OR orders.from_warehouse_id = ?)
```

#### Feature 4: Date Range Filtering
**Description**: Filter order items by order date range

**Functionality**:
- Accept comma-separated date string
- Parse start and end dates
- Filter orders within date range (inclusive)
- Apply at order level, return matching order items

**Date Format**: `YYYY-MM-DD,YYYY-MM-DD`

**Example**: `dates=2026-01-01,2026-01-31`

#### Feature 5: Custom Sorting
**Description**: Apply custom SQL sorting to results

**Functionality**:
- Accept raw SQL ORDER BY clause
- Apply to query before execution
- Support complex sorting expressions
- Enable flexible result ordering

**Example**: `custom_sorter=total_sales_price DESC, unit_sold DESC`

### 3.2 Workflows

#### Workflow 1: Goods Receipt Process
```
1. Purchase Order Created
   ↓
2. Goods Arrive at Warehouse
   ↓
3. Warehouse Staff Views Order Items
   - Filter by warehouse
   - Filter by date
   - View item details
   ↓
4. Items Scanned/Received
   - Quantity recorded
   - QC status updated
   ↓
5. Items Placed in Storage
   - Location assigned
   - Barcode generated
   ↓
6. Stock Updated
   - Inventory increased
   - Order status updated
```

#### Workflow 2: Sales Analysis Process
```
1. Sales Analyst Accesses System
   ↓
2. Selects Date Range
   - Start date
   - End date
   ↓
3. Enables Product Sales Summary
   - product_sales_summary=true
   ↓
4. Optionally Filters by Category
   - category_id parameter
   ↓
5. System Generates Summary
   - Groups by product
   - Calculates totals
   ↓
6. Analyst Reviews Results
   - Units sold
   - Revenue generated
   - Product performance
   ↓
7. Export or Further Analysis
```

#### Workflow 3: Inter-Warehouse Transfer Tracking
```
1. Transfer Order Created
   - Source warehouse (from_warehouse_id)
   - Destination warehouse (warehouse_id)
   ↓
2. Items Picked from Source
   - Quantity verified
   - Items packed
   ↓
3. Items in Transit
   - Visible in both warehouses
   - Status: in_transit
   ↓
4. Items Arrive at Destination
   - Received and verified
   - QC performed
   ↓
5. Items Stored at Destination
   - Stock updated in both warehouses
   - Transfer completed
```

---

## 4. Business Rules & Constraints

### 4.1 Business Rules

#### Rule 1: Warehouse Scope
- All order items must be associated with a valid order
- Orders must have either warehouse_id or from_warehouse_id (or both)
- Users can only view items for warehouses they have access to
- Multi-warehouse transfers show in both source and destination warehouse views

#### Rule 2: Sales Summary Calculation
- Sales summary only includes orders with order_type = 'sales'
- Quantities are summed at the product level
- Subtotals are summed to calculate total sales price
- Grouping is by product_id to aggregate all sales of the same product

#### Rule 3: Date Range Filtering
- Date filtering applies to order_date field
- Date range is inclusive (>= start_date AND <= end_date)
- Invalid date formats are ignored (no filtering applied)
- Empty dates parameter results in no date filtering

#### Rule 4: Data Visibility
- Order items inherit visibility from parent order
- Company scope applies (multi-tenant isolation)
- Warehouse scope applies based on user permissions
- Cancelled orders may be excluded based on business requirements

#### Rule 5: Pricing and Calculations
- unit_price: Price per unit including taxes and discounts
- single_unit_price: Base price per unit before calculations
- subtotal = (quantity × single_unit_price) - total_discount + total_tax
- All monetary values stored as double precision
- Tax calculations based on tax_rate percentage
- Discount calculations based on discount_rate percentage

### 4.2 Constraints

#### Technical Constraints
- All IDs are hashed for security (using Hashids)
- Database queries must be optimized for performance
- Pagination required for large result sets
- Maximum query execution time: 30 seconds
- API response size should not exceed 10MB

#### Data Constraints
- quantity: Must be positive, stored as float(8,2)
- unit_price: Must be non-negative, stored as double
- tax_rate: 0-100%, stored as float(8,2)
- discount_rate: 0-100%, stored as float(8,2)
- All foreign keys must reference valid records

#### Security Constraints
- Authentication required for all endpoints
- Authorization based on user roles and permissions
- Company scope enforced at model level
- Warehouse access controlled by user-warehouse relationships
- Sensitive data (IDs) must be hashed in responses

#### Performance Constraints
- Index on order_id, product_id for fast lookups
- Index on order_date for date range queries
- Eager loading of relationships to prevent N+1 queries
- Query result caching for frequently accessed data
- Database connection pooling for concurrent requests

---

## 5. User Interface Flows

### 5.1 Order Items Listing View

**Screen Elements**:
- Page header with title "Order Items" or "Penerimaan Barang"
- Filter panel:
  - Warehouse selector (dropdown)
  - Date range picker
  - Category filter (for sales summary)
  - Search box (invoice number, item code)
- Data table:
  - Columns: Item Code, Product Name, Quantity, Unit Price, Subtotal, Order Number, Date
  - Sortable columns
  - Pagination controls
- Action buttons:
  - View details
  - Export to Excel/PDF
  - Refresh data

**User Interactions**:
1. User selects warehouse from dropdown
2. System reloads data for selected warehouse
3. User selects date range
4. System filters data by date range
5. User clicks on row to view details
6. System displays order item details in modal/drawer

### 5.2 Product Sales Summary View

**Screen Elements**:
- Page header with title "Product Sales Summary"
- Filter panel:
  - Date range picker (required)
  - Category filter (optional)
  - Warehouse filter (optional)
- Summary table:
  - Columns: Product Code, Product Name, Units Sold, Total Revenue, Avg Price
  - Sortable by any column
  - Visual indicators (charts, graphs)
- Export options:
  - Export to Excel
  - Export to PDF
  - Print report

**User Interactions**:
1. User selects date range
2. User optionally selects category
3. User clicks "Generate Summary"
4. System displays aggregated sales data
5. User can sort by different columns
6. User can export results

---

## 6. Data Requirements

### 6.1 Data Models

#### OrderItem Model
**Table**: `order_items`

**Fields**:
- `id` (bigint, primary key)
- `order_id` (bigint, foreign key → orders.id)
- `product_id` (bigint, foreign key → products.id)
- `user_id` (bigint, foreign key → users.id)
- `unit_id` (bigint, foreign key → units.id, nullable)
- `tax_id` (bigint, foreign key → taxes.id, nullable)
- `quantity` (float 8,2)
- `unit_price` (double)
- `single_unit_price` (double)
- `tax_rate` (float 8,2, default 0)
- `discount_rate` (float 8,2, nullable)
- `total_tax` (double, nullable)
- `total_discount` (double, nullable)
- `subtotal` (double)
- `mrp` (double, nullable) - Maximum Retail Price
- `created_at` (timestamp)
- `updated_at` (timestamp)

**Relationships**:
- belongsTo: Order, Product, Unit, Tax
- hasMany: OrderItemTaxes

**Computed Attributes**:
- `xid`: Hashed ID
- `x_order_id`: Hashed order ID
- `x_product_id`: Hashed product ID
- `x_unit_id`: Hashed unit ID
- `x_tax_id`: Hashed tax ID

### 6.2 Data Relationships

```
OrderItem
  ├── Order (parent)
  │   ├── Warehouse
  │   ├── FromWarehouse
  │   ├── User (customer/supplier)
  │   └── StaffMember
  ├── Product
  │   ├── Category
  │   ├── Brand
  │   ├── Unit
  │   └── ProductDetails
  ├── Unit
  └── Tax
```

### 6.3 Data Validation Rules

- **quantity**: Required, numeric, > 0
- **unit_price**: Required, numeric, >= 0
- **single_unit_price**: Required, numeric, >= 0
- **tax_rate**: Numeric, 0-100
- **discount_rate**: Numeric, 0-100
- **subtotal**: Required, numeric, >= 0
- **order_id**: Required, must exist in orders table
- **product_id**: Required, must exist in products table
- **user_id**: Required, must exist in users table

---

## 7. Non-Functional Requirements

### 7.1 Performance
- API response time: < 500ms for standard queries
- API response time: < 2s for complex aggregations (sales summary)
- Support concurrent users: 100+
- Database query optimization required
- Implement caching for frequently accessed data

### 7.2 Scalability
- Support millions of order items
- Horizontal scaling capability
- Database partitioning by date/warehouse
- Efficient indexing strategy

### 7.3 Security
- HTTPS required for all API calls
- JWT token authentication
- Role-based access control (RBAC)
- Data encryption at rest
- Audit logging for all operations
- SQL injection prevention
- XSS protection

### 7.4 Reliability
- System uptime: 99.9%
- Automated backups: Daily
- Disaster recovery plan
- Error handling and logging
- Transaction rollback on failures

### 7.5 Usability
- Intuitive user interface
- Responsive design (mobile-friendly)
- Multi-language support (Indonesian, English)
- Consistent UI/UX patterns
- Helpful error messages

### 7.6 Maintainability
- Clean code architecture
- Comprehensive documentation
- Unit test coverage: > 80%
- Integration test coverage
- Code review process
- Version control (Git)

---

## 8. Acceptance Criteria

### 8.1 Feature Acceptance Criteria

#### AC1: Order Items Listing
- [ ] User can view list of order items
- [ ] Items are filtered by user's warehouse by default
- [ ] User can filter by specific warehouse
- [ ] User can filter by date range
- [ ] Results are paginated
- [ ] Results include product, order, and unit details
- [ ] All IDs are properly hashed in responses

#### AC2: Product Sales Summary
- [ ] User can generate sales summary by product
- [ ] Summary includes total units sold
- [ ] Summary includes total sales revenue
- [ ] User can filter by date range
- [ ] User can filter by category
- [ ] Results are grouped by product
- [ ] Product details and pricing are included

#### AC3: Multi-Warehouse Support
- [ ] Items from both warehouse_id and from_warehouse_id are included
- [ ] User can filter by specific warehouse
- [ ] Transfer items appear in both source and destination views
- [ ] Warehouse filtering uses OR logic correctly

#### AC4: Date Range Filtering
- [ ] User can specify start and end dates
- [ ] Date format is validated
- [ ] Filtering is inclusive of both dates
- [ ] Invalid dates are handled gracefully

#### AC5: Custom Sorting
- [ ] User can specify custom sort order
- [ ] Sorting is applied correctly
- [ ] Invalid sort expressions are handled
- [ ] Default sorting is applied when not specified

### 8.2 Technical Acceptance Criteria

- [ ] All API endpoints return proper HTTP status codes
- [ ] Error responses include meaningful messages
- [ ] Authentication is required for all endpoints
- [ ] Authorization is enforced based on user roles
- [ ] Company scope is applied to all queries
- [ ] Database queries are optimized
- [ ] N+1 query problems are avoided
- [ ] Response times meet performance requirements
- [ ] All data is properly validated
- [ ] Security best practices are followed

### 8.3 Testing Acceptance Criteria

- [ ] Unit tests cover all controller methods
- [ ] Integration tests cover API endpoints
- [ ] Test coverage is > 80%
- [ ] Edge cases are tested
- [ ] Error scenarios are tested
- [ ] Performance tests are conducted
- [ ] Security tests are performed

---

## 9. Code References

### 9.1 Controller Implementation
**File**: `app/Http/Controllers/Api/OrderItemController.php`

**Key Methods**:
- `modifyIndex($query)`: Main query modification method (lines 16-70)
  - Warehouse filtering (lines 21-36)
  - Date range filtering (lines 39-46)
  - Product sales summary (lines 49-63)
  - Custom sorting (lines 65-67)

**Code Snippet**:
```php
public function modifyIndex($query)
{
    $request = request();
    $warehouse = warehouse();

    // Warehouse filtering
    if(isset($request->warehouse_id)){
        $warehouse_id = $this->getIdFromHash($request->warehouse_id);

        $query = $query->join('orders', 'orders.id', '=', 'order_items.order_id')
            ->where(function ($query) use ($warehouse_id) {
                $query->where('orders.warehouse_id', $warehouse_id)
                    ->orWhere('orders.from_warehouse_id', $warehouse_id);
            });
    }

    // Date range filtering
    if ($request->has('dates') && $request->dates != "") {
        $dates = explode(',', $request->dates);
        $startDate = $dates[0];
        $endDate = $dates[1];

        $query = $query->whereRaw('orders.order_date >= ?', [$startDate])
            ->whereRaw('orders.order_date <= ?', [$endDate]);
    }

    // Product sales summary
    if ($request->has('product_sales_summary') && $request->product_sales_summary) {
        $this->modifySelect = true;

        $query = $query->join('products', 'products.id', '=', 'order_items.product_id')
            ->where('orders.order_type', 'sales')
            ->groupBy('order_items.product_id')
            ->selectRaw("order_items.product_id, products.name, products.item_code, sum(order_items.quantity) as unit_sold, sum(order_items.subtotal) as total_sales_price")
            ->with('product:id,name,image,unit_id', 'product.unit:id,name,short_name', 'product.details:id,product_id,purchase_price,sales_price');

        if ($request->has('category_id') && $request->category_id != '') {
            $categoryId = $this->getIdFromHash($request->category_id);
            $query = $query->where('products.category_id', '=', $categoryId);
        }
    }

    // Custom sorting
    if ($request->has('custom_sorter') && $request->custom_sorter != '') {
        $query->orderByRaw($request->custom_sorter);
    }

    return $query;
}
```

### 9.2 Model Implementation
**File**: `app/Models/OrderItem.php`

**Key Features**:
- Hash casting for IDs (lines 32-49)
- Relationships (lines 56-74)
- Filterable fields (line 22)

**Code Snippet**:
```php
protected $casts = [
    'user_id' => Hash::class . ':hash',
    'order_id' => Hash::class . ':hash',
    'product_id' => Hash::class . ':hash',
    'unit_id' => Hash::class . ':hash',
    'tax_id' => Hash::class . ':hash',
    'quantity' => 'double',
    'mrp' => 'double',
    'unit_price' => 'double',
    'single_unit_price' => 'double',
    'tax_rate' => 'double',
    'discount_rate' => 'double',
    'total_tax' => 'double',
    'total_discount' => 'double',
    'subtotal' => 'double',
    'total_sales_price' => 'double',
    'unit_sold' => 'double',
];

public function product()
{
    return $this->belongsTo(Product::class, 'product_id', 'id');
}

public function order()
{
    return $this->belongsTo(Order::class, 'order_id', 'id');
}

public function unit()
{
    return $this->belongsTo(Unit::class, 'unit_id', 'id');
}
```

### 9.3 Related Models
**File**: `app/Models/Order.php`

**Key Relationships**:
- items() - hasMany OrderItem (lines 69-72)
- warehouse() - belongsTo Warehouse (lines 94-97)
- fromWarehouse() - belongsTo Warehouse (lines 99-102)

---

## 10. Appendices

### 10.1 Glossary

- **Penerimaan Barang**: Goods Receipt (Indonesian)
- **Order Item**: Individual line item in an order
- **Warehouse**: Physical location for storing inventory
- **QC**: Quality Control
- **MRP**: Maximum Retail Price
- **Hashed ID**: Obfuscated ID using Hashids library
- **Multi-tenant**: System supporting multiple companies/organizations
- **N+1 Query**: Performance issue where related data causes multiple database queries

### 10.2 Related Documents

- `INVENTORY_IN_ANALYSIS.md` - Inventory-In workflow analysis
- `QC_PICKING_ANALYSIS.md` - QC and picking process analysis
- `tests/Feature/Api/OrderItemControllerTest.php` - Test specifications
- Parent Issue #1 - Documentation Standards (FSD & TSD Template)

### 10.3 API Endpoint Summary

| Endpoint | Method | Purpose | Parameters |
|----------|--------|---------|------------|
| `/api/v1/order-items` | GET | List order items | warehouse_id, dates, offset, limit |
| `/api/v1/order-items?product_sales_summary=true` | GET | Sales summary | dates, category_id, warehouse_id |

### 10.4 Database Schema Summary

**order_items table**:
- Primary key: id
- Foreign keys: order_id, product_id, user_id, unit_id, tax_id
- Indexes: order_id, product_id, created_at
- Relationships: Order, Product, Unit, Tax

**orders table**:
- Primary key: id
- Foreign keys: warehouse_id, from_warehouse_id, user_id
- Key fields: order_type, order_date, order_status
- Relationships: OrderItems, Warehouse, FromWarehouse, User

### 10.5 Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-03 | System | Initial FSD creation based on OrderItemController analysis |

---

**Document Status**: Complete
**Review Status**: Pending Review
**Approval Status**: Pending Approval
**Test Implementation**: tests/Feature/Api/OrderItemControllerTest.php

---

## Notes for Developers

This FSD document should be used in conjunction with:
1. The test file (`tests/Feature/Api/OrderItemControllerTest.php`) which validates all use cases
2. The source code (`app/Http/Controllers/Api/OrderItemController.php`)
3. Related analysis documents (INVENTORY_IN_ANALYSIS.md, QC_PICKING_ANALYSIS.md)

When implementing new features or modifications:
1. Update this FSD document first
2. Update the test specifications
3. Implement the code changes
4. Verify all acceptance criteria are met
5. Update the change log

For questions or clarifications, refer to parent issue #1 for documentation standards.
