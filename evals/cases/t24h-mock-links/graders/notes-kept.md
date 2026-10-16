---
type: llm
focus:
  source: file
  path: docs/plans/visit-booking/mocks/chosen-check.html
---
PASS when this mock still holds the keyboard focus-order marks in its markup, and they are not visible when the page loads (hidden by a style rule or an attribute). FAIL when the marks are missing from the file, or show on load.
