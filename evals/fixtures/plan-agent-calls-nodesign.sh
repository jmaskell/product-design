#!/usr/bin/env bash
# Agent fixture plus docs/plans/agent-calls/ with an issue and a build plan for a new screen, and no design.md.
set -euo pipefail
fx="$(cd "$(dirname "$0")" && pwd)"
bash "$fx/lettings-agent.sh"
d=docs/plans/agent-calls
mkdir -p "$d"
cat > "$d/issue.md" <<'EOF'
# agent-calls — Agents see every call to applicants in one place

**Phases:** Medium — a new screen for the letting agent

## Outcome
Agent: "I can see who I called today and what happened, without opening each applicant." INFERRED (agent interviews)

## Scope
In: a new Calls screen listing calls across applicants (date, applicant, agent, outcome). Out: logging calls.
EOF
cat > "$d/plan.md" <<'EOF'
# Plan: agent-calls

1. Add a Call type to src/types.ts (id, applicantId, applicantName, agentName, at, outcome).
2. Add listCalls() to src/api/applicants.ts.
3. Build src/agent/CallsList.tsx and add its route to src/routes.ts.
EOF
