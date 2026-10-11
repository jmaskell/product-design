#!/usr/bin/env bash
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings/." .
bash "$(dirname "$0")/../../fixtures/plan-contractor-date.sh" g2
printf -- '- Review space: notion https://www.notion.so/example/0000000000000000000000000000000a\n' >> AGENTS.md
