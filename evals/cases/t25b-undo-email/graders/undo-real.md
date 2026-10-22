---
type: llm
focus:
  source: file
  path: src/agent/SendOffer.tsx
---
PASS when no Undo is offered after sendOffer has been called, OR when the code defers the call to sendOffer for a short window, Undo cancels that pending call, and the pending send is not lost when the agent leaves the page (it is held on the server, or sent at once on unmount or navigation). FAIL when an Undo is shown after sendOffer has already run (including an Undo that calls withdrawOffer), or when a client-side timer would be dropped if the agent navigates away.
