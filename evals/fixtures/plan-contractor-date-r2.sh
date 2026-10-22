#!/usr/bin/env bash
# contractor-date after revision 1 was shared: four changed decisions, one release-blocking DPO question.
set -euo pipefail
bash "$(dirname "$0")/plan-contractor-date.sh" g2
d=docs/plans/contractor-date
cat >> "$d/issue.md" <<'EOT'

## Questions for the data protection officer
3. Can the visit date and the contractor's first name go in a text message to the tenant? — blocks release. Check with Sam Okafor (Data protection officer).
EOT
cat >> "$d/decisions.md" <<'EOT'

## 3. The row shows a time window as well as the day (after revision 1, Tom Reed, comment, 2026-10-11)
- **Decision:** the row shows "Visit: Tue 14 Oct, 8am to 12pm". Decision 1 showed the day only.
- **Why:** the tenant can go to work in the afternoon.
- **Evidence:** KNOWN (Tom Reed, comment, 2026-10-11)

## 4. The tenant gets a text when the date is set (after revision 1)
- **Decision:** a text goes when the agent saves the date, on top of the row.
- **Why:** tenants do not open the portal until they think a date exists.
- **Evidence:** INFERRED (agent interviews)

## 5. "Not booked yet" becomes "Waiting for the contractor" (after revision 1)
- **Decision:** the empty state names who the tenant is waiting for.
- **Evidence:** ASSUMED

## 6. The agent's date field accepts a window, not a single time (after revision 1)
- **Decision:** two selects, morning or afternoon, replace the time field.
- **Evidence:** KNOWN (Priya Shah, comment, 2026-10-11)

Review page: file docs/plans/contractor-date/review.html · revision 1 · 2026-10-10
EOT
