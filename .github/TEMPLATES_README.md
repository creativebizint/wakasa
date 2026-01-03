# Documentation Templates - Quick Reference

## 📋 Available Templates

This directory contains standardized documentation templates for the Wakasa project:

| Template | File | Purpose |
|----------|------|---------|
| **FSD** | [FSD-Template.md](./FSD-Template.md) | Functional Specification Document |
| **TSD** | [TSD-Template.md](./TSD-Template.md) | Technical Specification Document |
| **Standards** | [DOCUMENTATION_STANDARDS.md](./DOCUMENTATION_STANDARDS.md) | Complete documentation guide |

## 🚀 Quick Start

### Step 1: Choose Your Template

- **FSD (Functional Specification Document)** - For business requirements and user-facing features
- **TSD (Technical Specification Document)** - For technical implementation details

### Step 2: Copy the Template

```bash
# For FSD
cp .github/FSD-Template.md docs/specifications/FSD-YourFeatureName.md

# For TSD
cp .github/TSD-Template.md docs/specifications/TSD-YourComponentName.md
```

### Step 3: Fill In the Template

1. Replace `[Feature Name]` or `[Component Name]` with your actual name
2. Update the metadata (Version, Date, Author, Status)
3. Fill in all sections, replacing placeholders (text in square brackets)
4. Include code references where applicable

### Step 4: Review and Approve

1. Have the document reviewed by team members
2. Update the status from "Draft" to "Review" to "Approved"
3. Maintain the revision history

## 📁 File Naming Conventions

### FSD Files
- Format: `FSD-[FeatureName].md`
- Examples:
  - `FSD-UserAuthentication.md`
  - `FSD-InventoryManagement.md`
  - `FSD-OrderProcessing.md`

### TSD Files
- Format: `TSD-[ComponentName].md`
- Examples:
  - `TSD-AuthenticationAPI.md`
  - `TSD-DatabaseSchema.md`
  - `TSD-PaymentGateway.md`

## 📂 Directory Structure

```
wakasa/
├── .github/
│   ├── FSD-Template.md              ← FSD template
│   ├── TSD-Template.md              ← TSD template
│   ├── DOCUMENTATION_STANDARDS.md   ← Complete standards
│   └── README.md                    ← This file
└── docs/
    └── specifications/
        ├── FSD-Feature1.md          ← Your FSD documents
        ├── FSD-Feature2.md
        ├── TSD-Component1.md        ← Your TSD documents
        └── TSD-Component2.md
```

## 🎯 When to Use Each Template

### Use FSD When You Need To Document:

- ✅ New features or feature enhancements
- ✅ User-facing functionality
- ✅ Business requirements and workflows
- ✅ User interface and user experience specifications
- ✅ User personas and use cases
- ✅ Acceptance criteria

### Use TSD When You Need To Document:

- ✅ System architecture and design
- ✅ API endpoints and contracts
- ✅ Database schemas and data models
- ✅ Technical implementation specifics
- ✅ Integration specifications
- ✅ Performance and security requirements

## 📝 Template Sections

### FSD Template Includes:

1. System Overview & Purpose
2. User Personas & Use Cases
3. Feature List & Workflows
4. Business Rules & Constraints
5. User Interface Flows
6. Data Requirements
7. Non-Functional Requirements
8. Acceptance Criteria

### TSD Template Includes:

1. System Architecture Overview
2. Technology Stack & Dependencies
3. Database Schema & Design
4. API Endpoints (Methods, Parameters, Response Formats)
5. Authentication & Authorization Flow
6. Error Handling & Logging
7. Rate Limits & Performance Requirements
8. Integration Points with External Systems
9. Data Flow Diagrams

## ✨ Best Practices

### Do's ✅

- ✅ Keep documents updated when code changes
- ✅ Use clear, concise language
- ✅ Include code references (e.g., `app/Controllers/AuthController.php`)
- ✅ Track changes in revision history
- ✅ Get peer reviews before approval
- ✅ Cross-reference related documents
- ✅ Add diagrams and visual aids
- ✅ Be specific and detailed

### Don'ts ❌

- ❌ Leave placeholder text in final documents
- ❌ Skip sections (fill in "N/A" if not applicable)
- ❌ Forget to update the status
- ❌ Use vague or ambiguous language
- ❌ Ignore the revision history
- ❌ Create documents without code references

## 🔗 Related Resources

- **Complete Standards:** [DOCUMENTATION_STANDARDS.md](./DOCUMENTATION_STANDARDS.md)
- **FSD Template:** [FSD-Template.md](./FSD-Template.md)
- **TSD Template:** [TSD-Template.md](./TSD-Template.md)

## 📞 Need Help?

If you have questions about:
- **Which template to use:** Check the "When to Use Each Template" section above
- **How to fill in sections:** See [DOCUMENTATION_STANDARDS.md](./DOCUMENTATION_STANDARDS.md)
- **Template structure:** Review the template files directly

## 🔄 Document Lifecycle

```
Draft → Review → Approved → Implemented
  ↓       ↓         ↓           ↓
Create  Peer    Finalize   Track in
       Review   Content    Revision
                          History
```

## 📊 Example Workflow

### Scenario: Adding a New "User Profile" Feature

1. **Create FSD:**
   ```bash
   cp .github/FSD-Template.md docs/specifications/FSD-UserProfile.md
   ```
   - Document user requirements
   - Define use cases
   - Specify UI flows

2. **Create TSD:**
   ```bash
   cp .github/TSD-Template.md docs/specifications/TSD-UserProfileAPI.md
   ```
   - Document API endpoints
   - Define database schema
   - Specify authentication

3. **Link Documents:**
   - Reference TSD in FSD's "References" section
   - Reference FSD in TSD's "References" section

4. **Implement:**
   - Use documents as implementation guide
   - Update documents if requirements change
   - Mark as "Implemented" when complete

---

**Last Updated:** 2026-01-03
**Maintained By:** Wakasa Development Team
