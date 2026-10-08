#!/usr/bin/env bash
# The harness rejects an add_dirs path outside the case directory, so the scaffold copies the shared fixture.
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
sed 's/^- Tracker: none$/- Tracker: linear/' AGENTS.md > AGENTS.md.tmp
mv AGENTS.md.tmp AGENTS.md
mkdir -p docs/plans/status
cat > docs/plans/status/issue.md <<'EOF'
# Tenant repair status page

## Outcome
A tenant knows where their repair is and what happens next, without a phone call to the agent.

## Problem
The tenant does not see the approval stage. A repair shows "In progress" from triage to close. Tenants phone the agent to ask for news. KNOWN (agent interviews)

## Actors
- Tenant: checks the repair on a phone.
- Letting agent: updates the repair stage in the repairs inbox.
- Landlord: approves spend over £250 by email.

## Scope
- New page: tenant repair status (`/repairs/:id`).
- The repair list links each row to the status page.

## Previous and next step
- Previous: the tenant reports a repair on the repair form.
- Next: the tenant confirms the repair works.

## Alternatives to the request
- Email the tenant at each stage. Rejected for now: tenants use the portal on a phone.

## Acceptance criteria
- The page shows the current stage: Reported, Waiting for landlord, Contractor booked, Fixed.
- Each stage shows one line that says what happens next and who acts.
- A declined repair shows the next step: the agent calls the tenant within 2 working days.
EOF
cat > docs/plans/status/journey.md <<'EOF'
# Journey: a tenant follows a repair

| Stage | Actor | Action | What the tenant sees |
|---|---|---|---|
| Report | Tenant | Fills the repair form | Reported. The agent reads it within 1 working day. |
| Approve | Landlord | Approves or declines spend over £250 | Waiting for landlord. Most landlords reply in 3 to 5 days. |
| Book | Letting agent | Emails the contractor | Contractor booked. The agent tells you the date. |
| Fix | Contractor | Does the work | Contractor booked. |
| Close | Letting agent | Marks the repair done | Fixed. Tell us if it is not working. |
EOF
cat > docs/plans/status/design.md <<'EOF'
# Design: tenant repair status page

## Layout (phone)

```
+--------------------------------------+
| < Repairs                            |
| Boiler not heating water             |
| Reported 2 Oct 2026                  |
|                                      |
| (x) Reported                         |
| (x) Waiting for landlord             |
| ( ) Contractor booked                |
| ( ) Fixed                            |
|                                      |
| Next: the landlord decides on the    |
| quote. Most reply in 3 to 5 days.    |
+--------------------------------------+
```

## States
- Declined: "The landlord declined this repair. Your agent will call you within 2 working days."
- Urgent safety repair: the page skips "Waiting for landlord". The work starts within 24 hours.

## Components
Hand-built. The repo has no component source.
EOF
cat > docs/plans/status/decisions.md <<'EOF'
# Decisions

## D1: Show four stages as a vertical list
Chosen: a vertical list of four stages with the current stage marked. It fits a phone screen.
Rejected: a horizontal progress bar. The stage names do not fit across a phone screen.

## D2: One "next step" line under the stages
Chosen: one sentence that names who acts next and when.
Rejected: a full history of events. Tenants ask "what happens next", not "what happened".
EOF
