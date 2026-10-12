---
type: llm
focus:
  source: file
  path: docs/product/audit.md
---
PASS when the report says the contractor ratings feature (contractor-ratings.ts) is sold on the Plus plan but has no plan or entitlement check, AND it does not flag the landlord reports feature (reports.ts) as lacking a check. FAIL when contractor ratings is not named as unchecked, or landlord reports is flagged as unchecked.
