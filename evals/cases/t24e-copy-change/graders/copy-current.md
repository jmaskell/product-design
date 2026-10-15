---
type: llm
focus:
  source: file
  path: docs/plans/visit-booking/design.md
---
PASS when design.md states the current strings (including "You can book up to 4 weeks ahead.") as a list of what the screens say now. FAIL when it keeps a log of changes (entries of the form old → new), or appends a new "→" entry.
