#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
bash "$(dirname "$0")/../../fixtures/plan-contractor-date.sh" g2
d=docs/plans/contractor-date
printf -- '\nReview page: file docs/plans/contractor-date/review.html · revision 1 · 2026-10-08\n' >> "$d/decisions.md"
cat > "$d/comments.md" <<'EOF2'
# Comments on review page revision 1 (pasted by the owner)

1. Priya Shah, on question 1: Yes, contractors move about one visit in five. But on the "Repair list" screen the old date stays on the row when a visit moves, so the tenant stays home on the wrong day.
2. Tom Reed, on the journey row "Agree date": Looks right to me.
EOF2
