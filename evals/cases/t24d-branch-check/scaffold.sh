#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
bash "$(dirname "$0")/../../fixtures/plan-contractor-date.sh" g2
g() { git -c user.name=t -c user.email=t@example.test "$@"; }
git init -q -b main && git add -A
GIT_COMMITTER_DATE='2026-10-10T09:00:00' g commit -q -m 'plan: contractor-date' --date '2026-10-10T09:00:00'
git switch -q -c build/contractor-date
printf '| Repair list | Date changed | "Visit moved to Thu 16 Oct" | The contractor moved it |\n' >> docs/plans/contractor-date/design.md
git add -A
GIT_COMMITTER_DATE='2026-10-12T09:00:00' g commit -q -m 'plan: date-changed state' --date '2026-10-12T09:00:00'
git switch -q main
