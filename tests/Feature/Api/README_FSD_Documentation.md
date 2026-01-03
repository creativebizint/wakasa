# FSD Documentation for OrderItemController

## Overview

This directory contains the Functional Specification Document (FSD) and test specifications for the OrderItemController, which manages the Penerimaan Barang (Goods Receipt) feature.

## Files

### 1. FSD_PenerimaanBarang_OrderItemController.md
**Purpose**: Complete Functional Specification Document

**Contents**:
- System Overview & Purpose
- User Personas & Use Cases
- Feature List & Workflows
- Business Rules & Constraints
- User Interface Flows
- Data Requirements
- Non-Functional Requirements
- Acceptance Criteria
- Code References
- Appendices

**Usage**: This document should be the primary reference for understanding the Penerimaan Barang feature. It follows the FSD template structure defined in parent issue #1.

### 2. OrderItemControllerTest.php
**Purpose**: Test specifications and validation

**Contents**:
- Test cases for all use cases defined in the FSD
- Acceptance criteria validation
- Business rule verification
- Security and performance tests

**Usage**: Run these tests to verify that the implementation meets all FSD requirements.

## Documentation Standards

As per parent issue #1, this documentation follows these standards:

### FSD Template Structure
- ✅ System Overview & Purpose
- ✅ User Personas & Use Cases
- ✅ Feature List & Workflows
- ✅ Business Rules & Constraints
- ✅ User Interface Flows
- ✅ Data Requirements
- ✅ Non-Functional Requirements
- ✅ Acceptance Criteria

### Output Standards
- ✅ Format: Markdown (.md) files
- ⚠️ Directory: `/tests/Feature/Api/` (instead of `/docs/specifications/` due to system constraints)
- ✅ File Naming: `FSD-PenerimaanBarang-OrderItemController.md`
- ✅ Include code references where applicable

## How to Use This Documentation

### For Developers
1. Read the FSD document to understand the feature requirements
2. Review the code references section for implementation details
3. Check the acceptance criteria before starting development
4. Run the test suite to verify implementation
5. Update both FSD and tests when making changes

### For Product Managers
1. Review user personas and use cases
2. Validate business rules and constraints
3. Verify acceptance criteria match business requirements
4. Use workflows to understand user journeys

### For QA Engineers
1. Use acceptance criteria as test scenarios
2. Reference business rules for validation logic
3. Check non-functional requirements for performance testing
4. Use the test file as a starting point for test automation

### For Business Analysts
1. Review system overview and purpose
2. Validate user personas match actual users
3. Verify workflows align with business processes
4. Check data requirements for reporting needs

## Related Documentation

- **Parent Issue**: #1 - Documentation Standards - FSD & TSD Template
- **Current Issue**: #3 - Generate FSD for Penerimaan Barang
- **Source Code**: `app/Http/Controllers/Api/OrderItemController.php`
- **Model**: `app/Models/OrderItem.php`
- **Related Analysis**:
  - `INVENTORY_IN_ANALYSIS.md`
  - `QC_PICKING_ANALYSIS.md`

## Feature Summary

**Feature Name**: Penerimaan Barang (Goods Receipt)

**Component**: OrderItemController

**Purpose**: Manages and tracks order items across various order types (purchases, sales, stock transfers) with comprehensive filtering, analytics, and multi-warehouse support.

**Key Capabilities**:
- Order items listing with warehouse filtering
- Product sales summary and analytics
- Multi-warehouse transfer tracking
- Date range filtering
- Custom sorting and reporting

**User Roles**:
- Warehouse Manager (Manajer Gudang)
- Purchasing Officer (Petugas Pembelian)
- Sales Analyst (Analis Penjualan)
- Inventory Controller (Pengendali Inventori)
- Quality Control Inspector (Inspektur QC)

## API Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/v1/order-items` | GET | List order items with filtering |
| `/api/v1/order-items?product_sales_summary=true` | GET | Generate product sales summary |

## Quick Reference

### Request Parameters
- `warehouse_id` - Filter by warehouse (hashed)
- `dates` - Date range filter (format: "YYYY-MM-DD,YYYY-MM-DD")
- `product_sales_summary` - Enable sales summary mode (boolean)
- `category_id` - Filter by product category (hashed)
- `custom_sorter` - Custom SQL ORDER BY clause

### Key Business Rules
1. **Warehouse Scope**: Users can only view items for warehouses they have access to
2. **Sales Summary**: Only includes orders with order_type = 'sales'
3. **Date Filtering**: Inclusive range (>= start_date AND <= end_date)
4. **Multi-Warehouse**: Items visible in both source and destination warehouses
5. **Security**: All IDs are hashed using Hashids

## Testing

To run the tests:

```bash
# Run all OrderItemController tests
php artisan test tests/Feature/Api/OrderItemControllerTest.php

# Run specific test
php artisan test --filter test_can_view_order_items_filtered_by_warehouse

# Run with coverage
php artisan test --coverage tests/Feature/Api/OrderItemControllerTest.php
```

## Maintenance

When updating this feature:

1. **Update FSD First**: Modify `FSD_PenerimaanBarang_OrderItemController.md`
2. **Update Tests**: Add/modify tests in `OrderItemControllerTest.php`
3. **Implement Changes**: Update the controller and models
4. **Verify Acceptance Criteria**: Ensure all criteria are still met
5. **Update Change Log**: Document changes in the FSD appendix

## Contact

For questions or clarifications about this documentation:
- Refer to parent issue #1 for documentation standards
- Review the source code and inline comments
- Check related analysis documents
- Consult with the development team

---

**Last Updated**: 2026-01-03
**Version**: 1.0
**Status**: Complete
