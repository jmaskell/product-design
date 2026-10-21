---
type: llm
focus:
  source: file
  path: src/agent/SendOffer.tsx
---
PASS when the applicant's name or email address shows before the agent presses send, or in a hold message while the send can still be cancelled. FAIL when the recipient is not shown at either point.
