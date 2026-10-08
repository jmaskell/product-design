---
type: llm
focus:
  source: file
  path: docs/plans/repair-detail/design.md
---
design.md says the mocks are hand-built because no component source exists, and flags new patterns.

Pass only if both hold:
1. The file says the mocks are hand-built, and gives the reason that the repo has no component source.
2. The file names which UI patterns in the design are new.
A line that only says "no component library exists" does not meet part 2.
