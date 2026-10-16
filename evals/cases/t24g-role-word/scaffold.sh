#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
bash "$(dirname "$0")/../../fixtures/plan-visit-booking.sh" g2
d=docs/plans/visit-booking
printf '| Booked | coordinator confirmed | "Your repairs coordinator has confirmed the slot" | The repairs coordinator confirmed it |\n' >> "$d/design.md"
printf '<p>Your repairs coordinator will confirm the slot.</p>\n' >> "$d/mocks/chosen-result.html"
grep -q 'repairs coordinator' "$d/mocks/chosen-result.html"
