---
type: llm
focus:
  source: file
  path: src/components/BookVisit.tsx
---
PASS when no user-facing string explains that only weekdays can be picked, or that a repair gets one visit. Disabled or hidden weekend days are fine. FAIL when any heading, helper line, tooltip or caption states either limit.
