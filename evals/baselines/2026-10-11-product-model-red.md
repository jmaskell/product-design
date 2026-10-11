# RED baseline: modelling-products and auditing-product-models (2026-10-11)

Neither skill exists. Every case scores below 0.8 in the with arm. Three runs per case, sonnet judge, Claude Code 2.1.287. Scores below are the final run of each case, after the tightening noted further down.

| Case | With | Without | Failing graders (with arm, runs failed of 3) |
|---|---|---|---|
| t16-model-from-code | 0.70 | 0.19 | skill-fired (3), journey-anchored (2), depth-held (1), not-yet-modelled (1), actor-kinds (1) |
| t16b-model-from-interview | 0.56 | 0.28 | skill-fired (3), actor-kinds (2), no-journey (1), job-ids (1), owner-source (1) |
| t16c-model-partial | 0.67 | 0.25 | skill-fired (3), actor-kinds (1) |
| t16d-model-exists (GUARD, not RED evidence) | 0.67 | 0.89 | offers-audit (3) |
| t17-audit-report (near-guard: without arm 0.83) | 0.78 | 0.83 | skill-fired (3), severity-set (3), likely-intended (2) |
| t17b-audit-rulings | 0.67 | 0.75 | skill-fired (3), close-unknown (3), verified-updated (3), no-code-edit (2), old-threshold-gone (1) |

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
## Fix round 1 (review rulings)

Scores above are from the fix-round runs (3 runs each, sonnet judge). The `skill-fired` weights of 4 are gone; every `skill-fired` grader has weight 1.

- t16d is a GUARD case. It checks that the skill does not rebuild an existing model. `skill-fired` is removed. Its 0.67 with score is not RED evidence: without the skill the run already leaves the docs alone (0.89 without).
- t17 gained `severity-set` (the words CRITICAL, SIGNIFICANT, MINOR, at least twice) and `likely-intended` (the threshold finding names the code as intended and cites the commit or its date). `threshold-drift` is now three lookaheads (250, 500, rules.ts in any order). The without arm scores 0.83, above 0.8. Fix round 1 added these two graders. t17 is recorded as near-guard. It fails RED on `skill-fired`, `severity-set` and `likely-intended`.
- t17b gained `verified-updated` (the `verified:` line mentions the audit), `close-unknown` (a Close finding is marked UNKNOWN with an F-number) and `journey-threshold` (the journey no longer says "Over £250"). `old-threshold-gone` uses `(?<!from )£250`, so a "raised from £250 to £500" note passes. The lookbehind loads without a regex error.
- t17b `reminder-documented` checks a stage table row only (`^\|.*(?:48\s*h|daily|remind|chase).*\|\s*$`, flags `im`). It does not match the unmodified fixture journey (checked by hand with grep -E in a temp copy of `model-with-history.sh`), so the old "did not chase" text in the Trigger line cannot pass it.
- `no-code-edit` and `no-code-write` use `"file_path"\s*:\s*"(?:[^"]*/)?src/`, so relative paths are caught. In t17b the with arm failed `no-code-edit` in 2 of 3 runs: a run edited a file under `src/` without the skill.

## Added in Task 2 (ruling R7)

The spec (D2 and the modelling-products modes) asks for two behaviours that no case tested: recommend a depth when the owner gives none, and extend the model by one job. Three runs per case, sonnet judge, run against the modelling-products skill at commit e55fbfc.

| Case | With | Without | Failing graders (with arm, runs failed of 3) |
|---|---|---|---|
| t16e-depth-not-given | 0.33 | 0.33 | recommends-tier (3) |
| t16f-extend-one-job (GUARD) | 1.00 | 0.75 | none |

- t16e: the skill fires and writes PRODUCT.md and actors.md, and no journey. The reply lists Core and Full as options and does not pick one. It does not show candidate journeys. The without arm fails the same way.
- t16f: `mapping-journeys` fires, not `modelling-products`. It writes one new journey with a `Code:` line, because `templates/journey.md` now has that line, and it leaves the model alone. The without arm fails only `code-anchored`. The case passes 0.8 with the current text, so it is a guard. No skill text was added for it.

## Final fix wave (rulings R11, R12)

Two t16 graders test spec lines that the review found missing. Three runs, both arms, sonnet judge, run against the modelling-products text at 183b2a9 (unchanged since f716257).

| Case | With | Without | Failing graders (with arm, runs failed of 3) |
|---|---|---|---|
| t16-model-from-code | 0.91 | 0.18 | product-sections (3) |

- `product-sections` (A1) is RED. Each with-arm run writes its own PRODUCT.md headings, and none has `## Capabilities and Constraints`. The without arm fails it too.
- `contradiction-unknown` (A2) is not RED. It passes 3 of 3 with and 0 of 3 without. The with arm writes the £250 / £500 contradiction as `UNKNOWN` in the journey's Open unknowns, for example "Approval threshold: £500 or £250 — UNKNOWN — owner" (Confirmed by a grep of the three with-arm traces). The template's Open unknowns line and the old "List it. Never pick a side." line produce it. The grader stays as a delta grader. The A2 skill line rewords the existing contradiction line. It adds no new behaviour.
- t17b `verified-updated` became `audited-line` (ruling R11: the audit writes `audited:`, never `verified:`). `verified-kept` checks that `verified: 2026-08-20` stays. t17 gained `journey-unchanged` (no ruling, so the journey keeps "Over £250"). I did not run these graders on the 183b2a9 text. The 183b2a9 audit skill writes `verified: <date> audit`, so `audited-line` and `verified-kept` fail on it by construction.
