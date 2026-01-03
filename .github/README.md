# Documentation Templates

This directory contains the documentation standards and templates for the Wakasa project.

## Available Templates

- **[FSD-Template.md](./FSD-Template.md)** - Functional Specification Document template
- **[TSD-Template.md](./TSD-Template.md)** - Technical Specification Document template
- **[DOCUMENTATION_STANDARDS.md](./DOCUMENTATION_STANDARDS.md)** - Complete documentation standards guide

## Quick Start

### Creating a New FSD (Functional Specification Document)

1. Copy `FSD-Template.md` to `/docs/specifications/`
2. Rename to `FSD-[YourFeatureName].md`
3. Fill in all sections, replacing placeholders with actual content
4. Include code references where applicable

**Example:** `docs/specifications/FSD-UserAuthentication.md`

### Creating a New TSD (Technical Specification Document)

1. Copy `TSD-Template.md` to `/docs/specifications/`
2. Rename to `TSD-[YourComponentName].md`
3. Fill in all sections, replacing placeholders with actual content
4. Include code references where applicable

**Example:** `docs/specifications/TSD-AuthenticationAPI.md`

## Documentation Standards

### Output Standards

- **Format:** Markdown (.md) files
- **Directory:** `/docs/specifications/`
- **File Naming:**
  - FSD: `FSD-[FeatureName].md`
  - TSD: `TSD-[ComponentName].md`
- **Include code references where applicable**

### FSD Template Structure

The FSD template includes:
1. System Overview & Purpose
2. User Personas & Use Cases
3. Feature List & Workflows
4. Business Rules & Constraints
5. User Interface Flows
6. Data Requirements
7. Non-Functional Requirements
8. Acceptance Criteria

### TSD Template Structure

The TSD template includes:
1. System Architecture Overview
2. Technology Stack & Dependencies
3. Database Schema & Design
4. API Endpoints (Methods, Parameters, Response Formats)
5. Authentication & Authorization Flow
6. Error Handling & Logging
7. Rate Limits & Performance Requirements
8. Integration Points with External Systems
9. Data Flow Diagrams (as code comments)

## When to Use Each Template

### Use FSD When:
- Documenting new features or feature enhancements
- Defining user-facing functionality
- Specifying business requirements and workflows
- Describing user interface and user experience specifications

### Use TSD When:
- Documenting system architecture and design
- Specifying API endpoints and contracts
- Defining database schemas and data models
- Detailing technical implementation specifics
- Documenting integration specifications

## Best Practices

1. **Keep Documents Updated:** Update documentation when features or components change
2. **Use Clear Language:** Write for your audience (technical or non-technical)
3. **Include Code References:** Always reference actual code files when applicable
4. **Version Control:** Track changes in the revision history section
5. **Review Process:** Have documents reviewed before marking as "Approved"
6. **Link Related Documents:** Cross-reference related FSD and TSD documents
7. **Use Diagrams:** Include visual representations where helpful
8. **Be Specific:** Avoid vague requirements; be as specific as possible

## Directory Structure

The documentation should be organized as follows:

```
/docs/
└── specifications/
    ├── FSD-[Feature1].md
    ├── FSD-[Feature2].md
    ├── TSD-[Component1].md
    ├── TSD-[Component2].md
    └── README.md (optional index file)
```

## Additional Resources

For complete documentation standards and detailed examples, see [DOCUMENTATION_STANDARDS.md](./DOCUMENTATION_STANDARDS.md).
