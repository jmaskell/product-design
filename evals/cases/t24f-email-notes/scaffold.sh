#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
bash "$(dirname "$0")/../../fixtures/plan-visit-booking.sh" g2
cat > docs/plans/visit-booking/copy.md <<'EOT'
# Copy deck: visit-booking

1. Visit booked (tenant booked it: check step, mock chosen-check, then chosen-result)
Sent when the tenant presses Book visit (decision 1); the text goes the day before only if we hold a mobile number (decision 2), and the email carries a calendar invite whose update behaviour depends on the decision 2 spike; fallback: "Add the visit to your calendar."
Subject: Your repair visit is booked
Body: The contractor comes on {day}, {window}.

2. Visit moved (agent moved it: agent inbox, mock frame 3)
Every agent move sends this email whatever the reminder settings (decision 2), and when the visit is within 24 hours the text also goes if we hold a mobile; no apology because the tenant asked for it in most cases (decision 1, owner).
Subject: Your repair visit has moved
Body: The contractor now comes on {day}, {window}.

3. Reminder (the day before, mock none)
Sent at 6pm the day before on the channels the tenant chose (decision 2); it is not sent when the visit was booked less than 24 hours ahead because the booked email already says it (decision 1).
Subject: Your repair visit is tomorrow
Body: The contractor comes tomorrow, {window}.
EOT
