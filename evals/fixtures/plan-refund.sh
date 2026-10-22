#!/usr/bin/env bash
# A refunds admin app with docs/plans/refund-request/.
#   g1:    issue.md and journey.md only (G1 approved, no design yet).
#   drift: plus design.md and a build that drifts from it in five places (D1-D5), plus one generic bug (G1).
#   clean: plus design.md and a build that matches it; G1 stays (it is code review's job, not the design's).
set -euo pipefail
stage="${1:-drift}"
d=docs/plans/refund-request
mkdir -p "$d" docs/product src/components src/refunds

cat > AGENTS.md <<'EOF'
# Shop admin

Support agents refund customers' orders.

## Project metadata
- Tracker: none
- Plan directory: docs/plans/
- Component source: src/components/
- Domain rules: none
EOF

cat > PRODUCT.md <<'EOF'
# Shop admin

## Terms
| Term | Meaning | Code name | Seen by |
|---|---|---|---|
| order | What a customer bought in one checkout | Order | Support agent, Customer |
| refund | Money returned to the customer for an order | Refund | Support agent, Customer |

## Constraints
- A support agent opens only refunds for orders in their own region. KNOWN (support policy)
EOF

cat > docs/product/actors.md <<'EOF'
# Actors

| Actor | Kind | Jobs |
|---|---|---|
| Support agent | internal role | S1 Put a customer's order right quickly |
| Customer | person | C1 Get my money back when an order goes wrong |
EOF

cat > src/components/OrdersList.tsx <<'EOF'
import type { Order } from "../types";

