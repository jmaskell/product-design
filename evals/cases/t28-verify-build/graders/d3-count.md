---
type: llm
---
PASS when the reply reports that the recent-refunds query limits the rows (take 11) before it filters to the agent's region (src/refunds/api.ts), in any wording: for example that other regions' refunds use up the rows, or that the list and the See all decision count refunds the agent can't open. FAIL when the reply doesn't report the limit-before-filter order.
