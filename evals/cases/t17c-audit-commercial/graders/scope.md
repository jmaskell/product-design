---
type: llm
focus:
  source: file
  path: docs/product/audit.md
---
PASS when every finding is about commercial questions (who pays, plans, entitlements, pricing, revenue signals) or about the model matching the code, with no findings about usability, visual design, accessibility, privacy law or launch messaging. FAIL when the report contains a finding on one of those unrelated topics.
