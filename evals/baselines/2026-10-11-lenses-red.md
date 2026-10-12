# RED record: lenses, compliance and model depth (cases t18 to t21b)

Date: 2026-10-11. Command per case: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --judge-model sonnet --case <case> --runs 3 -j 6`. 3 runs per arm. Judge: sonnet. No skill text changed since the cases were written.

Score = mean run score. The `skill-fired` grader counts at weight 1 in both arms (it is 0 in the without arm by construction).

| Case | With | Without | Failing graders (with arm) | Status |
|---|---|---|---|---|
| t18-actors-missing | 0.56 | 0.00 | offers-model 1/3, offers-model-merit 1/3 | RED |
| t18b-terms-signals | 0.33 | 0.17 | terms-section 0/3, terms-code-names 0/3, signals 0/3, signal-real-event 0/3 | RED |
| t19-ambiguous-rule | 0.83 | 0.61 | readings 0/3 | RED on `readings` (score above 0.8 because 5 other graders pass) |
| t19b-audit-position | 1.00 | 0.72 | none | PASSES-WITH (current skills) |
| t19c-no-signoff | 0.50 | 0.25 | compliance-lens 0/3, no-gate-files 0/3 | RED |
| t19d-privacy-gdpr | 0.95 | 0.71 | basis-left 1/3 fails | PASSES-WITH (current skills) |
| t19e-privacy-ccpa | 0.89 | 0.33 | no-lawful-basis 1/3 fails | PASSES-WITH (current skills) |
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

## PASSES-WITH cases (current skills)

t19b, t19d, t19e pass in the with arm on current skill text. They guard the audit skill and are not RED evidence for new text. AGENTS.md reserves GUARD for a case whose without arm scores 0.8 or more; none of these did in round 1. In round 2, t19d scored 0.86 in the without arm, so t19d now also meets the GUARD test. In t19b, `terms-drift` and `signal-missing` pass in both arms. Unverified: the likely cause is that the fixture names `repair_closed` and `tickets.ts` in the appended rows, so any reader finds them.

## Grader fixes made before this record

- Reply regexes use `target: last_message`. `source: reply` is rejected by the case loader ("graders.1.target: Invalid input"). First run of all cases failed to load; the second run is the one recorded.
- Inline `(?i)` removed from every pattern and replaced by `flags: i`, as `evals/README.md` requires. This applies to the t21 and t21b Launch regexes, which keep controller ruling R1 in every other respect: `Launch:\**\s*(tier\s*)?0` and `...3`.
- t19: the `interpretation-left` regex is replaced by two `tool_used` graders (Edit, Write) with `input_match: 'PRODUCT\.md[\s\S]*Interpretation:'`, min 0, max 0 (ruling R2).
- t19c: the prompt adds "This is a Medium change." (ruling R3).
- No grader was loosened or tightened to move a without-arm score.

## Round 2 (fix round 1): re-run of t19, t19c, t19d, t20, t21, t21b

Command per case: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --judge-model sonnet --case <case> --runs 3 -j 6 --json evals/results/lenses-red2-<case>.json` (t19c also `--keep-temp`). These scores replace the round 1 scores for these six cases. t18, t18b, t19b, t19e, t20b are unchanged from round 1.

| Case | With | Without | Failing graders (with arm) | Status |
|---|---|---|---|---|
| t19-ambiguous-rule | 0.83 | 0.67 | readings 0/3 | RED on `readings` |
| t19c-no-signoff | 0.75 | 0.25 | compliance-lens 0/3 | RED on `compliance-lens` |
| t19d-privacy-gdpr | 0.90 | 0.86 | basis-left 2/3 fail | PASSES-WITH; without arm 0.86 meets the GUARD test |
| t20-claims | 0.83 | 0.61 | numeric-unknown 2/3 fail, valid-not-flagged 1/3 fails | RED on `sms-phantom` (without 0/3, with 3/3); `numeric-unknown` is weak |
| t21-internal-tool | 0.40 | 0.27 | launch-tier-0 0/3, adoption 0/3, reply-merit 0/3 | RED |
| t21b-big-launch | 0.40 | 0.00 | launch-tier-3 0/3, start-path 0/3, reply-merit 0/3 | RED |

Why each RED grader fails:
- t19 readings: the with arm stops at G1 for a Large change and the reply says "no mocks yet". It sets out no readings of "fair and shown clearly". The without arm writes a plan with no readings. The `interpretation-left` graders (now anchored to the PRODUCT.md path) pass 3/3 in both arms, so they only guard against edits.
- t19c compliance-lens: with the approved issue.md and journey.md in the scaffold, the with arm now reaches G2 and writes `design.md`, `decisions.md` and three mocks (kept trace). Its decisions.md has no `Reviewed: ... compliance` line. It raised the tier from Medium to Large and ran four review lenses. The without arm writes only `design.md`, so `no-gate-files` fails there by file absence and passes in the with arm.
- t20 numeric-unknown (llm now): passes 3/3 in the without arm and 1/3 in the with arm, so it does not separate the arms. Unverified: the judge reads the report differently from run to run. sms-phantom separates them (3/3 vs 0/3). sms-merit passes 3/3 in both arms, so it also does not separate them.
- t21 launch-tier-0, adoption, reply-merit: `issue.md` has no `Launch:` slot and no adoption text. The with arm stops at G1 ("the process stops here for your approval"), so the reply states no learning plan or spreadsheet exit. no-padding passes 3/3 in both arms.
- t21b launch-tier-3, start-path, reply-merit: same `Launch:` gap. The journey has no start path for the block management company. The reply stops at G1 and names no buyer alternatives. `alternatives` (issue.md) passes in the with arm only.

