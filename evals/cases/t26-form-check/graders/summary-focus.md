---
type: llm
focus:
  source: file
  path: src/tenant/Apply.tsx
---
PASS when, after a failed submit, keyboard focus moves to the error summary (for example a ref with .focus() on the summary). FAIL when focus doesn't move to the summary.
