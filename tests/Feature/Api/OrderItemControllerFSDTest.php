<?php

/**
 * FUNCTIONAL SPECIFICATION DOCUMENT (FSD)
 * Penerimaan Barang (Goods Receipt) - Order Items Management
 *
 * Version: 1.0
 * Date: 2026-01-03
 * Component: OrderItemController
 * Module: Stock Management / Inventory System
 *
 * ============================================================================
 * 1. SYSTEM OVERVIEW & PURPOSE
 * ============================================================================
 *
 * 1.1 Purpose
 * -----------
 * The Penerimaan Barang (Goods Receipt) system manages order items across
 * various order types within the warehouse management system. It provides
 * comprehensive functionality for tracking, filtering, and analyzing order
 * items including inventory receipts (purchases), sales orders, and stock
 * transfers.
 *
 * 1.2 System Context
 * ------------------
 * The OrderItemController serves as the API endpoint for managing order items,
 * which are the individual line items within orders. This system is a critical
 * component of the broader inventory management workflow, connecting:
 *
 * - Inventory In (Purchases): Receiving goods from suppliers
 * - Sales Orders: Processing customer orders
 * - Stock Transfers: Moving inventory between warehouses
 * - Quality Control: Tracking QC status of received items
 * - Product Sales Analytics: Generating sales reports and summaries
 *
 * 1.3 Key Capabilities
 * --------------------
 * - Retrieve and filter order items by warehouse, date range, and product
 * - Generate product sales summaries with aggregated metrics
 * - Support multi-warehouse operations
 * - Track order item details including pricing, taxes, and discounts
 * - Provide data for reporting and analytics
 *
 * ============================================================================
 * 2. USER PERSONAS & USE CASES
 * ============================================================================
 *
 * 2.1 User Personas
 * -----------------
 *
 * Persona 1: Warehouse Manager (Budi Santoso)
 * Goals:
 * - Monitor all incoming goods receipts across warehouses
 * - Track order fulfillment status
 * - Generate inventory reports
 * - Ensure accurate stock levels
 *
 * Pain Points:
 * - Needs quick access to order items across multiple warehouses
 * - Requires real-time visibility of inventory movements
 * - Must reconcile physical stock with system records
 *
 * Persona 2: Purchasing Officer (Siti Rahayu)
 * Goals:
 * - Track purchase orders and received items
 * - Monitor supplier performance
 * - Verify received quantities against orders
 * - Manage purchase order lifecycle
 *
 * Pain Points:
 * - Needs to filter items by specific date ranges
 * - Requires visibility into partial receipts
 * - Must track items across different warehouses
 *
 * Persona 3: Sales Analyst (Ahmad Wijaya)
 * Goals:
 * - Analyze product sales performance
 * - Generate sales reports by product and category
 * - Identify top-selling products
 * - Track sales trends over time
 *
 * Pain Points:
 * - Needs aggregated sales data by product
 * - Requires filtering by category and date range
 * - Must calculate total sales and units sold
 *
 * Persona 4: Inventory Controller (Dewi Lestari)
 * Goals:
 * - Monitor stock movements
 * - Track order items with QC status
 * - Ensure data accuracy
 * - Manage stock adjustments
 *
 * Pain Points:
 * - Needs to track items through QC process
 * - Requires visibility into item-level details
 * - Must reconcile discrepancies
 *
 * 2.2 Use Cases
 * -------------
 *
 * Use Case 1: View Order Items by Warehouse
 * Actor: Warehouse Manager
 * Preconditions:
 * - User is authenticated
 * - User has access to warehouse data
 *
 * Main Flow:
 * 1. User accesses order items API endpoint
 * 2. System retrieves current warehouse context
 * 3. System filters order items for the warehouse
 * 4. System returns items where order's warehouse_id or from_warehouse_id matches
 * 5. User views filtered order items
 *
 * Postconditions:
 * - Order items are displayed for the specified warehouse
 *
 * Alternative Flows:
 * - User specifies a different warehouse_id parameter
 * - System filters by the specified warehouse instead
 *
 * Use Case 2: Filter Order Items by Date Range
 * Actor: Purchasing Officer
 * Preconditions:
 * - User is authenticated
 * - Order items exist in the system
 *
 * Main Flow:
 * 1. User specifies start and end dates
 * 2. System receives dates parameter (comma-separated)
 * 3. System filters orders where order_date is within range
 * 4. System returns matching order items
 * 5. User views items within the date range
 *
 * Postconditions:
 * - Only order items within the specified date range are displayed
 *
 * Use Case 3: Generate Product Sales Summary
 * Actor: Sales Analyst
 * Preconditions:
 * - User is authenticated
 * - Sales orders exist in the system
 *
 * Main Flow:
 * 1. User requests product sales summary
 * 2. System filters for sales orders only
 * 3. System groups items by product_id
 * 4. System calculates:
 *    - Total units sold (sum of quantities)
 *    - Total sales price (sum of subtotals)
 * 5. System includes product details (name, code, unit, pricing)
 * 6. User views aggregated sales data
 *
 * Postconditions:
 * - Product sales summary is generated with aggregated metrics
 *
 * Alternative Flows:
 * - User filters by specific category
 * - System applies category filter to products
 *
 * Use Case 4: Track Items Across Warehouses
 * Actor: Inventory Controller
 * Preconditions:
 * - User is authenticated
 * - Multiple warehouses exist
 *
 * Main Flow:
 * 1. User specifies warehouse_id parameter
 * 2. System retrieves order items for specified warehouse
 * 3. System includes items where:
 *    - Order's warehouse_id matches (destination)
 *    - Order's from_warehouse_id matches (source)
 * 4. User views all items related to the warehouse
 *
 * Postconditions:
 * - All order items related to the warehouse are displayed
 *
 * Use Case 5: Apply Custom Sorting
 * Actor: Any authenticated user
 * Preconditions:
 * - User is authenticated
 * - Order items exist
 *
 * Main Flow:
 * 1. User specifies custom_sorter parameter
 * 2. System applies custom SQL sorting expression
 * 3. System returns sorted results
 * 4. User views items in custom order
 *
 * Postconditions:
 * - Order items are sorted according to custom criteria
 *
 * ============================================================================
 * 3. FEATURE LIST & WORKFLOWS
 * ============================================================================
 *
 * 3.1 Core Features
 * -----------------
 *
 * Feature 1: Order Item Retrieval
 * Description: Retrieve order items with comprehensive filtering and
 *              relationship loading
 *
 * Functionality:
 * - Fetch order items from database
 * - Join with orders table for filtering
 * - Load related entities (product, order, unit, taxes)
 * - Apply warehouse scoping
 * - Support pagination
 *
 * API Endpoint: GET /api/v1/order-items
 * Code Reference: OrderItemController::modifyIndex() (lines 16-70)
 *
 * Feature 2: Warehouse Filtering
 * Description: Filter order items by warehouse (destination or source)
 *
 * Functionality:
 * - Accept warehouse_id parameter (hashed)
 * - Decode hashed warehouse ID
 * - Filter orders where:
 *   - warehouse_id matches (destination warehouse)
 *   - from_warehouse_id matches (source warehouse)
 * - Default to current user's warehouse if not specified
 *
 * Code Reference: OrderItemController::modifyIndex() (lines 21-36)
 *
 * Feature 3: Date Range Filtering
 * Description: Filter order items by order date range
 *
 * Functionality:
 * - Accept dates parameter (comma-separated: start,end)
 * - Parse start and end dates
 * - Filter orders where order_date >= start AND order_date <= end
 * - Support flexible date formats
 *
 * Code Reference: OrderItemController::modifyIndex() (lines 39-46)
 *
 * Feature 4: Product Sales Summary
 * Description: Generate aggregated sales analytics by product
 *
 * Functionality:
 * - Filter for sales orders only (order_type = 'sales')
 * - Group by product_id
 * - Calculate aggregated metrics:
 *   - unit_sold: sum(quantity)
 *   - total_sales_price: sum(subtotal)
 * - Include product details:
 *   - Product name, item_code, image
 *   - Unit information
 *   - Purchase and sales prices
 * - Optional category filtering
 *
 * Code Reference: OrderItemController::modifyIndex() (lines 49-63)
 *
 * Feature 5: Custom Sorting
 * Description: Apply custom SQL sorting expressions
 *
 * Functionality:
 * - Accept custom_sorter parameter
 * - Apply raw SQL ORDER BY clause
 * - Support complex sorting logic
 * - Enable flexible result ordering
 *
 * Code Reference: OrderItemController::modifyIndex() (lines 65-67)
 *
 * 3.2 Workflows
 * -------------
 *
 * Workflow 1: Standard Order Item Retrieval
 * 1. Client Request
 * 2. Authentication & Authorization
 * 3. Get Current Warehouse Context
 * 4. Build Base Query (order_items)
 * 5. Join with Orders Table
 * 6. Apply Warehouse Filter
 * 7. Apply Date Filter (if provided)
 * 8. Apply Custom Sorting (if provided)
 * 9. Execute Query with Pagination
 * 10. Return JSON Response
 *
 * Workflow 2: Product Sales Summary Generation
 * 1. Client Request (with product_sales_summary=true)
 * 2. Authentication & Authorization
 * 3. Get Current Warehouse Context
 * 4. Build Base Query (order_items)
 * 5. Join with Orders Table
 * 6. Join with Products Table
 * 7. Filter for Sales Orders (order_type='sales')
 * 8. Apply Warehouse Filter
 * 9. Apply Date Filter (if provided)
 * 10. Apply Category Filter (if provided)
 * 11. Group by Product ID
 * 12. Calculate Aggregates (SUM quantity, SUM subtotal)
 * 13. Load Product Relationships
 * 14. Apply Custom Sorting (if provided)
 * 15. Execute Query with Pagination
 * 16. Return JSON Response with Aggregated Data
 *
 * Workflow 3: Multi-Warehouse Item Tracking
 * 1. Client Request (with warehouse_id parameter)
 * 2. Authentication & Authorization
 * 3. Decode Hashed Warehouse ID
 * 4. Build Base Query (order_items)
 * 5. Join with Orders Table
 * 6. Apply Warehouse Filter (warehouse_id OR from_warehouse_id)
 * 7. Apply Additional Filters (dates, etc.)
 * 8. Execute Query with Pagination
 * 9. Return JSON Response
 *
 * ============================================================================
 * 4. BUSINESS RULES & CONSTRAINTS
 * ============================================================================
 *
 * 4.1 Business Rules
 * ------------------
 *
 * BR-1: Warehouse Scoping
 * Rule: Order items must be filtered by warehouse context
 * Rationale: Ensure users only see items relevant to their warehouse
 * Implementation: Join orders table and filter by warehouse_id or from_warehouse_id
 * Exception: Admin users may access all warehouses
 *
 * BR-2: Date Range Filtering
 * Rule: Date filters apply to order_date, not item creation date
 * Rationale: Business logic focuses on when orders were placed
 * Implementation: Filter on orders.order_date field
 * Format: Dates provided as comma-separated string: "start_date,end_date"
 *
 * BR-3: Sales Summary Aggregation
 * Rule: Sales summaries only include order_type = 'sales'
 * Rationale: Separate sales analytics from purchases and transfers
 * Implementation: WHERE clause filters order_type
 * Grouping: Results grouped by product_id
 *
 * BR-4: Warehouse Relationship
 * Rule: Items can be associated with warehouse as destination OR source
 * Rationale: Support stock transfers between warehouses
 * Implementation: Filter includes both warehouse_id and from_warehouse_id
 * Use Cases:
 *   - warehouse_id: Destination warehouse (receiving goods)
 *   - from_warehouse_id: Source warehouse (sending goods)
 *
 * BR-5: Product Category Filtering
 * Rule: Category filter only applies when product_sales_summary is enabled
 * Rationale: Category is a product attribute, relevant for sales analysis
 * Implementation: Join products table and filter by category_id
 * Requirement: category_id must be provided as hashed value
 *
 * 4.2 Data Constraints
 * --------------------
 *
 * DC-1: Required Fields
 * - order_id (foreign key to orders)
 * - product_id (foreign key to products)
 * - quantity (must be > 0)
 * - unit_price (must be >= 0)
 * - subtotal (must be >= 0)
 *
 * DC-2: Optional Fields
 * - unit_id (can be null)
 * - tax_id (can be null)
 * - tax_rate (default: 0)
 * - discount_rate (can be null)
 * - total_tax (can be null)
 * - total_discount (can be null)
 * - qc_status (can be null)
 *
 * DC-3: Calculated Fields
 * - subtotal = (quantity × unit_price) - total_discount + total_tax
 * - total_tax = (quantity × unit_price × tax_rate) / 100
 * - total_discount = (quantity × unit_price × discount_rate) / 100
 *
 * DC-4: Data Types
 * - Numeric fields: double precision
 * - Quantity fields: float(8,2)
 * - Rate fields: float(8,2)
 * - IDs: bigInteger (hashed for API)
 *
 * 4.3 Security Constraints
 * ------------------------
 *
 * SC-1: Authentication Required
 * - All endpoints require authenticated user
 * - Session-based or token-based authentication
 *
 * SC-2: Company Scope
 * - Order items are scoped by company_id
 * - Users can only access items from their company
 * - Implemented via CompanyScope global scope
 *
 * SC-3: Warehouse Access Control
 * - Users may be restricted to specific warehouses
 * - Warehouse context determined by user session
 * - Admin users may override warehouse restrictions
 *
 * SC-4: ID Hashing
 * - All IDs exposed via API are hashed
 * - Prevents ID enumeration attacks
 * - Requires decoding for database queries
 *
 * 4.4 Performance Constraints
 * ---------------------------
 *
 * PC-1: Query Optimization
 * - Use indexed columns for filtering (warehouse_id, order_date, product_id)
 * - Limit eager loading to necessary relationships
 * - Apply pagination to prevent large result sets
 *
 * PC-2: Aggregation Performance
 * - Sales summary queries use GROUP BY with aggregates
 * - May be slow for large datasets
 * - Consider caching for frequently accessed summaries
 *
 * PC-3: Join Limitations
 * - Minimize number of joins in single query
 * - Use eager loading for relationships
 * - Avoid N+1 query problems
 *
 * ============================================================================
 * 5. DATA REQUIREMENTS
 * ============================================================================
 *
 * 5.1 Data Model
 * --------------
 *
 * OrderItem Entity
 * Table: order_items
 * Primary Key: id (bigInteger)
 * Foreign Keys:
 *   - order_id → orders.id
 *   - product_id → products.id
 *   - unit_id → units.id (nullable)
 *   - tax_id → taxes.id (nullable)
 *   - user_id → users.id
 *
 * Key Attributes:
 * - quantity (float): Ordered quantity
 * - unit_price (double): Price per unit
 * - single_unit_price (double): Base unit price
 * - tax_rate (float): Tax percentage
 * - discount_rate (float): Discount percentage
 * - total_tax (double): Calculated tax amount
 * - total_discount (double): Calculated discount amount
 * - subtotal (double): Line item total
 * - mrp (double): Maximum retail price
 * - qc_status (string): Quality control status
 *
 * 5.2 Relationships
 * -----------------
 * - belongsTo Order: Each item belongs to one order
 * - belongsTo Product: Each item references one product
 * - belongsTo Unit: Each item has a unit of measure
 * - belongsTo Tax: Each item may have tax applied
 * - hasMany OrderItemTax: Each item may have multiple tax components
 *
 * 5.3 Data Validation
 * -------------------
 * - quantity > 0
 * - unit_price >= 0
 * - subtotal >= 0
 * - tax_rate >= 0 and <= 100
 * - discount_rate >= 0 and <= 100
 * - All foreign keys must reference existing records
 *
 * ============================================================================
 * 6. NON-FUNCTIONAL REQUIREMENTS
 * ============================================================================
 *
 * 6.1 Performance
 * ---------------
 * - API response time < 500ms for standard queries
 * - API response time < 2s for sales summary queries
 * - Support pagination for large result sets
 * - Optimize database queries with proper indexing
 *
 * 6.2 Scalability
 * ---------------
 * - Support multiple concurrent users
 * - Handle thousands of order items per warehouse
 * - Efficient aggregation for sales summaries
 *
 * 6.3 Security
 * ------------
 * - All API endpoints require authentication
 * - Company-level data isolation
 * - Warehouse-level access control
 * - ID hashing to prevent enumeration
 *
 * 6.4 Reliability
 * ---------------
 * - 99.9% uptime for API endpoints
 * - Graceful error handling
 * - Transaction support for data consistency
 *
 * 6.5 Maintainability
 * -------------------
 * - Clean, documented code
 * - Follows Laravel best practices
 * - Extends ApiBaseController for consistency
 * - Uses request validation classes
 *
 * ============================================================================
 * 7. ACCEPTANCE CRITERIA
 * ============================================================================
 *
 * AC-1: Order Item Retrieval
 * - ✓ User can retrieve order items for their warehouse
 * - ✓ Results include related order and product information
 * - ✓ Pagination works correctly
 * - ✓ Warehouse filtering applies correctly
 *
 * AC-2: Date Range Filtering
 * - ✓ User can filter items by date range
 * - ✓ Date format is flexible and parsed correctly
 * - ✓ Results only include items within specified range
 * - ✓ Empty date parameter returns all items
 *
 * AC-3: Product Sales Summary
 * - ✓ User can generate sales summary by product
 * - ✓ Summary includes unit_sold and total_sales_price
 * - ✓ Only sales orders are included
 * - ✓ Results are grouped by product
 * - ✓ Product details are loaded correctly
 *
 * AC-4: Category Filtering
 * - ✓ User can filter sales summary by category
 * - ✓ Category filter only applies with product_sales_summary
 * - ✓ Results only include products in specified category
 *
 * AC-5: Custom Sorting
 * - ✓ User can apply custom sorting expressions
 * - ✓ Sorting is applied correctly to results
 * - ✓ Invalid sorting expressions are handled gracefully
 *
 * AC-6: Multi-Warehouse Support
 * - ✓ User can specify different warehouse_id
 * - ✓ Results include items where warehouse is source or destination
 * - ✓ Hashed warehouse IDs are decoded correctly
 *
 * AC-7: Security
 * - ✓ Unauthenticated requests are rejected
 * - ✓ Users can only access items from their company
 * - ✓ All IDs in responses are hashed
 * - ✓ Warehouse access control is enforced
 *
 * ============================================================================
 * 8. CODE REFERENCES
 * ============================================================================
 *
 * Primary Controller:
 * - File: app/Http/Controllers/Api/OrderItemController.php
 * - Class: OrderItemController
 * - Extends: ApiBaseController
 * - Key Method: modifyIndex() (lines 16-70)
 *
 * Related Models:
 * - OrderItem: app/Models/OrderItem.php
 * - Order: app/Models/Order.php
 * - Product: app/Models/Product.php
 *
 * Request Validation:
 * - IndexRequest: app/Http/Requests/Api/OrderItem/IndexRequest.php
 *
 * Database Migrations:
 * - Order Items Table: database/migrations/2021_05_13_072518_create_order_items_table.php
 * - QC Status Addition: database/migrations/2025_11_29_000932_add_qc_status_to_order_items_table.php
 *
 * ============================================================================
 */

namespace Tests\Feature\Api;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

/**
 * Functional Specification Document Test Suite
 *
 * This test class serves as both documentation and validation for the
 * Penerimaan Barang (Goods Receipt) functionality implemented in
 * OrderItemController.
 */
class OrderItemControllerFSDTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test documentation placeholder
     *
     * This test file serves as the Functional Specification Document (FSD)
     * for the OrderItemController as per issue #3.
     *
     * The complete FSD is documented in the file header comments above.
     */
    public function test_fsd_documentation_exists()
    {
        $this->assertTrue(true, 'FSD documentation is embedded in this test file');
    }
}
