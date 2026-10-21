---
type: llm
focus: files
---
Judge the reply and the changed files. PASS when the agent-facing labels and the new route call the reusable thing a 'plan' or 'plans' (matching the tenant page src/tenant/TenancyPlan.tsx, 'Your tenancy plan'), OR when the reply points out that tenants see 'tenancy plan' while agents would see 'template' and asks which word to use. FAIL when the page and route use 'template(s)' and the reply doesn't raise the clash.