export function OrdersList({ orders }: { orders: Order[] }) {
  return (
    <div className="max-w-3xl">
      <ul className="list-plain">
        {orders.map((o) => (
          <li key={o.id} className="row">
            <a href={`/orders/${o.id}`}>Order {o.number}</a>
            <span className="muted">{o.placedOn}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}
EOF

cat > "$d/issue.md" <<'EOF'
# refund-request — Support agents refund an order

**Phases:** Medium — a changed task flow for the support agent
**Jobs:** S1 Put a customer's order right quickly

## Outcome
Agent: "I refund the order while the customer is still on the phone, and I can see it went." INFERRED (support interviews)

## Rules for the owner
- Small refunds skip the check step: under £20 the agent sends straight from the form. KNOWN (owner, G1)

## Scope
In: refund an order, see recent refunds. Out: partial refunds by line item.

## Acceptance criteria
- [ ] An agent can refund an order and sees the refund confirmed.
EOF

cat > "$d/journey.md" <<'EOF'
# Journey: a support agent refunds an order

Trigger: a customer asks for their money back. Outcome: the refund is sent and the agent can see it.
Actors: Support agent, Customer
verified: not verified (set by verifying-journeys after a build passes)

## Task flow
| Step | Decision | Information needed | Failure → recovery |
|---|---|---|---|
| Open the order | Is this the right order? | Order number, customer | Wrong order → back to search |
| Enter the amount | How much to refund? | Order total | Amount over total → error on the field |
| Check | Is the amount right? | Amount, customer | Wrong → edit |
| Send | — | — | Payment provider down → error, nothing sent |
| See recent refunds | Did it go? | Last 10 refunds | — |

## Displacement check
| Removed or simplified for | Work now done by | Stage | Cost |
|---|---|---|---|
| Check step, for refunds under £20 — removed | Support agent, at Enter the amount | Check | A slip in the amount field is sent at once |
EOF

[ "$stage" = "g1" ] && exit 0

cat > "$d/design.md" <<'EOF'
# Design: refund-request

## Interface flow
Order → Refund form → under £20: sent, the form shows the result; £20 or more: Check refund (src/refunds/CheckRefund.tsx, existing, unchanged)
Recent refunds: a list on the agent's home

## States
| Screen | State | What the person sees | How they got here |
|---|---|---|---|
| Refund form | default | Amount field, Send refund button | Opened from the order |
| Refund form | error | "Enter an amount up to £{total}" under the field | Amount over the order total |
| Refund form | provider error | "Refund not sent. Try again." under the field | The payment provider failed; nothing was sent |
| Refund form | sent | "Refund of £{amount} sent to {customer}" | Sent a refund under £20 |
| Recent refunds | empty | "No refunds yet" | No refunds this agent can open |
| Recent refunds | See all | Link "See all refunds" under the list | more than 10 refunds this agent can open |

## Build notes
Refund form:
- Guard: Check step (removed for refunds under £20) stopped a refund sent by pressing Enter in the amount field — keep by: only the Send refund button sends; Enter in a field does not submit
Recent refunds:
- Like: src/components/OrdersList.tsx

## Copy
Refund form: Refund order {number}; Amount; Send refund; Enter an amount up to £{total}; Refund not sent. Try again.; Refund of £{amount} sent to {customer}
Recent refunds: Recent refunds; No refunds yet; See all refunds
EOF

cat > src/types.ts <<'EOF'
export type Agent = { id: string; region: string };
export type Order = { id: string; number: string; placedOn: string; total: number; region: string; customer: string };
export type Refund = { id: string; orderNumber: string; amount: number; customer: string; region: string; sentOn: string };
EOF

cat > src/refunds/CheckRefund.tsx <<'EOF'
// The existing check step for refunds of £20 or more. Unchanged by this build.
export function CheckRefund({ amount, customer, onSend }: { amount: string; customer: string; onSend: () => void }) {
  return (
    <section>
      <h1>Check refund</h1>
      <p>Refund {amount} to {customer}</p>
      <button type="button" onClick={onSend}>Send refund</button>
    </section>
  );
}
EOF

# G1: a generic bug design.md says nothing about (float pence). Present in both builds.
cat > src/money.ts <<'EOF'
export const toPence = (amount: number) => amount * 100;
export const formatPounds = (amount: number) => `£${amount.toFixed(2)}`;
EOF

if [ "$stage" = "drift" ]; then
cat > src/refunds/api.ts <<'EOF'
import { db } from "../db";
import type { Agent, Refund } from "../types";
import { toPence } from "../money";

const canOpen = (agent: Agent, r: Refund) => r.region === agent.region;

// Recent refunds for the list: newest first, one extra to know whether to show "See all".
export async function listRecentRefunds(agent: Agent): Promise<Refund[]> {
  const rows: Refund[] = await db.refunds.findMany({ orderBy: { sentOn: "desc" }, take: 11 });
  return rows.filter((r) => canOpen(agent, r));
}

export async function sendRefund(orderId: string, amount: number) {
  return db.payments.refund({ orderId, pence: toPence(amount) });
}
EOF
cat > src/refunds/RefundsList.tsx <<'EOF'
import type { Refund } from "../types";
import { formatPounds } from "../money";

export function RefundsList({ refunds }: { refunds: Refund[] }) {
  if (refunds.length === 0) return <p className="muted">No refunds yet</p>;
  return (
    <section>
      <h1>Recent refunds</h1>
      <table className="table-striped" style={{ maxWidth: "40rem" }}>
        <tbody>
          {refunds.slice(0, 10).map((r) => (
            <tr key={r.id}><td>Order {r.orderNumber}</td><td>{formatPounds(r.amount)}</td><td>{r.sentOn}</td></tr>
          ))}
        </tbody>
      </table>
      {refunds.length >= 10 && <a href="/refunds/all">See all refunds</a>}
    </section>
  );
}
EOF
else
cat > src/refunds/api.ts <<'EOF'
import { db } from "../db";
import type { Agent, Refund } from "../types";
import { toPence } from "../money";

// Recent refunds this agent can open: newest first, one extra to know whether to show "See all".
export async function listRecentRefunds(agent: Agent): Promise<Refund[]> {
  return db.refunds.findMany({ where: { region: agent.region }, orderBy: { sentOn: "desc" }, take: 11 });
}

export async function sendRefund(orderId: string, amount: number) {
  return db.payments.refund({ orderId, pence: toPence(amount) });
}
EOF
cat > src/refunds/RefundsList.tsx <<'EOF'
import type { Refund } from "../types";
import { formatPounds } from "../money";

export function RefundsList({ refunds }: { refunds: Refund[] }) {
  if (refunds.length === 0) return <p className="muted">No refunds yet</p>;
  return (
    <div className="max-w-3xl">
      <h1>Recent refunds</h1>
      <ul className="list-plain">
        {refunds.slice(0, 10).map((r) => (
          <li key={r.id} className="row">
            <span>Order {r.orderNumber}</span> <span>{formatPounds(r.amount)}</span>
            <span className="muted">{r.sentOn}</span>
          </li>
        ))}
      </ul>
      {refunds.length > 10 && <a href="/refunds/all">See all refunds</a>}
    </div>
  );
}
EOF
fi

cat > src/refunds/RefundForm.tsx <<'EOF'
import { useState } from "react";
import { sendRefund } from "./api";
import type { Order } from "../types";
import { formatPounds } from "../money";

export function RefundForm({ order, onSent, onCheck }: { order: Order; onSent: (msg: string) => void; onCheck: (amount: number) => void }) {
  const [amount, setAmount] = useState("");
  const [message, setMessage] = useState("");
  async function send() {
    const value = Number(amount);
    if (value > order.total) return setMessage(`Enter an amount up to ${formatPounds(order.total)}`);
    if (value >= 20) return onCheck(value); // £20 or more goes to the existing check step
    try {
      await sendRefund(order.id, value);
    } catch {
      return setMessage("Refund not sent. Try again.");
    }
    setMessage(`Refund of ${formatPounds(value)} sent to ${order.customer}`);
    onSent(order.id);
  }
  // Enter in a field must not send: only the Send refund button does.
  return (
    <form onSubmit={(e) => e.preventDefault()}>
      <h1>Refund order {order.number}</h1>
      <label>Amount <input inputMode="decimal" value={amount} onChange={(e) => setAmount(e.target.value)} /></label>
      {message && <p role="status">{message}</p>}
      <button type="button" onClick={send}>Send refund</button>
    </form>
  );
}
EOF
if [ "$stage" = "drift" ]; then
  # D1 Enter submits; D5 copy drift (button and result).
  sed -i.bak \
    -e 's#<form onSubmit={(e) => e.preventDefault()}>#<form onSubmit={(e) => { e.preventDefault(); send(); }}>#' \
    -e '/Enter in a field must not send/d' \
    -e 's#<button type="button" onClick={send}>Send refund</button>#<button type="submit">Submit</button>#' \
    -e 's#setMessage(`Refund of ${formatPounds(value)} sent to ${order.customer}`);#setMessage("Refund processed successfully");#' \
    src/refunds/RefundForm.tsx && rm -f src/refunds/RefundForm.tsx.bak
fi

# Commit the scaffold so the verifier can diff the build against main.
if [ ! -d .git ]; then
  git init -q -b main
  git -c user.email=fixture@example.com -c user.name=Fixture add AGENTS.md PRODUCT.md docs src/components src/types.ts src/money.ts src/refunds/CheckRefund.tsx
  git -c user.email=fixture@example.com -c user.name=Fixture commit -qm "Shop admin before the refund build"
  git checkout -qb refund-request
  git -c user.email=fixture@example.com -c user.name=Fixture add -A
  git -c user.email=fixture@example.com -c user.name=Fixture commit -qm "Build refund-request"
fi
