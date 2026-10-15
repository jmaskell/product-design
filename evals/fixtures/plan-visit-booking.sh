#!/usr/bin/env bash
# Writes docs/plans/visit-booking/ at g1 (issue, journey) or g2 (plus design, decisions, mocks).
# g2 plants four lines a "needed now" review must quote (P1-P4) and one it must keep (K1).
set -euo pipefail
stage="${1:-g2}"
d=docs/plans/visit-booking
mkdir -p "$d/mocks"
cat > "$d/issue.md" <<'EOF'
# visit-booking — The tenant books the contractor visit

**Phases:** Medium — a new task flow for the tenant
**Jobs:** T1 get a problem fixed without chasing

## Outcome
Tenant: "I pick a time that suits me, without phoning." INFERRED (agent interviews: most chase calls are about the date)

## Trigger
The landlord approves the repair. KNOWN (repair-fixed journey)

## Current workaround
The contractor phones the tenant to agree a time. Missed calls take 2–3 tries. KNOWN (agent interviews, 2026-08)

## Rules
- Visits are on weekdays only. KNOWN (contractor contracts)
- One visit per repair. KNOWN (agent interviews)
- An adult must be home to let the contractor in. KNOWN (contractor contracts)

## Scope
In: pick a slot, check, confirm, see the booked visit on the repairs list. Out: rebooking.
EOF
cat > "$d/journey.md" <<'EOF'
# Journey: the tenant books the visit

Trigger: the landlord approves the repair. Outcome: the tenant is home when the contractor comes.
Actors: Tenant, Contractor

| Stage | Actor | Action | System | Evidence |
|---|---|---|---|---|
| Approved | Landlord | Approves the repair | Email | KNOWN |
| Pick a slot | Tenant | Picks a weekday 2-hour slot | Portal | INFERRED |
| Check | Tenant | Checks the slot and books it | Portal | INFERRED |
| Booked | Tenant | Sees the booking; gets an email and a text the day before | Portal, email, SMS | INFERRED |
| Return | Tenant | Opens the repairs list most weeks to see what's next | Portal | KNOWN (analytics: weekly) |
| Visit | Contractor | Phones from 0117 496 0000 on the way, then arrives | Phone | KNOWN |
EOF
[ "$stage" = "g1" ] && exit 0
cat > "$d/design.md" <<'EOF'
# Design: visit-booking

## Interface flow
Repairs list → Pick a slot (mocks/chosen-pick.html) → Check (mocks/chosen-check.html) → Booked (mocks/chosen-result.html) → Repairs list (mocks/chosen-list.html)

## Mocks
All hand-built: no component source.

## States
| Screen | State | What the person sees | How they got here |
|---|---|---|---|
| Pick | default | Weekdays with slots; weekends greyed and not clickable | From the repair row |
| Check | default | The slot, the contractor and the Book button | Picked a slot |
| Booked | default | The confirmation | Pressed Book |
| List | booked | The visit date on the repair row | Any later visit |
EOF
cat > "$d/decisions.md" <<'EOF'
# Decisions

## D1: Pick by day, then slot
Chosen: a week of days, then 2-hour slots. Rejected: one long list of slots. Why: on a phone the tenant finds their free day first.
EOF
cat > "$d/mocks/chosen-pick.html" <<'EOF'
<h1>Book a visit: Leaking kitchen tap</h1>
<p>Pick a weekday. You can book one visit per repair.</p>
<ul>
  <li><button>Mon 19 Oct</button></li><li><button>Tue 20 Oct</button></li>
  <li><button disabled aria-disabled="true">Sat 24 Oct</button></li>
</ul>
EOF
cat > "$d/mocks/chosen-check.html" <<'EOF'
<h1>Check your visit</h1>
<dl><dt>When</dt><dd>Tuesday 20 October, 9 to 11am</dd><dt>Who</dt><dd>Dan's Plumbing</dd><dt>Repair</dt><dd>Leaking kitchen tap</dd></dl>
<p>You're about to book Dan's Plumbing for Tuesday 20 October, 9 to 11am, for the leaking kitchen tap. We'll email you, and text you the day before.</p>
<p>Someone over 18 must be home to let the contractor in.</p>
<button>Book visit</button>
EOF
cat > "$d/mocks/chosen-result.html" <<'EOF'
<h1>Visit booked</h1>
<p>Tuesday 20 October, 9 to 11am, with Dan's Plumbing.</p>
<p>We've emailed you the details, told your landlord, and we'll text you a reminder the day before. Dan's Plumbing has been sent your address and access notes.</p>
<a href="/repairs">Back to your repairs</a>
EOF
cat > "$d/mocks/chosen-list.html" <<'EOF'
<h1>Your repairs</h1>
<p>Book a visit once your landlord approves a repair. You'll get a text the day before.</p>
<table><tr><th>Repair</th><th>Status</th><th>Visit</th></tr>
<tr><td>Leaking kitchen tap</td><td>Visit booked</td><td>Tue 20 Oct, 9–11am</td></tr></table>
EOF
