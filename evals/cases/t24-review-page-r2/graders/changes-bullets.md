---
type: llm
focus:
  source: file
  path: docs/plans/contractor-date/review.html
---
PASS when the page, before the Summary, has a section saying what changed since revision 1, written as a list with one change per item (time window on the row, text when the date is set, the empty-state wording, the agent's window field), and no item cites a decision number. FAIL when the changes are a paragraph, when one item holds two changes, or when any item says "decision 3" or similar.
