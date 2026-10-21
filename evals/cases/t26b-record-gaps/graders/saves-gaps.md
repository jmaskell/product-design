---
type: llm
focus:
  source: file
  path: src/agent/TenantRecord.tsx
---
PASS when the agent can save the record with empty fields, and the empty or missing items are marked in place on the record (for example 'Not given yet' next to the field, or a list of what's missing). FAIL when Save is blocked by required-field errors, or when missing items aren't shown.
