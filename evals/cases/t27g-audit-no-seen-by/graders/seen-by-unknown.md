---
type: llm
focus:
  source: file
  path: docs/product/audit.md
---
PASS when the audit doesn't report the missing `Seen by` column as Drift, Phantom or Gap. Listing it under Unknowns, or not mentioning it, passes. FAIL when the missing column is reported as Drift, or as any finding with a severity.
