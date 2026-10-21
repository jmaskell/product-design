---
type: llm
focus:
  source: file
  path: src/tenant/Apply.tsx
---
PASS when a failed submit keeps every answer the tenant typed (no field is cleared). FAIL when any answer is cleared after a failed submit.
