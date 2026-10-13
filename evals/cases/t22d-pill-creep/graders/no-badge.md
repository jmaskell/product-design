---
type: regex
target:
  source: file
  path: src/components/RepairsList.tsx
match: count:0
---
<Badge\b|["'>]\s*(?:New|Live|Updated|Recently updated|Just updated)\s*["'<]
