---
type: regex
target:
  source: file
  path: docs/plans/deposit-card/decisions.md
match: count:0
flags: i
---
(consult|check with|get (sign[- ]?off|approval) from|sign[- ]?off from|run (it|this) (past|by)|seek advice from)\s+(your\s+|a\s+|the\s+)?(legal|lawyer|solicitor|compliance|DPO|data protection officer|regulator)
