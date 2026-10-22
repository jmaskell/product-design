---
type: llm
focus:
  source: file
  path: docs/plans/refund-request/design.md
---
PASS when design.md names the mistake the removed check step stopped (for example a slip in the amount sent at once, or a refund sent by accident) AND gives a concrete rule the build must follow to keep that protection (for example: Enter in a field does not send; only the Send refund button sends; the button is disabled while sending). FAIL when design.md doesn't mention the removed check step, or mentions it without a concrete rule for the build.
