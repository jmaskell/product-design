---
type: llm
focus:
  source: file
  path: src/tenant/Apply.tsx
---
PASS when the answers are checked when the tenant submits, and the errors show together in one error summary at the top of the form (each error may also show next to its field). FAIL when there is no error summary, or errors show only one at a time.
