---
name: auditing-product-models
description: Use when the product docs (PRODUCT.md, docs/product/actors.md, canonical journeys) may no longer match the code; when asked to audit, check or refresh them, or to find what changed or is undocumented; or when a journey's Code files changed after its verified date.
---

# Auditing product models

Check the model against the code. Every finding carries evidence: a model quote, a file:line, or both. The owner decides which side is right. Never edit product code.

No model (no actors.md and no journeys)? Stop and offer product-design:modelling-products.

## 1. Scope

- Named jobs or journeys: those, plus the actors and constraints they use.
- "Since verified": per journey, `git log --since=<date> -- <Code: paths>`, with the later of `verified:` and `audited:`. Audit the journeys whose files changed. Audit a journey with neither date.
- Otherwise: the whole model.

## 2. Check

1. Anchors: each `Code:` path exists. On a miss, `git log --follow --name-status -- <old path>` finds the rename.
2. Journeys: per stage, the actor, action, decision and system still hold in the code.
3. actors.md: each actor and relationship against role checks, links sent by email or message, and hand-offs.
4. PRODUCT.md Capabilities and Constraints: each rule against the code that enforces it, value for value. `git log -S<value>` shows when a value changed and why.
5. Gaps: roles, routes, scheduled jobs and integrations with no actor, job or stage. A job in actors.md without a journey is known, not a gap.

## 3. Classify

| Type | Meaning | Severity |
|---|---|---|
| Drift | Model and code disagree | SIGNIFICANT; CRITICAL for a permission or a PRODUCT.md constraint |
| Phantom | Model describes it; no code does it | SIGNIFICANT |
| Gap | Code does it; model is silent | MINOR; SIGNIFICANT for a new actor |
| Stale anchor | A `Code:` path moved; behaviour is the same | MINOR |
| Unconfirmed | An `INFERRED` entry the code now confirms or contradicts | MINOR |

## 4. Report

Write docs/product/audit.md. Overwrite the last one.

```
# Product model audit — <date>
Scope: <…> · Verdict: <one line>

| Type | CRITICAL | SIGNIFICANT | MINOR |

### F1 — <Type>: <claim> (<severity>)
Model says: <quote, file>
Code does: <behaviour, file:line>
Likely intended: model | code | unclear — <commit, test or comment>
Proposed fix: <model patch> | <issue for product-design:designing-products>

## Next issues
- F<n>: <one-line problem>
```

In the reply, give the verdict and the counts. In one batched question, ask for each Drift and Phantom whether the model or the code is right, and for each Gap whether to add it to the model. Give your read first.

## 5. Apply the rulings

Without a ruling, patch only Stale anchors.

- Code is right: patch the model. Replace the old value everywhere in the model.
- Model is right: keep the model. Add an `UNKNOWN` Open unknown with the finding ID. Add the issue under Next issues.
- Gap the owner wants: a journey stage goes into that journey; a new actor goes into actors.md.

After you apply rulings to a journey, set its `audited:` line to the date. Never write `verified:`.
