#!/usr/bin/env bash
# The harness rejects an add_dirs path outside the case directory, so the scaffold copies the shared fixture.
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings-ui/." .
# Repairs can carry a booked visit date.
perl -0pi -e 's/  contractorName\?: string;\n\}/  contractorName?: string;\n  visitAt?: Date;\n}/' src/types.ts
grep -q 'visitAt' src/types.ts
