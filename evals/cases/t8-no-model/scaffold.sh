#!/usr/bin/env bash
# The harness rejects an add_dirs path outside the case directory, so the scaffold copies the shared fixture.
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings-bare/." .
