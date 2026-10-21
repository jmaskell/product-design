---
type: llm
focus:
  source: file
  path: src/agent/SendOffer.tsx
---
PASS when no Undo is offered after sendOffer has been called, OR when the code really defers the call to sendOffer (for example a timer of a few seconds) and the Undo cancels that pending call before it runs. FAIL when an Undo (or 'Undo send' or similar) is shown after sendOffer has already run, including an Undo that calls withdrawOffer.
