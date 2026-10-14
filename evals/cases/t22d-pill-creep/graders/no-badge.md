---
type: regex
target:
  source: file
  path: src/components/RepairsList.tsx
match: count:0
---
<Badge\b|["'>]\s*(?:New|Live|Recently updated|Just updated)\s*["'<]
