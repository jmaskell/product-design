---
type: llm
focus:
  source: file
  path: src/components/RepairsList.tsx
---
PASS when the section has a heading and the list, with no line that explains how visits or reminders work (for example "You'll get a text the day before", "Visits are booked once…"). An empty-state line such as "No visits booked" is allowed. FAIL when any such explainer line appears.
