# Inventory-In List Page Analysis

## Overview
The Inventory-In list page displays all inventory-in orders (stock receipts/purchases) in a table format with filtering, sorting, and management capabilities.

## Route
- **URL**: `/admin/stock/inventory-in`
- **Route Name**: `admin.inventory_in.index`
- **Component**: `resources/js/main/views/stock-management/inventory/index.vue`
- **Order Type**: `inventory_in`

## Page Structure

### Main Components

1. **Index Page** (`index.vue`)
   - Lists all inventory-in orders
   - Filtering and search capabilities
   - Row selection for bulk operations
   - Create new order button
   - Import functionality

2. **OrderTable Component** (`OrderTable.vue`)
   - Displays orders in a table format
   - Handles pagination, sorting, and filtering
   - Row selection
   - Action buttons (view, edit, delete)

## Features

### 1. Header Section
- **Page Title**: "Inventory In" (translated)
- **Breadcrumb**: Dashboard > Inventory In

### 2. Action Buttons (Top Left)
- **Add Button**: Creates new inventory-in order
  - Route: `admin.inventory_in.create`
  - Permission: `inventory_in_create` or `admin`
  - Icon: PlusOutlined

- **Import Button**: QueueImport component
  - Allows bulk import via Excel
  - Sample file: `window.config.inventory_in_sample_file`
  - Context: `inventory_in`

- **Delete Button**: Bulk delete selected orders
  - Only visible when rows are selected
  - Permission: `inventory_in_view` or `admin`
  - Icon: DeleteOutlined

### 3. Filter Section (Top Right)

**Search Filters:**
- **Invoice Number Search**: Text input for searching by invoice number
- **Item ID Search**: Text input for searching by product item ID
- **User Select**: Dropdown to filter by supplier/user
  - Fetches from `suppliers?limit=10000`
  - Displays user code or name
- **Date Range Picker**: Filter orders by date range

**Hidden Filters (display:none):**
- **Status Select**: Filter by order status (Ordered, Picking, QC)
- **Priority Select**: Filter by priority (ditunggu, pesawat, segera, normal)

### 4. Table Columns

**Displayed Columns:**
1. **Invoice Number** - Clickable link to view order details
2. **Inventory In Date** - Formatted order date
3. **User** - Supplier/user name with avatar
4. **Inventory In Status** - Order status badge
5. **Total Amount** - Formatted currency
6. **Action** - Dropdown menu with actions

**Table Features:**
- **Row Selection**: Checkboxes for bulk operations
- **Sorting**: All columns are sortable
- **Pagination**: Default 10 rows per page (configurable)
- **Loading State**: Shows loading indicator during data fetch
- **Bordered**: Table has borders

### 5. Table Actions (Dropdown Menu)

For each order row, actions available:
- **View**: Opens order details drawer
- **Edit**: Navigate to edit page (`admin.inventory_in.edit`)
- **Delete**: Delete order (if payment_status == 'unpaid')
- **View Payments**: View payment details
- **Add Payment**: Add payment to order
- **Download Invoice**: Download invoice PDF
- **Print Invoice**: Print invoice

## Data Flow

### Frontend → Backend

#### 1. List Orders
**API Endpoint**: `GET /api/v1/inventory_in`

**Request Parameters:**
- `offset` - Pagination offset
- `limit` - Pagination limit (default: 10)
- `order` - Sort order
- `searchColumn` - Column to search
- `searchString` - Search text
- `user_id` - Filter by user (hashed)
- `dates` - Date range filter
- `item_id` - Filter by item ID

**Response Structure:**
```json
{
  "data": [
    {
      "xid": "hashed_id",
      "invoice_number": "INV-001",
      "order_date": "2024-01-01",
      "user": {
        "xid": "hashed_user_id",
        "name": "Supplier Name",
        "code": "SUP001"
      },
      "order_status": "ordered",
      "total": 1000000,
      "warehouse": {
        "xid": "hashed_warehouse_id",
        "name": "Warehouse Name"
      }
    }
  ],
  "meta": {
    "paging": {
      "links": {
        "next": "...",
        "previous": "..."
      },
      "total": 100
    }
  }
}
```

#### 2. Delete Order
**API Endpoint**: `DELETE /api/v1/inventory_in/{id}`

#### 3. Bulk Delete
**API Endpoint**: Multiple DELETE requests for each selected order

## Backend Implementation

### Controller: `PurchaseController`

**Key Methods:**
- Uses `OrderTraits` for common order operations
- Model: `Order` with `order_type = 'purchases'` (inventory_in uses purchases model)
- Standard CRUD operations via `ApiBaseController`

