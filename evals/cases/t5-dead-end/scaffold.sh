#!/usr/bin/env bash
# The harness rejects an add_dirs path outside the case directory, so the scaffold copies the shared fixture.
# The design keeps the dead end after a decline, with no rationale for it. The review must find it.
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
mkdir -p docs/plans/decline-status
cat > docs/plans/decline-status/issue.md <<'EOF'
# Show a declined repair to the tenant

## Outcome
When a landlord declines a repair, the tenant sees the decision on their repair list.

## Problem
The tenant does not see the approval stage. When a landlord declines a repair over £250, the repair stays "In progress" on the tenant's repair list. Tenants phone the agent to ask what happens. KNOWN (agent interviews)

## Actors
- Tenant: reads the repair list on a phone.
- Letting agent: records the landlord's decision in the repairs inbox.
- Landlord: declines by a reply to the approval email.

## Scope
- Tenant repair list (`/repairs`): show a "Declined" status on the repair row.
- No change to the landlord email or the agent repairs inbox.

## Alternatives to the request
- Send the tenant an email on decline. Rejected: tenants check the portal, not email.
EOF
cat > docs/plans/decline-status/journey.md <<'EOF'
# Journey: a landlord declines a repair

Trigger: the landlord declines a repair over £250. Outcome: the tenant knows the decision.

| Stage | Actor | Action | System | What the tenant sees |
|---|---|---|---|---|
| Report | Tenant | Fills the repair form | Portal | "Reported" |
| Triage | Letting agent | Sets priority, gets a quote over £250 | Repairs inbox | "In progress" |
| Approve | Landlord | Replies "decline" to the approval email | Email | "In progress" |
| Record | Letting agent | Sets the repair to Declined | Repairs inbox | "Declined" |
| After decline | Tenant | Reads "Declined" on the repair list | Portal | "Declined" |
EOF
cat > docs/plans/decline-status/decisions.md <<'EOF'
# Decisions

## D1: Show "Declined" as a status pill on the repair row
Chosen: a grey "Declined" pill replaces "In progress" on the repair row. The row stays on the list.
Rejected: a banner at the top of the list. It pushes other repairs down on a phone.

```
+------------------------------------------+
| Boiler not heating water                 |
| Reported 2 Oct 2026          [Declined]  |
+------------------------------------------+
```

## D2: No reason text on the tenant view
Chosen: the tenant sees the status only. A landlord's reason can be about money or be personal.
Rejected: show the landlord's reason word for word.
EOF
