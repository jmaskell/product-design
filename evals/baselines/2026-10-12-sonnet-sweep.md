# Sonnet 5.5 sweep, 2026-10-12

All 45 cases, both arms, 3 runs each, `--model claude-sonnet-5-5 --judge-model sonnet`, on commit bc0c036. One batch, 5 cases at a time. Cost: $53.76 (API-equivalent, subscription). No timeouts, no limit errors.

This replaces the mixed-model numbers of 2026-10-11 and 2026-10-12 as the one comparable record. Earlier GREEN records ran on Opus 5.5 (session default) or on older text.

Pass = with ≥ 0.8 and with > without.

| Case | With | Without | Failing graders, with arm (per run) |
|---|---|---|---|
| smoke | 1 | 0 | — / — / — |
| t1-repeat-action | 0.33 | 0.17 | non-button-option, why-and-journey / why-and-journey / why-and-journey |
| t10-stops-at-g1 | 1 | 0 | — / — / — |
| t11-ratchet | 0.33 | 0.5 | tier-goes-up, tier-raise-line / tier-raise-line / tier-raise-line |
| t12-project-rule-wins | 1 | 0.78 | — / — / — |
| t13-tracker-unavailable | 1 | 0 | — / — / — |
| t14-review-page | 1 | 0 | — / — / — |
| t14b-review-page-g1 | 1 | 0 | — / — / — |
| t14c-notion-unavailable | 1 | 0 | — / — / — |
| t14d-mock-privacy | 1 | 0 | — / — / — |
| t15-comment-triage | 1 | 0.31 | — / — / — |
| t15b-mixed-comment | 1 | 0 | — / — / — |
| t15c-already-triaged | 0.96 | 0.88 | — / — / decision-needs-review |
| t16-model-from-code | 0.82 | 0.27 | — / contradiction-unknown, inferred-from-code, journey-anchored / contradiction-unknown, inferred-from-code, journey-anchored |
| t16b-model-from-interview | 1 | 0.33 | — / — / — |
| t16c-model-partial | 0.75 | 0.25 | actors-written / actors-written / actors-written |
| t16d-model-exists | 1 | 1 | — / — / — |
| t16e-depth-not-given | 1 | 0.33 | — / — / — |
| t16f-extend-one-job | 1 | 0.67 | — / — / — |
| t17-audit-report | 1 | 0.85 | — / — / — |
| t17b-audit-rulings | 0.97 | 0.69 | — / old-threshold-gone / — |
| t18-actors-missing | 1 | 0 | — / — / — |
| t18b-terms-signals | 1 | 0.17 | — / — / — |
| t19-ambiguous-rule | 0.89 | 0.67 | readings / — / readings |
| t19b-audit-position | 0.89 | 0.72 | — / match-not-flagged / match-not-flagged |
| t19c-no-signoff | 1 | 0.2 | — / — / — |
| t19d-privacy-gdpr | 0.95 | 0.71 | — / — / skill-fired |
| t19e-privacy-ccpa | 0.89 | 0.56 | — / — / ccpa-terms |
| t19f-reading-in-design | 0.73 | 0.47 | decisions-points-to-row / decisions-points-to-row, reply-merit / reply-merit |
| t2-displaced-work | 0.67 | 0.17 | — / no-design-before-answers / no-design-before-answers |
| t20-claims | 1 | 0.61 | — / — / — |
| t20b-stale-offer | 0.83 | 0 | offers-audit-merit / — / — |
| t21-internal-tool | 0.93 | 0.2 | — / reply-merit / — |
| t21b-big-launch | 0.87 | 0 | start-path / — / start-path |
| t21c-tier-1 | 0.33 | 0 | launch-tier-1, reply-merit / launch-tier-1, reply-merit, skill-fired / reply-merit |
| t21d-tier-2 | 0.44 | 0 | launch-tier-2, reply-merit / launch-tier-2, reply-merit / reply-merit |
| t2b-displaced-work-paraphrase | 1 | 0.17 | — / — / — |
| t3-no-evidence | 0.83 | 0.17 | — / unknowns-as-questions / unknowns-as-questions |
| t4-novice-vs-expert | 0.67 | 0 | names-tension / — / — |
| t5-dead-end | 1 | 0 | — / — / — |
| t6-trivial | 1 | 0.5 | — / — / — |
| t7-component-reuse | 0.78 | 0 | — / hand-built-flagged, options-named / — |
| t8-no-model | 0.67 | 0 | proceeds-and-offers-save / — / — |
| t8b-partial-model | 1 | 0.67 | — / — / — |
| t9-rationale-pressure | 1 | 0 | — / — / — |

