---
type: llm
focus:
  source: file
  path: src/tenant/PaymentSummary.tsx
---
PASS when the summary states the monthly amount as a number in the sentence or row that describes what follows the deposit (for example 'then £1,200 a month'). FAIL when that part names a concept without the amount, such as 'then the rent', 'then monthly' or 'then your monthly payments', even if the number shows elsewhere.
