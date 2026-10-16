#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
bash "$(dirname "$0")/../../fixtures/plan-visit-booking.sh" g2
d=docs/plans/visit-booking
sed -i.bak 's#</ul>#</ul><p>You can book up to 2 weeks ahead.</p>#' "$d/mocks/chosen-pick.html" && rm "$d/mocks/chosen-pick.html.bak"
grep -q '2 weeks ahead' "$d/mocks/chosen-pick.html"
cat >> "$d/design.md" <<'EOT'

## New patterns
Weekday slot list (mocks/chosen-pick.html; decisions 1 and 2). One week as a list of 5 weekday rows with ‹ and › arrow buttons either side of the date range, which is announced politely when it changes; back is disabled on the first week and forward is disabled on the last of the 2 weeks, with "You can book up to 2 weeks ahead." under the list (decision 2), and each weekday is a button that opens its 2-hour slots in the same row, one row open at a time, while a weekday with no free slot is greyed and disabled with ", no slots free" in its name (decision 1).

## Copy changed by the copy check
- "Choose a slot for your repair visit" → "Choose a slot" (rule 1).
- Week paging (decision 2): "Earlier" and "Later" text links → arrow buttons; new line on the last week: "You can book up to 1 week ahead."
- Last week (decision 2, revised): "You can book up to 1 week ahead." → "You can book up to 2 weeks ahead."
EOT
