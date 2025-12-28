# QC Picking Page Analysis

## Overview
The QC (Quality Control) Picking page is a workflow management system for tracking and completing order picking operations. It displays orders in "picking" status and allows users to view details and complete QC checks.

## Route
- **URL**: `/admin/order-fullfillment/qc-picking`
- **Route Name**: `admin.order_fullfillment.qc_picking`
- **Component**: `resources/js/main/views/order-fullfillment/qc-picking/index.vue`

## Page Structure

### Main Components

1. **Index Page** (`index.vue`)
   - Lists all QC picking orders
   - Search by invoice number
   - Table view with order details
   - View/Edit drawer for order details

2. **AddEdit Component** (`AddEdit.vue`)
   - Drawer that opens when clicking "View" button
   - Shows order details and items
   - Allows completing QC picking
   - Export to PDF functionality

3. **View Component** (`View.vue`)
   - Product details drawer (not currently used in QC picking flow)

## Data Flow

### Frontend → Backend

#### 1. List Orders (Index)
**API Endpoint**: `GET /api/v1/qc-picking`

**Request Parameters**:
- `invoice_number` (optional) - Filter by invoice number
- `offset` (optional) - Pagination offset
- `limit` (optional) - Pagination limit (default: 10)
- `order` (optional) - Sort order

**Response Structure**:
```json
{
  "data": [
    {
      "invoice_number": "INV-001",
      "date": "2024-01-01",
      "user_name": "John Doe",
      "order_status": "picking",
      "items": [
        {
          "item_id": "ITEM-001",
          "quantity": 10,
          "quantity_scanned": 8,
          "picker_by_name": "Picker Name"
        }
      ]
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

#### 2. Complete QC Picking
**API Endpoint**: `POST /api/v1/delivery-order`

**Request Body**:
```json
{
  "invoice_number": "INV-001"
}
```

**Backend Action**: Updates order status from "picking" to "qc"

#### 3. Export PDF
**API Endpoint**: `GET /admin/order-fullfillment/qc-picking/export?code={invoice_number}&type=pdf`

**Response**: PDF file download

## Backend Implementation

### Controller: `PickingAssignmentController`

#### Key Methods:

1. **`qcPicking(QcPickingRequest $request)`** (Line 202-259)
   - Fetches orders with status "picking"
   - Joins with warehouses and users
   - Filters by invoice_number if provided
   - Returns paginated results with order items
   - Each order includes its items with:
     - Item ID
     - Quantity
     - Quantity scanned
     - Picker by name

2. **`qcPickingComplete(Request $request)`** (Line 423-427)
   - Updates order status from "picking" to "qc"
   - Called when user clicks "Complete QC" button

3. **`qcPickingExport()`** (Line 116-150)
   - Generates PDF export
   - Fetches order and items
   - Formats picker_by_name (JSON array to comma-separated string)
   - Returns PDF download

## Database Schema

### Orders Table
- `invoice_number` - Order invoice number
- `order_date` - Order date
- `order_status` - Status: "picking" → "qc" → ...
- `user_id` - Customer/User ID
- `warehouse_id` - Warehouse ID
- `notes` - Order notes

### Order Items Table
- `order_id` - Foreign key to orders
- `product_id` - Product ID
- `quantity` - Required quantity
- `quantity_scanned` - Scanned quantity (for picking)
- `picker_by` - JSON array of picker user IDs
- `picker_by_name` - JSON array of picker names

## Frontend Features

### Table Columns
1. **Invoice Number** - Sortable
2. **User Name** - Customer name
3. **Order Status** - Status badge (open/complete)
4. **Note** - Popover with order notes
5. **Priority** - Priority tag with color
6. **Date** - Created date
7. **Action** - View button (eye icon)

### Search Functionality
- Search by invoice number
- Real-time filtering
- Updates table on search

### View/Edit Drawer
When clicking "View" button, opens drawer showing:

**Basic Details Tab**:
- Invoice number
- User name
- Date
- Status
- Items table with:
  - Item ID
  - Quantity
  - Quantity Scanned
  - Picker name

**Actions**:
- **Complete QC** - Marks order as QC complete
- **Export** - Downloads PDF
- **Close** - Closes drawer

## Workflow

### Order Status Flow
```
sales_order → picking → qc → [next status]
```

1. **Sales Order Created** - Initial order status
2. **Picking Status** - Order assigned for picking
3. **QC Status** - After QC picking is completed
4. **Next Status** - Continues to next workflow stage

### QC Picking Process

1. **View Orders in Picking Status**
   - Page shows all orders with `order_status = 'picking'`
   - User can search by invoice number

2. **View Order Details**
   - Click "View" button on an order
   - Drawer opens showing:
     - Order information
     - List of items with picking details
     - Quantity vs quantity scanned

3. **Complete QC**
   - Click "Complete QC" button
   - Order status changes from "picking" to "qc"
   - Order moves to next workflow stage

4. **Export PDF**
   - Click "Export" button
   - Downloads PDF with order and item details

## Key Data Points

### Order Information
- Invoice number
- Customer name
- Order date
- Warehouse
- Status
- Notes
- Priority

### Item Information
- Item ID (product item_id)
- Required quantity
- Scanned quantity
- Picker name(s) - Can be multiple pickers

## Session Usage

The controller uses session to get current user:
```php
$user = Session::get('user');
```

This is used for:
- Tracking who assigned picking
- Recording picker information
- User context for operations

## PDF Export

The PDF export includes:
- Invoice number header
- Customer name
- Order date
- Order status
- Table of items with:
  - Item ID
  - Quantity
  - Quantity scanned
  - Picker name(s)

## Filtering & Pagination

- **Filtering**: By invoice number (search box)
- **Pagination**: Offset/limit based
- **Sorting**: By ID, invoice number, or order date

## Status Display

- **Status "1" or "open"**: Yellow tag
- **Status "2" or "complete"**: Green tag
- **Status "picking"**: Green tag

## Notes Feature

- Orders can have notes
- Notes displayed in popover on table
- Click message icon to view note

## Priority Feature

- Orders have priority levels
- Displayed as colored tags
- Color coding based on priority value

## Integration Points

1. **Order Management** - Part of order fulfillment workflow
2. **Picking Assignment** - Related to picking assignment feature
3. **Delivery Orders** - Completing QC moves to delivery order stage
4. **PDF Generation** - Uses mPDF for PDF exports

## Current Implementation Notes

1. **Session Dependency**: Uses `Session::get('user')` for user context
2. **Status Management**: Order status transitions: picking → qc
3. **Multiple Pickers**: Supports multiple pickers per item (JSON arrays)
4. **Quantity Tracking**: Tracks both required and scanned quantities
5. **Export Format**: PDF export in landscape A4 format

## API Endpoints Used

- `GET /api/v1/qc-picking` - List orders
- `POST /api/v1/delivery-order` - Complete QC
- `GET /admin/order-fullfillment/qc-picking/export` - Export PDF

## Frontend State Management

- Uses Vuex store for authentication
- Uses composables for:
  - CRUD operations (`crud.js`)
  - Common utilities (`common.js`)
  - API calls (`apiAdmin.js`)

## Error Handling

- Try-catch blocks in AddEdit component
- Error state display
- Validation in request classes
- API error handling via axios interceptors

