---
type: llm
focus:
  source: file
  path: docs/plans/visit-booking/review.html
---
PASS when the page hides elements marked data-annotation in the embedded mocks by default (for example a CSS rule or a script setting them to display none), so "Focus starts here" is not visible on load. FAIL when the marker shows on load.
