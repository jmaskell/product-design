# RED baseline: modelling-products and auditing-product-models (2026-10-11)

Neither skill exists. Every case scores below 0.8 in the with arm. Three runs per case, sonnet judge, Claude Code 2.1.287. Scores below are the final run of each case, after the tightening noted further down.

| Case | With | Without | Failing graders (with arm, runs failed of 3) |
|---|---|---|---|
| t16-model-from-code | 0.70 | 0.19 | skill-fired (3), journey-anchored (2), depth-held (1), not-yet-modelled (1), actor-kinds (1) |
| t16b-model-from-interview | 0.56 | 0.28 | skill-fired (3), actor-kinds (2), no-journey (1), job-ids (1), owner-source (1) |
| t16c-model-partial | 0.67 | 0.25 | skill-fired (3), actor-kinds (1) |
| t16d-model-exists | 0.67 | 0.58 | skill-fired (3), offers-audit (1) |
| t17-audit-report | 0.64 | 0.69 | skill-fired (3), asks-ruling (2) |
| t17b-audit-rulings | 0.58 | 0.58 | skill-fired (3), old-threshold-gone (3) |

## Why each case fails

- t16, t16b: the run writes product docs without the skill, but never calls `modelling-products`. It often omits the four actor kinds, the job IDs or the `KNOWN (owner` tags. The without arm also lacks the relationship verbs and INFERRED tags.
- t16c: the run writes `actors.md` well enough, but the skill does not fire and the kinds column is sometimes missing.
- t16d: the run does not overwrite the existing docs. It does not always say that they exist or offer an audit (`offers-audit`).
- t17: the run audits well without the skill. It finds the threshold drift, the chase-landlord gap, the stale anchor and the Close phantom. It fails only on `skill-fired` and sometimes `asks-ruling`.
- t17b: the run applies the rulings, except that `PRODUCT.md` keeps £250 in two lines (9 and 16 of the lettings fixture). `old-threshold-gone` fails in every run in both arms.

## Tightened after a first pass

These cases scored 0.78 or higher in the with arm with no skill present, so they tested nothing.

- t16c scored 0.78 (grader set: no-product-overwrite, actors-written, actor-kinds). Added `skill-fired` (`modelling-products`). Now 0.67.
- t16d scored 0.78 (only `offers-audit` failed, in 2 of 3 runs). Added `skill-fired` (`modelling-products`). Now 0.67.
- t17 scored 0.87 with and without the skill. `skill-fired` now has `weight: 4`. Now 0.64.
- t17b scored 0.92. Added `skill-fired` (`auditing-product-models`) with `weight: 4`. Now 0.58.

Reason: the point of each case is that the named skill fires. Without the skill the model already does most of the task, so the outcome graders alone cannot show RED.

## Harness shapes that differ from the plan

- `--scaffold` accepts t16b with no scaffold and no `context:` block. R1 was not needed.
- No case failed to load. All graders in the brief load as written.
- The `skill-fired` grader (`tool_used: Skill`) counts in the with-arm score even though the harness calls `tool_used: Skill` graders a plugin-fired indicator. A missing skill lowers the score.
