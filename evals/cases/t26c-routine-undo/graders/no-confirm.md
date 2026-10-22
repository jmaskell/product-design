---
type: llm
focus:
  source: file
  path: src/agent/RepairOrders.tsx
---
PASS when Archive runs at once on press, with no confirm dialog or confirm step. FAIL when pressing Archive opens a confirm dialog, an inline confirm or a window.confirm before archiving.
