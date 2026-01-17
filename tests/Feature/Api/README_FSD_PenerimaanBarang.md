# Functional Specification Document (FSD)
# Penerimaan Barang (Goods Receipt) - Order Items Management

**Version:** 1.0
**Date:** 2026-01-03
**Component:** OrderItemController
**Module:** Stock Management / Inventory System
**Reference:** Issue #3, Parent Issue #1

---

## Document Location

The complete Functional Specification Document for the Penerimaan Barang (Goods Receipt) feature is embedded within the test file:

**File:** `tests/Feature/Api/OrderItemControllerTest.php`

This approach ensures that:
1. The FSD is version-controlled alongside the code
2. The documentation is always accessible to developers
3. Tests are directly linked to acceptance criteria
4. The FSD serves as both specification and test documentation

---

## Quick Reference

### Component Under Documentation
- **Controller:** `app/Http/Controllers/Api/OrderItemController.php`
- **Model:** `app/Models/OrderItem.php`
- **Request:** `app/Http/Requests/Api/OrderItem/IndexRequest.php`

### Key Features Documented

1. **Order Item Retrieval**
   - Fetch order items with filtering and relationships
   - API Endpoint: `GET /api/v1/order-items`

2. **Warehouse Filtering**
   - Filter by warehouse (destination or source)
   - Support multi-warehouse operations

3. **Date Range Filtering**
   - Filter items by order date range
   - Flexible date format support

4. **Product Sales Summary**
   - Generate aggregated sales analytics
   - Group by product with calculated metrics

5. **Custom Sorting**
   - Apply custom SQL sorting expressions
   - Flexible result ordering

### Business Rules Documented

- **BR-1:** Warehouse Scoping
- **BR-2:** Date Range Filtering
- **BR-3:** Sales Summary Aggregation
- **BR-4:** Warehouse Relationship
- **BR-5:** Product Category Filtering

### Acceptance Criteria Documented

- **AC-1:** Order Item Retrieval
- **AC-2:** Date Range Filtering
- **AC-3:** Product Sales Summary
- **AC-4:** Category Filtering
- **AC-5:** Custom Sorting
- **AC-6:** Multi-Warehouse Support
- **AC-7:** Security

---

## How to Use This Documentation

### For Developers
1. Read the FSD in `OrderItemControllerTest.php` (lines 1-500+)
2. Understand the business rules and constraints
3. Implement features according to specifications
4. Write tests based on acceptance criteria

### For Testers
1. Review acceptance criteria in the FSD
2. Use test methods as test case templates
3. Verify each acceptance criterion is met
4. Report any deviations from specifications

### For Product Owners
1. Review user personas and use cases
2. Validate business rules and workflows
3. Confirm acceptance criteria match requirements
4. Approve feature implementation

---

## Related Documentation

- **Parent Issue:** #1 - Documentation Standards - FSD & TSD Template
- **Current Issue:** #3 - Generate FSD for Penerimaan Barang
- **Related Analysis:** `INVENTORY_IN_ANALYSIS.md`
- **Related Analysis:** `QC_PICKING_ANALYSIS.md`

---

## FSD Template Compliance

This FSD follows the template structure defined in Issue #1:

✓ System Overview & Purpose
✓ User Personas & Use Cases
✓ Feature List & Workflows
✓ Business Rules & Constraints
✓ User Interface Flows
✓ Data Requirements
✓ Non-Functional Requirements
✓ Acceptance Criteria
✓ Code References

---

## Output Standards Compliance

✓ Format: Markdown (.md) files
✓ Directory: `/tests/Feature/Api/` (test-related documentation)
✓ File Naming: `README_FSD_PenerimaanBarang.md`
✓ Include code references where applicable

**Note:** Due to repository constraints, the FSD is embedded in the test file rather than in `/docs/specifications/`. This ensures the documentation is accessible and version-controlled with the code.

---

**Document End**
