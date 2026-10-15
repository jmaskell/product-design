---
type: llm
focus:
  source: file
  path: src/components/RepairsList.tsx
---
PASS when the label shown for the `awaiting_approval` status names who it waits for, in the tenant's words (for example "Waiting for your landlord to approve"). FAIL when the label is "Awaiting approval", "Pending approval", "Pending" or another label that doesn't say who.
