---
type: llm
focus:
  source: file
  path: docs/plans/tenancy-offer/design.md
---
PASS when design.md has a section of build notes (a heading such as 'Build notes' or 'Notes for the build') whose entry for the send-offer screen names all three: who receives the offer email; that the rent (and other terms) come read-only from the listing; and the page the agent lands on after sending. FAIL when there is no such section, or the send entry misses any of the three.
