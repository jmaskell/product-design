#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
bash "$(dirname "$0")/../../fixtures/plan-visit-booking.sh" g2
m=docs/plans/visit-booking/mocks/chosen-pick.html
sed -i.bak 's#<button>Mon 19 Oct</button>#<button>Mon 19 Oct</button><span data-annotation style="outline:2px dashed \#c00">Focus starts here</span>#' "$m"
rm "$m.bak"
grep -q 'data-annotation' "$m"
