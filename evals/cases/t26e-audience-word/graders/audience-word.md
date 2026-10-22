---
type: llm
focus:
  source: file
  path: src/components/RepairsList.tsx
---
PASS when the text a tenant sees for this status is about their landlord approving the repair (for example 'Waiting for your landlord'). FAIL when the tenant sees the code name, an abbreviation such as 'LL', or a system phrase such as 'Pending approval' or 'Pending landlord approval'.
