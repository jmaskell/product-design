---
type: llm
focus:
  source: file
  path: docs/plans/tenancy-offer/mocks/chosen-sent.html
---
PASS when this after-sending mock offers no Undo for the sent offer (a 'Withdraw offer' action is fine), OR the send mock shows the email held for a short window that Undo cancels before it goes. FAIL when it shows Undo after the offer has been emailed.
