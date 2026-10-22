#!/usr/bin/env bash
# Agent fixture plus docs/plans/applicant-page/ with Build notes the build must follow (one note overrides the checklist default).
set -euo pipefail
fx="$(cd "$(dirname "$0")" && pwd)"
bash "$fx/lettings-agent.sh"
d=docs/plans/applicant-page
mkdir -p "$d"
cat > "$d/issue.md" <<'EOF'
# applicant-page — Agents work an applicant from one page

**Phases:** Medium — a new screen for the letting agent

## Outcome
Agent: "I can call, check and decide on an applicant from one page." INFERRED (agent interviews)

## Scope
In: the applicant page, Reassign, Close applicant. Out: offers.
EOF
cat > "$d/design.md" <<'EOF'
# Design: applicant-page

## Interface flow
Applicants list → Applicant page

## Build notes
Applicant page:
- Groups, in order: Contact; Money; Decision
- Page header: Reassign
- Close applicant sits at the foot of the page, after Decision (owner ruling: it is rare and final)
- Like: src/agent/ApplicantsList.tsx for headings and spacing
EOF
