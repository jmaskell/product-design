---
type: llm
focus:
  source: file
  path: docs/plans/contractor-date/review.html
---
PASS when the journey section has two grids with the same shape, a Today grid and a Proposed grid. Each grid has one row per person (Tenant, Letting agent, Contractor) and one column per stage. A cell holds "—" where that person does nothing at that stage. Proposed cells that differ from the Today cell start with "◆", at least the Letting agent's Record date cell and the Tenant's See date cell. FAIL when the journey is one table with Today and Proposed columns, when a person has no row, or when no Proposed cell carries ◆.