## Grader changes

- t18 `offers-model` and t20b `offers-audit` are deleted (ruling R11, Task 5). Both were name-only regex graders: they passed only when the reply named the skill. The without arm cannot know the names `modelling-products` or `auditing-product-models`, so the graders measured the name, not the behaviour (AGENTS.md lesson). GREEN scores t18 and t20b on the merit llm graders (`offers-model-merit`, `offers-audit-merit`) plus `skill-fired`. The RED scores above include the deleted graders. On the merit graders alone, RED was t18 1/3 and t20b 2/3 in the with arm.

## Gap cases (2026-10-12)

Three cases for spec lines with no case: designing-interactions builds the owner's chosen reading into the flow (t19f), and launch tiers 1 and 2 (t21c, t21d). No skill text changed. Command per case: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --judge-model sonnet --case <case> --runs 3 -j 6 --keep-temp --json evals/results/lenses-gap-<case>.json`. Both arms ran in one run. `skill-fired` counts at weight 1 in both arms.

| Case | With | Without | Failing graders (with arm, fails out of 3) | Status |
|---|---|---|---|---|
| t19f-reading-in-design | 0.73 | 0.60 | reply-merit 3/3, decisions-points-to-row 1/3 | RED on `reply-merit` |
| t21c-tier-1 (tenant prompt) | 0.67 | 0.00 | reply-merit 3/3 | RED on `reply-merit` |
| t21c-tier-1 (first prompt, agents) | 0.44 | 0.00 | launch-tier-1 3/3, reply-merit 2/3 | Replaced: case design fault, see below |
| t21d-tier-2 | 0.33 | 0.00 | launch-tier-2 3/3, reply-merit 3/3 | RED |

No case is GUARD: every without arm scores below 0.8.

Why each grader fails:
- t19f reply-merit (with): the design follows the recorded reading, and `design-follows-reading` passes 3/3. But the review lenses re-raise the settled reading, and the skill turns it into a tension for the owner. Run 0 (`/private/tmp/e-3nYiLF`) decisions.md: "Tension: disclosure at approval vs the recorded 'one total' interpretation … Ruling: open — for the owner at G2", from a Walkthrough and a Usability finding. Its reply asks "Showing the fee at approval: keep 'one total' as it is, or allow the rate only?". Run 2 (`/private/tmp/e-WLwKyx`) has "Tension 2 — say 'fee' at approval?", from a SIGNIFICANT Walkthrough + Service + Accessibility finding, although its decisions.md says "Not reopened". Run 1 (`/private/tmp/e-vYv25z`) timed out at 600 s, so its reply is only the tier line. The without arm passes reply-merit 3/3: it follows the G1 decision and asks nothing about it.
- t19f decisions-points-to-row: passes 2/3 in the with arm. Run 2's decisions.md entry 2 cites "PRODUCT.md interpretation, KNOWN owner 2026-10-01. Not reopened", but the judge failed it 2 votes to 1 on a 15,371-character file. Unverified: judge noise on a long file. The without arm fails it by absence (no decisions.md). This is a path only the skill names (AGENTS.md lesson), so the grader is not RED evidence; `reply-merit` is the merit pair.
- t21c, first prompt ("filter the agent's repairs inbox"): the with arm writes `Launch: tier 0 — letting agents (internal staff)` in all three runs. The fixture's actors.md marks Letting agent as an "internal role", and references/lenses.md tier 0 is "A tool for our own staff". So tier 0 is a valid reading, and the regex cannot match valid output. The prompt changed to a change for tenants (external users): "On the tenant's repairs list, show the date each repair was reported next to its status." The graders kept their checks; only the path and the actor word changed. The first run's JSON is kept as `evals/results/lenses-gap-t21c-tier-1-agents.json`.
- t21c reply-merit (with, tenant prompt): issue.md has `Launch: tier 1` in 3/3 runs, and run 1 (`/private/tmp/e-CCtQgO`) writes both tier 1 answers in `## Launch` ("on /repairs, right after reporting … Does support need to know? — no"). The router sizes it Small, and the Small G2 reply carries no launch answers. Run 0 (`/private/tmp/e-5J1wTP`) reply names `issue.md — … launch` and nothing more. Run 1 says only "I've treated this as a quiet release with no announcement". The without arm writes no issue.md and no launch content.
- t21d launch-tier-2, reply-merit (with): all three runs write `Launch: tier 1` for landlords ("tier 1 — existing landlords — faster approvals", `/private/tmp/e-eRv4nG`, `e-DVGzAf`, `e-9VGWpl`). A reply-to-approve only helps a landlord who knows about it, so this is a tier 2 change. The replies answer only tier 1 questions ("Does support need to know? Yes. Agents need a short brief", run 2). They name no gaining segment, no one-line message, no channel and no adoption signal. All runs size it Large and stop at G1. The without arm writes `brief.md` with no launch content.
- skill-fired fails in every without arm, as expected.

No grader was changed to move an arm's score. The one case change is the t21c prompt, for the harness reason above.
