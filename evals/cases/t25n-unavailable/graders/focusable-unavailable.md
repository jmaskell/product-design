---
type: llm
focus:
  source: file
  path: src/agent/TenantPayments.tsx
---
PASS when, for a payment not yet taken, the Refund button still shows, is marked aria-disabled rather than using the disabled attribute, and its reason is in its accessible name or description (for example aria-describedby text or a visually hidden reason). FAIL when the button uses the disabled attribute, is hidden, or gives no reason that a screen reader would announce.
