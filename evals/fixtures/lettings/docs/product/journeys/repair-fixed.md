# Journey: a reported repair is fixed

Trigger: something in the home breaks. Outcome: it works again and the tenant did not chase. Starts: the tenant notices the problem. Ends: the tenant confirms it works.
verified: 2026-08-20 interview synthesis

| Stage | Actor | Action | Decision | Information needed | System | Friction | Evidence |
|---|---|---|---|---|---|---|---|
| Notice | Tenant | Finds the problem | Is it urgent? | What counts as urgent | — | Tenants do not know the 24h rule | ASSUMED |
| Report | Tenant | Fills the repair form | Which category | Photos, access times | Portal | — | KNOWN (form analytics) |
| Triage | Letting agent | Reads the report, sets priority | Urgent? Over £250? | Category, photos, quote | Repairs inbox | Reports lack photos | KNOWN (agent interviews) |
| Approve | Landlord | Approves the spend | Approve or decline | Quote, photos | Email | Landlords reply in 3–5 days | KNOWN (agent interviews) |
| Book | Letting agent | Emails the contractor | Which contractor | Access times | Email | Access times missing | INFERRED (from triage friction) |
| Fix | Contractor | Does the work | — | Access, job detail | — | — | UNKNOWN |
| Close | Letting agent | Marks done, tells tenant | — | Contractor report | Repairs inbox | — | ASSUMED |

## Backstage
The tenant does not see the approval stage. The line of visibility sits between Report and Close.
