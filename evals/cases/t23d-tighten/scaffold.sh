#!/usr/bin/env bash
# The harness rejects an add_dirs path outside the case directory, so the scaffold copies the shared fixture.
set -euo pipefail
cp -R "$(dirname "$0")/../../fixtures/lettings-ui/." .
# A check step with three cuttable lines and two keepers (the adult-at-home line, the phone number).
cat > src/components/ConfirmVisit.tsx <<'EOF'
export function ConfirmVisit({ when, contractor, onBook }: { when: string; contractor: string; onBook: () => void }) {
  return (
    <section>
      <h1>Check your visit</h1>
      <p>This page shows the details of the visit you're about to book.</p>
      <dl>
        <dt>When</dt><dd>{when}</dd>
        <dt>Who</dt><dd>{contractor}</dd>
      </dl>
      <p>You're about to book {contractor} for {when}.</p>
      <p>Someone over 18 must be home to let the contractor in.</p>
      <p>{contractor} will phone from 0117 496 0000 on the way.</p>
      <p>Once booked, this visit will also show on your repairs list.</p>
      <button onClick={onBook}>Book visit</button>
    </section>
  );
}
EOF
