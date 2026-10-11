#!/usr/bin/env bash
# Builds lettings-code plus the lettings model, with git history for the audit cases.
# The canonical journey anchors to src/routes/repair-form.ts, which a later commit renames.
set -euo pipefail
fx="$(cd "$(dirname "$0")" && pwd)"
cp -R "$fx/lettings-code/." .
cp "$fx/lettings/PRODUCT.md" PRODUCT.md
mkdir -p docs/product/journeys
cp "$fx/lettings/docs/product/actors.md" docs/product/actors.md
perl -pe 's#^(verified: .*)$#$1\nCode: src/routes/repair-form.ts, src/routes/inbox-detail.ts, src/routes/approve.ts#' \
  "$fx/lettings/docs/product/journeys/repair-fixed.md" > docs/product/journeys/repair-fixed.md

git init -q
git config user.email eval@example.com
git config user.name eval
mv src/routes/repairs-new.ts src/routes/repair-form.ts
perl -pi -e 's/APPROVAL_THRESHOLD_GBP = 500/APPROVAL_THRESHOLD_GBP = 250/' src/rules.ts
git add -A
GIT_AUTHOR_DATE=2026-08-01T10:00:00 GIT_COMMITTER_DATE=2026-08-01T10:00:00 git commit -q -m "Repairs portal and product model"
perl -pi -e 's/APPROVAL_THRESHOLD_GBP = 250/APPROVAL_THRESHOLD_GBP = 500/' src/rules.ts
git add -A
GIT_AUTHOR_DATE=2026-09-03T10:00:00 GIT_COMMITTER_DATE=2026-09-03T10:00:00 git commit -q -m "Raise landlord approval threshold to £500 (agency policy from September)"
git mv src/routes/repair-form.ts src/routes/repairs-new.ts
GIT_AUTHOR_DATE=2026-09-15T10:00:00 GIT_COMMITTER_DATE=2026-09-15T10:00:00 git commit -q -m "Rename repair form route"
