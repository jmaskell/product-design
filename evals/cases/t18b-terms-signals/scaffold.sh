#!/usr/bin/env bash
set -euo pipefail
fx="$(dirname "$0")/../../fixtures"
cp -R "$fx/lettings-code/." .
cp -R "$fx/lettings-extra/." .
