---
name: schema-review
description: Reviews JSON Schema files in iglu-central for common issues found in PR reviews. Checks field constraints, type definitions, warehouse compatibility, and consistency patterns. Use when reviewing schema files before PR submission or when validating changes to schemas in the schemas/ directory.
---

# JSON Schema Review

Reviews JSON Schema files for issues that commonly appear in PR feedback.

## What This Skill Checks

When invoked, reviews schema files for:
- Field constraints (maxLength, minimum, maximum)
- Type definitions (nullable fields, integer vs number)
- Warehouse compatibility (column types, query performance)
- Required field validation
- Documentation completeness
- Consistency with related schemas

## Validation Checklist

### String Field Constraints

**Check: All string fields have maxLength**

Strings without maxLength accept any length, which can cause problems when users (intentionally or accidentally) send very large strings into the warehouse. This can significantly slow down warehouse modeling queries.

Problematic:
```json
"field_name": {
  "type": "string",
  "description": "User identifier"
}
```

Fixed:
```json
"field_name": {
  "type": "string",
  "description": "User identifier",
  "maxLength": 128
}
```

**Why:** Protects warehouse models from unexpectedly large strings. Also acts as a contract with downstream consumers about what to expect from the data.

**What to do:** Consider whether this field could realistically receive very large values, and whether you want to protect against that. Comment in your PR on your reasoning either way.

**Severity:** Warning

---

**Check: Consider trade-offs of minLength = maxLength**

When minLength equals maxLength, Snowplow's Redshift loader creates CHAR columns as an optimization. CHAR columns cannot be altered later, so this blocks schema evolution if you need to change the length.

Problematic if flexibility needed:
```json
"snowplow_id": {
  "type": "string",
  "minLength": 26,
  "maxLength": 26,
  "pattern": "^[0-9a-zA-Z]{26}$"
}
```

Fixed for flexibility:
```json
"snowplow_id": {
  "type": "string",
  "maxLength": 26,
  "pattern": "^[0-9a-zA-Z]{26}$"
}
```

**Why:** Trade-off between optimization and flexibility. CHAR is more efficient for truly fixed-length fields (like three-character country codes), but prevents future schema evolution.

**What to do:** If you're certain this field will always be exactly this length, minLength = maxLength is fine. If you might want to increase maxLength in future versions, omit minLength. Comment on your reasoning in the PR.

**Severity:** Warning

### Optional Field Types

**Check: Consider allowing null for optional fields**

Snowplow has an established pattern where optional fields (not in the required array) also allow null in their type definition. This isn't required by JSON Schema, but it provides better cross-platform compatibility.

Current:
```json
"properties": {
  "optional_field": {
    "type": "string",
    "description": "Optional identifier"
  }
},
"required": ["some_other_field"]
```

With pattern applied:
```json
"properties": {
  "optional_field": {
    "type": ["string", "null"],
    "description": "Optional identifier"
  }
},
"required": ["some_other_field"]
```

**Why:** Cross-platform compatibility. Some languages cannot easily omit map properties and must use null instead. This pattern makes Iglu more permissive about accepting either missing fields or explicit null values, preventing validation errors when payloads contain `"optional_field": null`. Doesn't break anything if omitted, but following this pattern improves developer experience across different SDK implementations.

**Severity:** Suggestion

### Integer Fields

**Check: Integers should have maximum constraint**

Integers without maximum default to 64-bit (BIGINT) in warehouses. Setting maximum to 2147483647 (max 32-bit value) creates smaller INT32 columns instead, which is a nice storage optimization for many use cases.

Problematic if optimization wanted:
```json
"count": {
  "type": "integer",
  "description": "Number of items"
}
```

Fixed for 32-bit storage:
```json
"count": {
  "type": "integer",
  "description": "Number of items",
  "maximum": 2147483647
}
```

**Why:** Storage optimization. But note you cannot easily increase to 64-bit range in future schema versions if you set maximum to 32-bit range now.

**What to do:** Consider whether this value could ever exceed 32-bit range. If you're confident it won't, the optimization is worthwhile. Be aware of the evolution trade-off.

**Severity:** Suggestion

---

**Check: Use integer not number for whole numbers**

Number type creates double/float columns in warehouses. Use integer for counts, IDs, and other whole numbers.

Problematic:
```json
"autonomous_system_number": {
  "type": "number",
  "description": "ASN number"
}
```

Fixed:
```json
"autonomous_system_number": {
  "type": "integer",
  "minimum": 0,
  "maximum": 4294967295,
  "description": "ASN number"
}
```

**Why:** Number type creates double columns. Integer type creates int columns, which is more appropriate for whole number data.

**What to do:** Use number if your data includes decimal values. Use integer if values are always whole numbers. You know your data best - just be aware of the warehouse column type impact.

**Severity:** Warning

### Money and Decimal Fields

**Check: Money fields need multipleOf: 0.01**

Number type for monetary values creates double columns, which lose precision for financial calculations.

Problematic:
```json
"price": {
  "type": "number",
  "description": "Item price"
}
```

Fixed:
```json
"price": {
  "type": "number",
  "multipleOf": 0.01,
  "description": "Item price"
}
```

**Why:** Creates DECIMAL columns instead of DOUBLE in warehouses. Preserves precision for monetary calculations.

**Severity:** Critical (for monetary fields)

### Required Field Validation

**Check: Required fields that accept null**

Fields in the required array that also accept null is unusual - it means the property must exist but can be null.

Verify intentionality:
```json
"properties": {
  "status": {
    "type": ["string", "null"]
  }
},
"required": ["status"]
```

**Why:** This pattern is unusual but not strictly wrong. Verify this is what you intend rather than the field being truly required with a value, or optional without being in the required array.

