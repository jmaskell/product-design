#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../../fixtures/model-rules.sh"
perl -pi -e 's#^- Domain rules: none#- Domain rules: docs/domain-rules.md#' AGENTS.md
cat > docs/domain-rules.md <<'R'
# Domain rules
- Tenancy deposits must be protected in a government-approved scheme within 30 days. Source: Housing Act 2004 s213.
- Deposits are capped at five weeks' rent. Source: Tenant Fees Act 2019.
R
mkdir -p docs/plans/deposit-card
cat > docs/plans/deposit-card/issue.md <<'R'
# deposit-card — Pay the tenancy deposit by card in the portal

**Phases:** Medium — the tenant pays and the agent sees the payment
**Jobs:** T1 get a problem in the home fixed without chasing (new tenant starts well); A1 keep every repair moving to done

## Outcome
A new tenant pays their deposit by card in the portal and knows it is received.

## Trigger
The agency sends a tenancy offer and the tenant accepts.

## Current workaround
Tenants pay the deposit by bank transfer and the agent matches it by hand. ASSUMED

## Previous and next step
Before: the tenant accepts the tenancy offer. ASSUMED
After: the tenant gets the keys on the start date. ASSUMED

## Alternatives to the request
- Keep bank transfer — rejected, tenants ask for card.

## Evidence ledger
| Claim | Tag | Decision it affects |
|---|---|---|
| Tenants want to pay by card | ASSUMED | whether to build |

## Questions for Head of lettings
1. Which card provider does the agency use? — blocks the payment step

## Scope
In: card payment of the deposit. Out: rent payments.

## Acceptance criteria
- [ ] A new tenant can pay the deposit by card and sees a receipt.
R
cat > docs/plans/deposit-card/journey.md <<'R'
# Journey: new tenant pays the deposit

Trigger: the tenant accepts an offer. Outcome: the deposit is paid and recorded. Starts: offer accepted. Ends: payment confirmed.
Actors: Tenant, Letting agent
verified: not verified (set by verifying-journeys after a build passes)

## Experience journey (changed stages only)
| Stage | Actor | Action | Decision | Information needed | System | Friction | Evidence |
|---|---|---|---|---|---|---|---|
| Pay | Tenant | Opens the pay link and pays by card | Pay now or later | Amount, due date | Portal | Unknown | ASSUMED |
| Confirm | Letting agent | Sees the payment recorded | None | Which tenancy | Portal | None | ASSUMED |

## Task flow
| Step | Decision | Information needed | Failure → recovery |
|---|---|---|---|
| Tenant pays | Card or transfer | Amount | Card declined → tenant retries |

## Open unknowns
- Card provider — UNKNOWN — Head of lettings
R
