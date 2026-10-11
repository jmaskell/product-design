# RED record: lenses, compliance and model depth (cases t18 to t21b)

Date: 2026-10-11. Command per case: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --judge-model sonnet --case <case> --runs 3 -j 6`. 3 runs per arm. Judge: sonnet. No skill text changed since the cases were written.

Score = mean run score. The `skill-fired` grader counts at weight 1 in both arms (it is 0 in the without arm by construction).

| Case | With | Without | Failing graders (with arm) | Status |
|---|---|---|---|---|
| t18-actors-missing | 0.56 | 0.00 | offers-model 1/3, offers-model-merit 1/3 | RED |
| t18b-terms-signals | 0.33 | 0.17 | terms-section 0/3, terms-code-names 0/3, signals 0/3, signal-real-event 0/3 | RED |
| t19-ambiguous-rule | 0.83 | 0.61 | readings 0/3 | RED on `readings` (score above 0.8 because 5 other graders pass) |
| t19b-audit-position | 1.00 | 0.72 | none | GUARD (with arm already passes every grader; existing audit skill) |
| t19c-no-signoff | 0.50 | 0.25 | compliance-lens 0/3, no-gate-files 0/3 | RED |
| t19d-privacy-gdpr | 0.95 | 0.71 | basis-left 1/3 fails | GUARD (with arm at 0.95) |
| t19e-privacy-ccpa | 0.89 | 0.33 | no-lawful-basis 1/3 fails | GUARD (with arm at 0.89) |
| t20-claims | 0.73 | 0.33 | numeric-unknown 0/3, valid-not-flagged 1/3 fails | RED |
| t20b-stale-offer | 0.56 | 0.11 | offers-audit 0/3, offers-audit-merit 1/3 fails | RED |
| t21-internal-tool | 0.50 | 0.17 | launch-tier-0 0/3, adoption 0/3 | RED |
| t21b-big-launch | 0.50 | 0.00 | launch-tier-3 0/3, start-path 0/3 | RED |

Per-grader pass counts (with arm, out of 3):
- t18: skill-fired 3, offers-model 1, offers-model-merit 1.
- t18b: skill-fired 3, no-journey 3, others 0.
- t19: skill-fired 3, no-gate 3, no-verdict 3, interpretation-left-Edit 3, interpretation-left-Write 3, readings 0.
- t19b: all 3.
- t19c: skill-fired 3, no-gate 3, compliance-lens 0, no-gate-files 0.
- t19d: all 3 except basis-left 2.
- t19e: skill-fired 3, ccpa-terms 3, no-lawful-basis 2.
- t20: skill-fired 3, sms-phantom 3, entitlement-gap 3, valid-not-flagged 2, numeric-unknown 0.
- t20b: skill-fired 3, offers-audit-merit 2, offers-audit 0.
- t21: skill-fired 3, no-padding 3, launch-tier-0 0, adoption 0.
- t21b: skill-fired 3, alternatives 3, launch-tier-3 0, start-path 0.

## Why each RED grader fails

- t18 offers-model: the skill designs from the code and does not offer `modelling-products` when actors.md is missing (1 of 3 runs does).
- t18b terms-section, terms-code-names, signals, signal-real-event: `modelling-products` writes no Terms section and no Signal lines yet. The without arm writes neither.
- t19 readings: the with arm stops at G1 ("I stopped at the first ..."), so the reply has no readings of the rule. The without arm writes a plan and does not set out readings.
- t19c compliance-lens, no-gate-files: `docs/plans/deposit-card/decisions.md` does not exist. Diagnosis run (1 run, kept trace): the with arm raises the tier from Medium to Large because of the legal duty, then stops at G1 and writes only `issue.md` and `journey.md`. The without arm writes `plan.md` and `open-questions.md`. Neither arm writes `decisions.md` or a `Reviewed:` line. See concerns in the report: the stop at G1 may stop the review step from running even with the prompt saying "Medium change".
- t20 numeric-unknown: the audit report does not mark the README's "40% faster" claim UNKNOWN next to the claim. Both arms miss it. sms-phantom passes in the with arm (3/3) and fails in the without arm (0/3).
- t20b offers-audit: the skill does not name `auditing-product-models` in the reply, although the docs were audited before the code changed. offers-audit-merit passes 2 of 3 by chance.
- t21 launch-tier-0, adoption: `issue.md` has no `Launch:` slot yet. The with arm writes `Phases: Large` and no adoption section.
- t21b launch-tier-3, start-path: same, no `Launch:` slot. The journey runs from the fault to the fix and has no start path for the block management company.

## GUARD cases

t19b, t19d, t19e pass in the with arm on current skill text. They are regression guards for the audit skill, not RED evidence for new text. In t19b, `terms-drift` and `signal-missing` pass in both arms. Unverified: the likely cause is that the fixture names `repair_closed` and `tickets.ts` in the appended rows, so any reader finds them.

## Grader fixes made before this record

- Reply regexes use `target: last_message`. `source: reply` is rejected by the case loader ("graders.1.target: Invalid input"). First run of all cases failed to load; the second run is the one recorded.
- Inline `(?i)` removed from every pattern and replaced by `flags: i`, as `evals/README.md` requires. This applies to the t21 and t21b Launch regexes, which keep controller ruling R1 in every other respect: `Launch:\**\s*(tier\s*)?0` and `...3`.
- t19: the `interpretation-left` regex is replaced by two `tool_used` graders (Edit, Write) with `input_match: 'PRODUCT\.md[\s\S]*Interpretation:'`, min 0, max 0 (ruling R2).
- t19c: the prompt adds "This is a Medium change." (ruling R3).
- No grader was loosened or tightened to move a without-arm score.