Summary: 35 of 45 pass. Every case but t11 beats its without arm. t16d is a GUARD (without 1.0).

Below 0.8 with the plugin (Sonnet gaps; all but t19f, t21c and t21d passed on Opus in earlier rounds):
- t1, t2, t4, t7: design-phase reply content (why and journey, displacement before design, named tension, hand-built flag).
- t8: the offer to save the mapped journey.
- t11: Small work that should raise its tier stays Small (tier-raise-line 0/3).
- t16c: actors.md not written when PRODUCT.md exists.
- t19f, t21c, t21d: the gap cases of this round (reply reopens the reading; tier 1 and tier 2 reply content; t21c also loads the skill 1 of 3).

Not in this sweep: lenses-next 1b96a89 ("No reading waits on sign-off…", t19 sign-off mentions 0/5 on Sonnet).

## Re-run after ade3a79 (Sonnet 5.5, plugin arm only)

32 cases: the 11 below 0.8 at 5 runs, 21 regression cases at 3 runs. Without-arm scores are from the bc0c036 sweep (the without arm reads no skill text). Cost: $32.46 (API-equivalent, subscription).

| Case | With, bc0c036 | With, ade3a79 | Without | Failing graders, ade3a79 (per run) |
|---|---|---|---|---|
| smoke | 1 | 1 | 0 | — / — / — |
| t1-repeat-action | 0.33 | 0.8 | 0.17 | — / — / — / non-button-option, why-and-journey / — |
| t10-stops-at-g1 | 1 | 1 | 0 | — / — / — |
| t11-ratchet | 0.33 | 0.3 | 0.5 | tier-goes-up, tier-raise-line / tier-goes-up, tier-raise-line / tier-goes-up, tier-raise-line / — / tier-raise-line |
| t14b-review-page-g1 | 1 | 1 | 0 | — / — / — |
| t16-model-from-code | 0.82 | 0.85 | 0.27 | depth-held / depth-held / depth-held, threshold-question |
| t16b-model-from-interview | 1 | 1 | 0.33 | — / — / — |
| t16c-model-partial | 0.75 | 0.9 | 0.25 | — / — / actors-written / — / actor-kinds |
| t16d-model-exists | 1 | 0.89 | 1 | — / — / offers-audit |
| t16e-depth-not-given | 1 | 1 | 0.33 | — / — / — |
| t18-actors-missing | 1 | 1 | 0 | — / — / — |
| t19-ambiguous-rule | 0.89 | 0.83 | 0.67 | readings / readings / readings / readings / readings |
| t19b-audit-position | 0.89 | 0.94 | 0.72 | — / match-not-flagged / — |
| t19c-no-signoff | 1 | 0.93 | 0.2 | — / — / decisions-merit |
| t19d-privacy-gdpr | 0.95 | 0.95 | 0.71 | skill-fired / — / — |
| t19e-privacy-ccpa | 0.89 | 1 | 0.56 | — / — / — |
| t19f-reading-in-design | 0.73 | 0.92 | 0.47 | — / reply-merit / — / — / reply-merit |
| t2-displaced-work | 0.67 | 1 | 0.17 | — / — / — / — / — |
| t20-claims | 1 | 0.94 | 0.61 | — / — / valid-not-flagged |
| t20b-stale-offer | 0.83 | 1 | 0 | — / — / — |
| t21-internal-tool | 0.93 | 1 | 0.2 | — / — / — |
| t21b-big-launch | 0.87 | 0.73 | 0 | start-path / launch-tier-3, reply-merit, start-path / — |
| t21c-tier-1 | 0.33 | 0.13 | 0 | reply-merit / launch-tier-1, reply-merit, skill-fired / launch-tier-1, reply-merit, skill-fired / launch-tier-1, reply-merit, skill-fired / launch-tier-1, reply-merit, skill-fired |
| t21d-tier-2 | 0.44 | 0.53 | 0 | launch-tier-2, reply-merit / launch-tier-2, reply-merit / reply-merit / reply-merit / reply-merit |
| t2b-displaced-work-paraphrase | 1 | 0.67 | 0.17 | — / displaced-work, no-design-before-answers / — |
| t3-no-evidence | 0.83 | 1 | 0.17 | — / — / — |
| t4-novice-vs-expert | 0.67 | 1 | 0 | — / — / — / — / — |
| t6-trivial | 1 | 1 | 0.5 | — / — / — |
| t7-component-reuse | 0.78 | 0.93 | 0 | — / — / — / — / options-named |
| t8-no-model | 0.67 | 0.6 | 0 | proceeds-and-offers-save / — / — / — / proceeds-and-offers-save |
| t8b-partial-model | 1 | 1 | 0.67 | — / — / — |
| t9-rationale-pressure | 1 | 1 | 0 | — / — / — |

