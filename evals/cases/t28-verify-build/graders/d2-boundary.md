---
type: llm
---
PASS when the reply reports that "See all refunds" shows at exactly 10 refunds (the code uses `>= 10`, src/refunds/RefundsList.tsx) while design.md says more than 10. FAIL when the reply doesn't report this boundary.
