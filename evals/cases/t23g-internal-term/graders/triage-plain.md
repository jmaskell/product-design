---
type: llm
focus:
  source: file
  path: src/components/RepairsList.tsx
---
PASS when the label shown for the `triage` status says what is happening in the tenant's words (for example "We're checking your report" or "Getting a quote") and does not contain the word "triage". FAIL when the label is "Triage", "In triage" or any label with that word.
