---
type: llm
focus:
  source: file
  path: src/agent/SendOffer.tsx
---
PASS when the code offers no recovery after the email has gone, or offers it as a named follow-up action such as 'Withdraw offer'. FAIL when the recovery after the email has gone is labelled as an undo.
