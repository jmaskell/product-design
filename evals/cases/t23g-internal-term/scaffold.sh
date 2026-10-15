#!/usr/bin/env bash
# The harness rejects an add_dirs path outside the case directory, so the scaffold copies the shared fixture.
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings-ui/." .
# Two internal workflow statuses the tenant can see.
perl -0pi -e 's/"reported" \| "booked"/"reported" | "triage" | "awaiting_approval" | "booked"/' src/types.ts
grep -q 'awaiting_approval' src/types.ts
