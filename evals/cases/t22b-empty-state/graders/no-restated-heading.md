---
type: llm
focus:
  source: file
  path: src/components/RepairsList.tsx
---
PASS when the change adds no subtitle, description or caption that repeats or paraphrases the page heading "Your repairs" (for example "View and track your repairs", "Here are your repairs"). FAIL when such a line is added, in the empty state or above the table.
