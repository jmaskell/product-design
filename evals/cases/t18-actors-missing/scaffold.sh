#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings-code/." .
cp "$(dirname "$0")/../../fixtures/lettings-partial/PRODUCT.md" PRODUCT.md
