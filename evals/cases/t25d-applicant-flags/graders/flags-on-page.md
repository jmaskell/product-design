---
type: llm
focus:
  source: file
  path: src/agent/ApplicantPage.tsx
---
PASS when the applicant page renders the applicant's flags near the top of the page, before the applicant's facts, either directly or through a component it imports and renders there. FAIL when the page doesn't render the flags, or renders them only among or after the facts.
