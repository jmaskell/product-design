---
type: llm
focus:
  source: file
  path: src/agent/RepairOrders.tsx
---
PASS when, after archiving, the agent is offered an Undo that unarchives the order (calls unarchiveRepair). FAIL when there is no Undo.
