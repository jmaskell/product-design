---
type: llm
focus:
  source: file
  path: src/agent/SendOffer.tsx
---
PASS when, after a successful send, the code takes the agent to the sent offer's own page or view (for example by navigating with the returned offerId). FAIL when it stays on the form with a banner, goes to a list with a banner, or only shows a toast.
