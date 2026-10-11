#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
bash "$(dirname "$0")/../../fixtures/plan-contractor-date.sh" g2
m=docs/plans/contractor-date/mocks/repair-list.html
sed -i.bak 's#</ul>#<li>Joan Peters, 14 Elm Road — visit 12 Oct</li></ul>#' "$m"
rm "$m.bak"
grep -q 'Joan Peters' "$m"
