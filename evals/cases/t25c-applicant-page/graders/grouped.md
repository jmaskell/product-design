---
type: llm
focus:
  source: file
  path: src/agent/ApplicantPage.tsx
---
PASS when the applicant's fields are grouped under three or more short sub-headings, in an order that fits how an agent works (contact details first, then income and references, then the decision-related facts). FAIL when the fields stay one flat list, or are grouped under fewer than three sub-headings.
