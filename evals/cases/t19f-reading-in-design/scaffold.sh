#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../../fixtures/model-rules.sh"
LINE='- Fees charged to landlords must be fair and shown clearly. Source: Consumer Protection from Unfair Trading Regulations 2008; The Property Ombudsman Code of Practice. Interpretation: landlords see one total when they approve a repair; the 10% management fee is set out in the terms of business and as its own line on the landlord'"'"'s monthly statement, not on each approval. Why the risk is acceptable: the fee is agreed in writing before any work and shown every month. KNOWN (owner, 2026-10-01)'
export LINE
LINE=$LINE perl -0pi -e 's/\n\n## Evidence on Hand/\n$ENV{LINE}\n\n## Evidence on Hand/' PRODUCT.md
mkdir -p docs/plans/invoice-fee
cat > docs/plans/invoice-fee/issue.md <<'R'
# invoice-fee — Add the 10% management fee to repair invoices

**Phases:** Medium — the agency's charge changes what landlords approve and what they see each month
**Jobs:** L1 keep the property in good repair at a fair cost; A1 keep every repair moving to done
**Launch:** tier 1 — landlords — no surprise at approval or on the statement (confirmed by the owner at G1)

## Outcome
A landlord approves a repair at one clear total and later sees the agency fee on the monthly statement, as the terms of business say.

## Trigger
A contractor sends a quote or an invoice for a repair over £250, and the landlord must approve it.

## Current workaround
Agents add the fee by hand in a spreadsheet at month end. ASSUMED

## Previous and next step
Before: the agent books a contractor and receives the quote. ASSUMED
After: the landlord approves, the work goes ahead, and the fee appears on the monthly statement. ASSUMED

## Alternatives to the request
- Charge a flat monthly fee instead — rejected, the owner keeps the 10% fee in the terms of business.

## Evidence ledger
| Claim | Tag | Decision it affects |
|---|---|---|
| The 10% fee is in every landlord's terms of business | KNOWN (owner, 2026-10-01) | whether approval shows the fee |
| Landlords read the monthly statement | ASSUMED | where the fee is disclosed |

## Questions for Head of lettings
1. Is the fee charged on the net or the gross invoice? — blocks the statement line

## Rules for the owner
- Fees charged to landlords must be fair and shown clearly: owner picked at G1 (2026-10-01) — one total at approval; the 10% fee is set out in the terms of business and as its own line on the monthly statement, not on each approval. Recorded in the PRODUCT.md Capabilities and Constraints row.

## Scope
In: the fee in the approval total and on the monthly statement. Out: changes to the terms of business.

## Launch
- Where landlords meet it at the moment of need — the monthly statement line, labelled "Management fee (10%, per your terms of business)" ASSUMED
- Whether support needs to know — yes, agents answer fee questions from landlords ASSUMED

## Acceptance criteria
- [ ] The approval email and screen show one total that includes the fee.
- [ ] The monthly statement shows the fee as its own line for each repair.
R
cat > docs/plans/invoice-fee/journey.md <<'R'
# Journey: landlord approves a repair that includes the agency fee

Trigger: a contractor quote over £250 arrives. Outcome: the landlord approves one total and sees the fee on the statement. Starts: quote received. Ends: statement sent.
Actors: Landlord, Letting agent
verified: not verified (set by verifying-journeys after a build passes)

## Experience journey (changed stages only)
| Stage | Actor | Action | Decision | Information needed | System | Friction | Evidence |
|---|---|---|---|---|---|---|---|
| Approve | Landlord | Opens the approval email and approves | Approve or query | The total, what the work is | Email, portal | Unknown | ASSUMED |
| Statement | Landlord | Reads the monthly statement | Query a line or not | Each repair cost and the fee line | Email (PDF) | Unknown | ASSUMED |
| Query | Letting agent | Answers a fee question | None | The terms of business | Phone, email | Unknown | ASSUMED |

## Task flow
| Step | Decision | Information needed | Failure → recovery |
|---|---|---|---|
| System adds 10% to the quote | None | Contractor amount | Amount missing → agent enters it |
| Landlord approves the total | Approve or query | One total | Landlord queries → agent explains the terms |
| Statement lists the fee | None | Fee per repair | Wrong fee → agent corrects the statement |

## Open unknowns
- Net or gross basis for the fee — UNKNOWN — Head of lettings
R