Now passing (were below 0.8): t1 0.80, t2 1.0, t4 1.0, t7 0.93, t16c 0.90, t19f 0.92.
Still below 0.8: t8 0.60, t11 0.30, t21c 0.13 (skill loads 1 of 5), t21d 0.53.
Dropped below 0.8: t21b 0.87 → 0.73, t2b 1.0 → 0.67 (one run each). Unverified: change or noise.
t19 scores 0.83, but its key grader `readings` fails 5/5.
Not re-run after ade3a79: the 13 cases not listed above (they read no changed line, or the sweep had them at 1.0 with no changed path), and every without arm.

## Re-runs after 09dfe57, 296eeed and c17f084 (Sonnet 5.5, plugin arm only)

| Commit | Change | Case (runs) | Before | After |
|---|---|---|---|---|
| 09dfe57 | Router: check where each new value comes from before each gate; G1 carries the journey save offer; CRITICAL-blocks-approval moves to synthesis.md | t11 (5) | 0.30 | 0.80 |
| 296eeed | mapping-journeys asks the save question in the reply; readings have a fixed slot, argument before risk | t8 (5) | 0.60 | 1.0 |
| 296eeed | same | t19 (5) | 0.83, `readings` 0/5 | 0.87, `readings` 1/5 |
| c17f084 | A lean has a slot with its argument | t19 (5) | 0.87, `readings` 1/5 | 0.93, `readings` 3/5 |

Regression, 3 runs each, after 09dfe57: smoke 1.0, t10 1.0, t14b 1.0, t18 1.0, t2b 1.0, t5 1.0, t8b 1.0, t9 1.0, t6 0.83, t20b 0.67 (offers-audit-merit 2/3; sweep 0.83, ade3a79 1.0), t21b 0.73, t21d 0.44.
After 296eeed: t16 1.0, t19b 1.0, t19c 0.93, t19d 1.0, t19e 0.78 (ccpa-terms 2/3; sweep 0.89), t21b 0.80. After c17f084: t19c 1.0.
t21b `start-path`: journey.md holds the start path as one line (e-IcdQCX: "Discover → Demo → Pilot … → First job closed"); the judge splits on it. The sweep failed it 2/3 too.
Unverified: whether t20b and t19e dips are noise. Both read no line changed in these commits except the router (t20b).
Still below 0.8: t21c (skill loads 1 of 5; the workflow names the skill), t21d 0.44.
Cost of these three re-runs: $22.55.

## Opus 5.5 check on 5bdbfcf (plugin arm, 1 run each)

33 changed cases (the ade3a79 re-run list plus t5). 32 score 1.0, including t21c and t21d. t7-component-reuse 0.67 (`options-named` fails in the one run). Cost: $24.42.
The Sonnet-driven wording did not lower Opus on any other case.
