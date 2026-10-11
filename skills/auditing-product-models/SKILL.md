---
name: auditing-product-models
description: Use when the product docs (PRODUCT.md, docs/product/actors.md, canonical journeys) may no longer match the code; when asked to audit, check or refresh them, or to find what changed or is undocumented; or when a journey's Code files changed after its verified date.
---

# Auditing product models

Check the model against the code. Each finding cites a model quote, a file:line, or both. The owner decides. Never edit product code. Never send the owner to anyone else for approval.

No actors.md and no journeys? Stop and offer product-design:modelling-products.

## 1. Scope

- Named jobs or journeys, with their actors and constraints.
- "Since verified": per journey, `git log --since=<later of verified:, audited:> -- <Code: paths>`. Audit those with changes, or with neither date.
- "Audit for <lens>": add that lens's rows in `references/lenses.md` (plugin file, two levels up) to the gap check.
- Otherwise: the whole model.

## 2. Check

1. Anchors: each `Code:` path exists. `git log --follow --name-status -- <old path>` finds a rename.
2. Journeys: each stage's actor, action, decision and system hold in code.
3. actors.md: actors and relationships against role checks, emailed links and hand-offs.
4. Constraints: each rule against its enforcing code, value for value (`git log -S<value>` shows why it changed). Judge by the owner's recorded interpretation, quoted, never a stricter reading. An `UNKNOWN` one goes under Unknowns, with readings per `references/lenses.md`.
5. Terms: code names against the Code name column. Drift, MINOR unless it hides a permission.
6. Signals: an event-sourced `Signal:` with no code is a Phantom, MINOR.
7. README and site claims: no code path, Phantom; a priced feature with no entitlement check, Drift; an outcome or numeric claim with no named proof, Unknowns.
8. Gaps: roles, routes, jobs and integrations with no actor, job or stage. A job without a journey is not a gap.

## 3. Classify

- Drift, model and code disagree: SIGNIFICANT; CRITICAL for a permission or a constraint.
- Phantom, claimed but not in code: SIGNIFICANT.
- Gap, in code but not the model: MINOR; SIGNIFICANT for a new actor.
- Stale anchor, a `Code:` path moved, same behaviour: MINOR.
- Unconfirmed, code confirms or contradicts an `INFERRED` entry: MINOR.

## 4. Report

Overwrite docs/product/audit.md.

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

Reply with the verdict and counts, then one batched question, your read first: per Drift and Phantom, is the model or the code right; per Gap, add it?

## 5. Apply the rulings

Without a ruling, patch only Stale anchors.

- Code is right: patch the model, replacing the old value everywhere.
- Model is right: keep it. Add an `UNKNOWN` Open unknown with the finding ID, and the issue under Next issues.
- A wanted Gap: a stage into its journey, a new actor into actors.md.

Then set each changed journey's `audited:` to the date. Never write `verified:`.
