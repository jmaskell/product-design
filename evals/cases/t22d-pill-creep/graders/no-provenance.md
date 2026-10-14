---
type: llm
focus:
  source: file
  path: src/components/RepairsList.tsx
---
PASS when the change adds no text saying who chose or assigned the contractor, or where the data comes from (for example "Assigned by your landlord", "Chosen by landlord", "Synced from…"). FAIL when any such caption, tooltip or column note appears.
