#!/usr/bin/env bash
# Writes docs/plans/contractor-date/ at G1 or G2. The evidence names a member of the public on purpose: the page must drop it.
set -euo pipefail
stage="${1:-g2}"
d=docs/plans/contractor-date
mkdir -p "$d"
cat > "$d/issue.md" <<'EOF'
# contractor-date — Show the repair visit date to the tenant

**Phases:** Medium — a changed task flow for the tenant and a new step for the agent
**Jobs:** T1 get a problem fixed without chasing; A1 keep every repair moving

## Outcome
Tenant: "I know which day the contractor comes, without phoning." INFERRED (from agent interviews: most chase calls ask for the date)

## Trigger
The contractor agrees a visit date with the agent by phone or email. KNOWN (agent interviews)

## Current workaround
The tenant phones the agent. The agent searches email for the contractor's reply and reads the date out. KNOWN (agent interviews, 2026-08). One case: Joan Peters of 14 Elm Road phoned four times in one week. KNOWN (complaint log)

## Previous and next step
Before: the tenant reports the repair. KNOWN (repair-fixed journey)
After: the tenant is at home on the day. ASSUMED

## Evidence ledger
| Claim | Tag | Decision it affects |
|---|---|---|
| Most chase calls ask for the visit date | INFERRED (agent interviews) | D1 |
| Contractors agree dates by phone, not email, half the time | UNKNOWN | D2 |

## Questions for the Head of lettings
1. Do contractors ever change a date after they agree it? — blocks D2. Check with Priya Shah (Head of lettings).
2. Should a tenant be able to ask for a different day? — blocks scope. Check with Tom Reed (Letting agent).

## Scope
In: the date on the tenant repair list; the agent records the date. Out: tenant rebooking.
EOF
cat > "$d/journey.md" <<'EOF'
# Journey: the tenant knows the visit date

Trigger: the contractor agrees a date. Outcome: the tenant is at home on the day.
Actors: Tenant, Letting agent, Contractor
verified: not verified (set by verifying-journeys after a build passes)

## Experience journey (changed stages only)
| Stage | Actor | Action | Decision | Information needed | System | Friction | Evidence |
|---|---|---|---|---|---|---|---|
| Agree date | Contractor | Tells the agent a date | — | Tenant availability | Phone or email | Date lives in one inbox | KNOWN (agent interviews) |
| Record date | Letting agent | Today: nothing. Proposed: enters the date on the repair | — | The date | Repairs inbox | New step for the agent | INFERRED (design D2) |
| See date | Tenant | Today: phones the agent. Proposed: reads the date on the repair list | Stay home that day | The date | Portal | Today: a phone call | KNOWN (agent interviews) |

## Displacement check
| Removed or simplified for | Work now done by | Stage | Cost |
|---|---|---|---|
| Tenant: no chase call | Letting agent: enters each date | Record date | About 20 seconds per repair. ASSUMED |

## Open unknowns
- Contractors change dates after they agree them — UNKNOWN — Priya Shah (Head of lettings)
EOF
cat > "$d/decisions.md" <<'EOF'
# Decision record: contractor-date

## 1. Show the visit date on the repair row
- **Decision:** the repair row shows "Visit: Tue 14 Oct".
- **Rejected:** an email to the tenant. Tenants check the portal, not email.
- **Why:** the tenant opens the list on a phone and sees the day at once.
- **Evidence:** INFERRED (agent interviews)

## 2. The agent enters the date in the repairs inbox
- **Decision:** a date field on the repair in the agent inbox.
- **Rejected:** a link for the contractor to enter the date. Contractors do not log in.
- **Why:** the agent already has the contractor's reply open.
- **Rests on:** UNKNOWN — contractors agree dates by email half the time

Reviewed: usability, journey, accessibility — 3 findings folded, 1 dismissed, 0 tensions ruled (2026-10-08)
EOF
if [ "$stage" = "g2" ]; then
  mkdir -p "$d/mocks"
  cat > "$d/design.md" <<'EOF'
# Design: contractor-date

## Interface flow
Repair list → repair row shows the visit date → (no further step) — mocks/repair-list.html

## Mocks
mocks/repair-list.html — the tenant repair list with a visit date — hand-built: no component source

## States
| Screen | State | What the person sees | How they got here |
|---|---|---|---|
| Repair list | Date set | "Visit: Tue 14 Oct" on the row | The agent entered the date |
| Repair list | No date yet | "Visit: not booked yet" | The contractor has not replied |
EOF
  cat > "$d/mocks/repair-list.html" <<'EOF'
<!doctype html><html><head><meta charset="utf-8"><title>Repair list</title></head>
<body><main><h1>Your repairs</h1><ul>
<li>Boiler not heating water · In progress · <strong>Visit: Tue 14 Oct</strong></li>
<li>Kitchen tap drips · Reported · Visit: not booked yet</li>
</ul></main></body></html>
EOF
fi
