#!/usr/bin/env bash
# GUARD for the branch check: a feature branch cut from main, where main's last commit touched the plan. No other branch is newer.
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
bash "$(dirname "$0")/../../fixtures/plan-contractor-date.sh" g2
g() { git -c user.name=t -c user.email=t@example.test "$@"; }
git init -q -b main && git add -A
GIT_COMMITTER_DATE='2026-10-10T09:00:00' g commit -q -m 'plan: contractor-date' --date '2026-10-10T09:00:00'
git switch -q -c feature/contractor-date-polish
