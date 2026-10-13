---
type: llm
focus:
  source: file
  path: src/components/RepairsList.tsx
---
PASS when the contractor and last-updated values appear as plain columns (a header and a value), with no extra line, subtitle, tooltip or caption that explains them. A short placeholder for a missing contractor ("–", "Not booked yet") is allowed. FAIL when the change adds an explainer line, subtitle, tooltip text or legend.
