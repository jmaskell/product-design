---
name: auditing-product-models
description: Use when the product docs (PRODUCT.md, docs/product/actors.md, canonical journeys) may no longer match the code; when asked to audit, check or refresh them, or to find what changed or is undocumented; or when a journey's Code files changed after its verified date.
---

# Auditing product models

Each finding cites a model quote, a file:line, or both. The owner decides. Never edit product code. Never send the owner to anyone else for approval.

No actors.md and no journeys? Stop and offer product-design:modelling-products.

## 1. Scope

- Named jobs or journeys and what they use.
- "Since verified": per journey, `git log --since=<later of verified:, audited:> -- <Code: paths>`. Audit those with changes, or with neither date.
- "Audit for <lens>": add that lens's rows (`references/lenses.md`, plugin file, two levels up) to the gap check.
- Otherwise: the whole model.

## 2. Check

1. Anchors: each `Code:` path exists. `git log --follow --name-status -- <old path>` finds a rename.
2. Journeys: each stage against code.
3. actors.md: actors and relationships against role checks, emailed or messaged links, and hand-offs. A role's link to a route it can't open: Drift.
4. PRODUCT.md Capabilities and Constraints: each capability and rule against its code, value for value. Judge by the owner's quoted interpretation, never a stricter one. A rule with no recorded interpretation (`UNKNOWN` or no line) goes under Unknowns with readings (`references/lenses.md`).
5. Terms: code names against the Code name column in PRODUCT.md `## Terms`. Drift, MINOR unless it hides a permission. `Seen by` against the screens each role can open; no `Seen by` column: Unknowns.
6. Signals: a `Signal:` event with no code: Phantom, MINOR.
7. README and site claims: no code path, Phantom; a priced feature with no entitlement check, Drift; an outcome or numeric claim with no named proof, Unknowns.
8. Gaps: roles, routes, scheduled jobs and integrations with no actor, job or stage. A job without a journey is not a gap.

## 3. Classify

- Drift, model and code disagree: SIGNIFICANT; CRITICAL for a permission or constraint.
- Phantom, claimed but not in code: SIGNIFICANT.
- Gap, in code but not the model: MINOR; SIGNIFICANT for a new actor.
- Stale anchor, a `Code:` path moved, same behaviour: MINOR.
- Unconfirmed, code confirms or contradicts an `INFERRED` entry: MINOR.

## 4. Report

Overwrite docs/product/audit.md. Set `audited:` to today on each journey you checked. Never write `verified:`.

```
# Product model audit — <date>
Scope: <…> · Verdict: <one line>

| Type | CRITICAL | SIGNIFICANT | MINOR |

### F1 — <Type>: <claim> (<severity>)
Model says: <quote, file>
Code does: <behaviour, file:line>
Likely intended: model | code | unclear — <commit, test or comment>
Proposed fix: <model patch> | <issue for product-design:designing-products>

## Unknowns
- <rule or claim, file>: <missing proof; readings>

## Next issues
- F<n>: <one-line problem>
```

Reply with the verdict, counts, then one batched question, your read first: per Drift and Phantom, model or code; per Gap, add it?

## 5. Apply the rulings

Without a ruling, patch only Stale anchors.

- Code is right: patch the model, replacing the old value everywhere.
- Model is right: keep it. Add an `UNKNOWN` with the finding ID to the journey's Open unknowns, and the issue under Next issues.
- A wanted Gap: a stage into its journey, a new actor into actors.md.
