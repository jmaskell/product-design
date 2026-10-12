---
type: llm
focus:
  source: file
  path: docs/plans/invoice-fee/design.md
---
Look only at what the landlord sees at approval and on the monthly statement. PASS when the approval shows one total that includes the fee, and the fee appears as its own line on the monthly statement (a reference to the terms of business is allowed). FAIL when the approval email or approval screen itemises the fee as a separate line or amount, or when the design leaves the fee off the statement.
