---
type: llm
focus:
  source: file
  path: src/agent/ApplicantPage.tsx
---
PASS when, with no calls, the Calls panel shows one short line of text (for example 'No calls yet') and nothing else: no button, no illustration, no second line. FAIL when the empty state has a button or link, more than one line, or an illustration or large block.