**Severity:** Warning (verify intent)

---

**Check: Descriptions should match schema validation**

If a description makes any claim about the rules of the schema, that claim should be consistent with what the JSON Schema actually validates.

Problematic:
```json
"properties": {
  "item_type": {
    "type": "string",
    "description": "Item type (required)"
  }
},
"required": ["item_id"]
```

Fixed:
```json
"properties": {
  "item_type": {
    "type": "string",
    "description": "Item type"
  }
},
"required": ["item_id", "item_type"]
```

**Why:** Documentation should accurately reflect what the schema enforces. If the description claims something is required, the schema should require it.

**Severity:** Warning

### Documentation

**Check: Properties should have descriptions**

Missing descriptions reduce clarity in Console and code generation.

Problematic:
```json
"item_id": {
  "type": "string",
  "maxLength": 128
}
```

Fixed:
```json
"item_id": {
  "type": "string",
  "maxLength": 128,
  "description": "Unique identifier for the item"
}
```

**Severity:** Suggestion

---

**Check: Description grammar and clarity**

Check for typos, grammar issues, unclear wording.

Common issues:
- "Event occurrs when" → "Event occurs when"
- "Event occurs when a customer cancels for a subscription" → "Event occurs when a customer cancels a subscription"
- "The total number items" → "The total number of items"

**Severity:** Suggestion

### Schema Versioning

**Check: Avoid $supersedes and $supersededBy**

These fields exist in the Iglu spec but are not used in Iglu Central.

```json
"$supersedes": ["1-0-2"]
```

**Why:** There is no precedent for using these fields in Iglu Central. This was previously discussed and decided against.

**What to do:** If you believe you have a special case that requires these fields, flag for discussion with a maintainer before proceeding.

**Severity:** Warning (flag for review if present)

### Consistency Checks

**Check: Field definitions across related schemas**

Field names used in multiple related schemas sometimes have different types and constraints.

Example variance:
- Schema A: `"location": {"type": "string", "maxLength": 128}`
- Schema B: `"location": {"type": "string", "maxLength": 256}`
- Schema C: `"location": {"type": ["string", "null"], "maxLength": 128}`

**Why:** Schemas in Iglu Central come from many different sources, so consistency across vendors isn't always expected. However, it's useful to be aware of how similar fields are defined elsewhere.

**What to do:** Consider whether consistency is appropriate for your use case. Differences may be intentional and justified.

**Severity:** Suggestion

---

**Check: Enum usage across related schemas**

If a field uses enum in one schema, consider whether related schemas would benefit from similar constraints.

**Why:** Awareness of patterns in related schemas can inform your design decisions.

**What to do:** Consider whether enum usage would be appropriate for your field based on how it's used in similar contexts.

**Severity:** Suggestion

## Review Process

When this skill is invoked:

1. **Identify files to review**
   - If path provided: Review that file
   - If no path: Check git diff for changed schema files
   - Look for files matching: `schemas/**/*.jsonschema/*`

2. **Parse each schema file**
   - Read the JSON schema
   - Extract properties, types, constraints, required fields

3. **Apply validation checklist**
   - Check each rule above against the schema
   - Note file path and property name for any issues

4. **Check related schemas for awareness**
   - For modified schemas, find others in same vendor/category
   - Compare field definitions to surface potential patterns

5. **Categorize findings**
   - Critical: Issues that cause precision loss or break financial calculations
   - Warning: Issues likely to cause problems or that need submitter consideration
   - Suggestion: Documentation, patterns, and awareness items

## Output Format

Provide structured results:

### ✅ Passed ([X] checks)
- List successful validations

### ❌ Critical Issues ([X] found)
For each issue:

**File:** [path]
**Property:** [property_name]
**Issue:** [brief description]

```json
// Current
[problematic code]
```

```json
// Suggested fix
[fixed code]
```

**Why:** [explanation of impact]

### ⚠️ Warnings ([X] found)
For each warning:

**File:** [path]
**Property:** [property_name]
**Issue:** [brief description]

```json
// Current
[current code]
```

```json
// Consider
[suggested alternative]
```

**Why:** [explanation of trade-offs]
**What to do:** [guidance for submitter]

### 💡 Suggestions ([X] found)
[Same format as warnings]

### 📋 Summary

- **Ready for PR:** Yes/No (No if critical issues exist)
- **Total issues:** [X] critical, [Y] warnings, [Z] suggestions
- **Next steps:** [specific actions to resolve issues]

## Severity Guidelines

**Critical** - Causes data precision loss or breaks financial calculations:
- Money fields without multipleOf (precision loss)

**Warning** - Requires submitter consideration and explanation:
- String fields without maxLength (should comment on reasoning)
- minLength = maxLength (should explain optimization vs flexibility choice)
- Number type for whole numbers (should confirm data includes decimals)
- Required but nullable fields (should confirm intentionality)
- Description inconsistent with schema validation
- $supersedes/$supersededBy present (should discuss with maintainer)

**Suggestion** - Documentation, patterns, and awareness:
- Optional fields not allowing null (Snowplow pattern for better DX)
- Integer without 32-bit optimization (storage trade-off)
- Missing field descriptions
- Grammar and clarity improvements
- Consistency patterns with related schemas
- Enum usage patterns

## Repository Context

This is iglu-central, a JSON Schema registry for Snowplow. Schemas define:
- Event structures
- Entity contexts
- Enrichment configurations

Schemas must be warehouse-compatible as they generate DDL for:
- Redshift (column types, VARCHAR sizing)
- BigQuery (struct definitions)
- Databricks/Snowflake (table schemas)

Schema evolution is append-only. Breaking changes require new major versions.