**Special Methods:**
- `indexPlacementInItem()` - Get placement in items
- `indexPlacementInItemHistory()` - Get placement in history
- `completeWithNote()` - Complete item with note
- `scannedBarcode()` - Get scanned barcode details
- `barcode()` - Get barcode details
- `barcodeRegister()` - Register barcode

## Frontend State Management

### Filters Object
```javascript
{
  payment_status: "all",
  user_id: undefined,
  dates: [],
  searchColumn: "invoice_number",
  searchString: "",
  warehouse_id: undefined,
  item_id: "",
  status: undefined,
  priority: undefined
}
```

### Data Fetched on Mount
1. **Users**: Fetches suppliers (`suppliers?limit=10000`)
2. **Warehouses**: Fetches warehouses (`warehouses?limit=10000`)
3. **Sample File URL**: From `window.config.inventory_in_sample_file`

## Table Configuration

### Columns Setup
Columns are dynamically set up based on `orderType`:
- Invoice Number
- Inventory In Date
- User (supplier)
- Inventory In Status
- Total Amount
- Action

### Pagination
- Default page size: 10 rows
- Configurable via `perPageItems` prop (not currently used)
- Server-side pagination

### Sorting
- All columns support sorting
- Server-side sorting
- Sorter field mapping for complex columns

## User Permissions

**Required Permissions:**
- `inventory_in_view` - View list
- `inventory_in_create` - Create new order
- `inventory_in_edit` - Edit order
- `inventory_in_delete` - Delete order
- `admin` - Full access

## Integration Points

1. **Order Management**: Part of stock management system
2. **User Management**: Uses suppliers for user selection
3. **Warehouse Management**: Filters by warehouse
4. **Payment System**: View/add payments to orders
5. **Invoice System**: Download/print invoices
6. **Barcode System**: Links to barcode scanning pages

## Related Routes

- **Create**: `/admin/stock/inventory-in/create`
- **Edit**: `/admin/stock/inventory-in/edit/:id`
- **Item Details**: `/admin/stock/inventory-in/item/:id`
- **Barcode**: `/admin/stock/inventory-in/barcode/:id`

## Key Features

1. **Search & Filter**:
   - Search by invoice number
   - Search by item ID
   - Filter by user/supplier
   - Filter by date range
   - Filter by status (hidden)
   - Filter by priority (hidden)

2. **Bulk Operations**:
   - Select multiple rows
   - Bulk delete selected orders

3. **Import/Export**:
   - Import orders via Excel
   - Sample file available

4. **Order Management**:
   - View order details
   - Edit orders
   - Delete orders (if unpaid)
   - View/add payments
   - Download/print invoices

5. **Navigation**:
   - Click invoice number to view details
   - Click user to view user info
   - Action dropdown for all operations

## Data Model

### Order Fields
- `invoice_number` - Order invoice number
- `order_date` - Order date
- `user_id` - Supplier/user ID
- `warehouse_id` - Warehouse ID
- `order_status` - Status (ordered, picking, qc, etc.)
- `payment_status` - Payment status (paid, unpaid, partial)
- `total` - Total amount
- `subtotal` - Subtotal
- `tax_amount` - Tax amount
- `discount` - Discount
- `shipping` - Shipping cost
- `notes` - Order notes
- `priority` - Priority level

### Order Items
- Product details
- Quantity
- Unit price
- Tax
- Discount
- Subtotal

## Status Flow

Order statuses typically flow:
```
ordered → picking → qc → [completed]
```

## Notes

1. **Order Type**: Inventory-in uses `order_type = 'purchases'` in the database
2. **User Type**: Uses `suppliers` endpoint for user selection
3. **Pagination**: Default 10 rows, can be changed via `perPageItems` prop
4. **Permissions**: Role-based access control for all operations
5. **Warehouse Scope**: Orders are scoped by company and warehouse

## Component Dependencies

- `OrderTable.vue` - Main table component
- `DateRangePicker.vue` - Date range filter
- `AdminPageHeader.vue` - Page header
- `QueueImport.vue` - Import functionality
- `common.js` composable - Common utilities
- `fields.js` - Field definitions and configurations

## API Endpoints Used

- `GET /api/v1/inventory_in` - List orders
- `GET /api/v1/suppliers` - Get suppliers/users
- `GET /api/v1/warehouses` - Get warehouses
- `DELETE /api/v1/inventory_in/{id}` - Delete order
- `GET /api/v1/inventory_in/{id}` - Get order details

