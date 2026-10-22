#!/usr/bin/env bash
# Writes docs/plans/tenancy-offer/ at g1 (issue, journey) or g2 (plus design, decisions, mocks).
# g2 plants five breaks a review must report (P1-P5) and one line it must keep (K1).
set -euo pipefail
stage="${1:-g2}"
d=docs/plans/tenancy-offer
mkdir -p "$d/mocks"
cat > "$d/issue.md" <<'EOF'
# tenancy-offer — The agent sends a tenancy offer

**Phases:** Medium — a new task flow for the letting agent
**Jobs:** A2 Let a home to a suitable applicant quickly

## Outcome
Agent: "Once I've picked the applicant, the offer goes in a minute, and I can see it went." INFERRED (agent interviews)

## Trigger
The agent picks an applicant for a home. KNOWN (letting process)

## Current workaround
Agents copy rent, deposit and term from the listing into an email by hand. Typos in the rent reach applicants about once a month. KNOWN (complaints log, 2026)

## Rules
- Rent, deposit and term are set on the listing. Every applicant for a home gets the same terms. KNOWN (agency policy)
- The offer is emailed to the applicant as soon as it is sent. KNOWN (current system)
- Junior agents can't see or take payments. KNOWN (agency policy)

## Scope
In: send the offer, see the sent offer, withdraw it. Out: negotiating terms.
EOF
cat > "$d/journey.md" <<'EOF'
# Journey: the agent sends a tenancy offer

Trigger: the agent picks an applicant. Outcome: the applicant has the offer and the agent can see it.
Actors: Letting agent, Junior agent, Applicant

| Stage | Actor | Action | System | Evidence |
|---|---|---|---|---|
| Pick | Letting agent | Opens the applicant from the applicants list | Portal | KNOWN |
| Send | Letting agent | Checks the terms and sends the offer | Portal, email | INFERRED |
| Sent | Letting agent | Sees the offer and its status | Portal | INFERRED |
| Receive | Applicant | Gets the offer email | Email | KNOWN |
| Withdraw | Letting agent | Withdraws an offer sent in error | Portal, email | INFERRED |
EOF
[ "$stage" = "g1" ] && exit 0
awk '{print} /^\| Letting agent \| internal role/{print "| Junior agent | internal role | A3 Answer applicant calls and keep applicant records up to date |"}' \
  docs/product/actors.md > docs/product/actors.md.tmp && mv docs/product/actors.md.tmp docs/product/actors.md
cat > "$d/design.md" <<'EOF'
# Design: tenancy-offer

## Interface flow
Applicants list (mocks/chosen-list.html) → Applicant (mocks/chosen-applicant.html) → Send offer (mocks/chosen-send.html) → Sent (mocks/chosen-sent.html)

## Routes and roles
| Route | Letting agent | Junior agent |
|---|---|---|
| /agent/applicants | yes | yes |
| /agent/applicants/:id | yes | yes |
| /agent/offers/new | yes | no |
| /agent/payments | yes | no |

## Mocks
All hand-built: no component source.
EOF
cat > "$d/decisions.md" <<'EOF'
# Decisions

## D1: Send from the applicant page
Chosen: the agent sends from the applicant they picked. Rejected: a separate offers area. Why: the agent is already on the applicant when they decide.
EOF
cat > "$d/mocks/chosen-list.html" <<'EOF'
<h1>Applicants</h1>
<table><tr><th>Name</th><th>Status</th><th>Applied</th></tr>
<tr><td><a href="chosen-applicant.html">Priya Shah</a><br><span class="pill">Shares an email</span> <span class="pill">Applied twice</span></td><td>Contacted</td><td>14 Oct</td></tr>
<tr><td><a href="#">Tom Okafor</a><br><span class="pill">Answers changed</span></td><td>New</td><td>18 Oct</td></tr></table>
EOF
cat > "$d/mocks/chosen-applicant.html" <<'EOF'
<!-- Viewed as: Junior agent -->
<nav><a href="chosen-list.html">Applicants</a> <a href="/agent/payments">Payments</a></nav>
<h1>Priya Shah</h1>
<h2>Contact</h2><dl><dt>Email</dt><dd>priya.shah@example.com</dd><dt>Phone</dt><dd>07700 900 456</dd></dl>
<div class="actions"><button>Reassign</button> <button>Close applicant</button></div>
<h2>Income and references</h2><dl><dt>Income</dt><dd>£38,000</dd><dt>References</dt><dd>2 received</dd></dl>
<a href="chosen-send.html">Send offer</a>
EOF
cat > "$d/mocks/chosen-send.html" <<'EOF'
<h1>Send offer: 4 Mill Lane</h1>
<p>To priya.shah@example.com (not checked)</p>
<label>Rent a month <input value="1200"></label>
<dl><dt>Deposit</dt><dd>£1,385</dd><dt>Term</dt><dd>12 months</dd></dl>
<p>Emails the offer to Priya Shah.</p>
<a href="chosen-sent.html">Send offer</a>
EOF
cat > "$d/mocks/chosen-sent.html" <<'EOF'
<h1>Priya Shah</h1>
<div class="toast">Offer sent. <button>Undo</button></div>
<p>Offer for 4 Mill Lane, sent 21 October.</p>
EOF
[ "$stage" = "g2" ] && exit 0
# g2notes: Build notes the review must check the mocks against, and a list mock that drifts from its Like: screen.
cat >> "$d/design.md" <<'EOF'

## Build notes
Applicant page:
- Page header: Reassign, Close applicant
- Groups, in order: Contact; Income and references
Applicants list:
- Like: src/agent/ApplicantsList.tsx
EOF
cat > "$d/mocks/chosen-list-v2.html" <<'EOF'
<div style="max-width: 40rem">
<h1>Applicants</h1>
<div class="card"><a href="chosen-applicant.html">Priya Shah</a><p>Contacted · applied 14 Oct</p></div>
<div class="card"><a href="#">Tom Okafor</a><p>New · applied 18 Oct</p></div>
</div>
EOF
sed -i.bak 's#(mocks/chosen-list.html)#(mocks/chosen-list-v2.html)#' "$d/design.md" && rm -f "$d/design.md.bak"
