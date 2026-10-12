# GREEN record: lenses, compliance and model depth (2026-10-11)

Compare with `2026-10-11-lenses-red.md`. Sonnet judge, with and without arms in one run, threshold 0.8. Command: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --judge-model sonnet --case <case> --runs N -j 6 --json <file>`. Counts come from the task reports and the ledger in `.superpowers/sdd/2026-10-11-lenses-and-model-depth/`. The result JSON files in `evals/results/` are not in git. Where two sources disagree, this record uses the later one and says so. The `## Final fix wave` section at the end supersedes the scores below for every case it re-ran.

Last text commit per skill (after the final fix wave):
- `references/lenses.md` and `templates/issue.md`: 1307548.
- modelling-products: da614bb.
- auditing-product-models: 1307548.
- router (designing-products): 1307548.
- framing-problems: fdf5d7a (81b6b75 and 1307548 before it).
- mapping-journeys and designing-interactions: a310f27.
- reviewing-product-design: 1307548 (reviewer-prompt.md only).

## Scores: new cases

| Case | With | Without | Runs | Failing graders (with arm) | Text the run used | On final text? |
|---|---|---|---|---|---|---|
| t18-actors-missing | 1.00 | 0.00 | 5 | none (skill-fired 5/5, offers-model-merit 5/5) | dfd0960 | superseded, see Final fix wave |
| t18b-terms-signals | 1.00 | 0.17 | 5 | none (signals 5/5) | da614bb | yes |
| t19-ambiguous-rule | 1.00 | 0.63 | 5 | none (readings 5/5 v 0/5) | 66af2ea, grader at 2dc83e2 | superseded, see Final fix wave |
| t19b-audit-position (PASSES-WITH) | 1.00 | 0.78 | 3 | none | 4c2e494 | no |
| t19c-no-signoff | 0.90 | 0.25 | 5 | compliance-lens 3/5 (2 timeouts before the Reviewed line) | ed09e16 | superseded, see Final fix wave |
| t19d-privacy-gdpr (GUARD) | 1.00 | 0.74 | 5 | none | 4c2e494 | no |
| t19e-privacy-ccpa (PASSES-WITH) | 0.87 | 0.40 | 5 | ccpa-terms 1, no-lawful-basis 1 | 43dc02a | no |
| t20-claims | 0.97 | 0.63 | 5 | valid-not-flagged 1 | 4c2e494 | no |
| t20b-stale-offer | 0.80 | 0.00 | 5 | offers-audit-merit 3/5 (merit only: 3/5 GREEN v 2/3 RED, no measured lift; the 0.80 total includes skill-fired 5/5) | dfd0960 | superseded, see Final fix wave |
| t21-internal-tool | 1.00 | 0.20 | 3 | none | 66af2ea | no |
| t21b-big-launch | 1.00 | 0.00 | 3 | none | 66af2ea | no |

RED for comparison: t18 0.56/0.00, t18b 0.33/0.17, t19 0.83/0.67, t19b 1.00/0.72, t19c 0.75/0.25, t19d 0.90/0.86, t19e 0.89/0.33, t20 0.83/0.61, t20b 0.56/0.11, t21 0.40/0.27, t21b 0.40/0.00 (round 2 where the RED record has one).

Notes per case:
- t19: the 5-run result before the lean text (a310f27 text, first `readings` grader) scored 1.00/0.67. After the lean text (66af2ea) the R12 grader scored 0.90/0.67 (readings 2/5). A local re-judge passed the 4 failing replies. R14 named the reading in the grader. The R14 run is the number in the table. Without arm: readings 0/5.
- t19c: 4 of 5 with-arm runs hit the 600 s timeout. The files and the Reviewed line were on disk in the 3 runs that reached the write. On ed09e16 alone: 0.90/0.25. The earlier batch on 293838f scored 1.00/0.25 (5 runs; 4/5 timeouts). The ed09e16 fix1 batch lost its timing to a session limit (5 runs, 1.00/0.25). The fix2 batch is the 0.90/0.25 row. The two batches on ed09e16 (fix1 and fix2, 10 with-arm runs) gave 8 Reviewed lines that name compliance; the other 2 timed out before the write. Without arm 0/10. The 293838f batch (5 runs, compliance-lens 5/5) is separate. Grader labels: `no-gate` (reply) is a GUARD, it passes in both arms and was never RED. `no-gate-files` is a file-absence check: the without arm fails it because it writes no decisions.md. `compliance-lens` checks the skill's lens name in the skill's file, so it measures vocabulary, not behaviour. The Final fix wave adds `decisions-merit`.
- t19d: GUARD. The without arm scored 0.86 in RED round 2 and 0.71 to 0.77 in GREEN.
- t19e: not re-run after the auditing-product-models fix round (4c2e494). The 0.87/0.40 run is from 43dc02a. An earlier 3-run result on the first text was 0.78/0.56. The with arm lost skill-fired once on t19d (0.90/0.71, 3 runs, 43dc02a) and once on t19e. Unverified: the cause is description noise.
- t20: sms-phantom separates the arms (RED 3/3 v 0/3). The 3-run result on 43dc02a was 1.00/0.61. t20 `numeric-unknown` and `sms-merit` do not separate arms (judge noise).
- t20b: on the one behaviour grader, `offers-audit-merit`, the with arm passed 3/5 on dfd0960 against 2/3 in RED (before the router line). That is no measured lift. The 0.80 total comes from adding `skill-fired` (5/5). Exactly at the 0.80 bar. Both failing runs said git did not run in the sandbox ("xcode-select error"). They found the drift by reading the files, and the judge failed them because the reply did not say the code changed after the last check. See Open risks.
- t21: round 6 on a310f27 scored 1.00/0.24 (5 runs). The 66af2ea number is 3 runs.
- t21b: round 6 on a310f27 scored 0.96/0.00 (5 runs; start-path 4/5). The 66af2ea number is 3 runs. The later source wins.
- t18b: pooled `signals` on the final text is 7/8 (fix round 1: 2/3; fix round 2: 5/5). See Open risks.

## Scores: existing cases re-run this round

| Case | With | Without | Runs | Text the run used | On final text of the skill it covers? |
|---|---|---|---|---|---|
| t16-model-from-code | 1.00 | 0.18 | 5 | b9d9525 (v3) | no, modelling-products changed in da614bb |
| t16b-model-from-interview | 1.00 | 0.28 | 3 | b9d9525 (v3) | no |
| t16c-model-partial | 1.00 | 0.25 | 3 | b9d9525 (v3) | no |
| t16d-model-exists (GUARD) | 1.00 | 0.80 | 5 | 1a3db20 (grader R10; skill da614bb) | yes for modelling-products; no for the router (dfd0960). A router-regression 3-run result on 58e93b6 was 1.00/0.78, before dfd0960 |
| t16e-depth-not-given | 1.00 | 0.33 | 3 | b9d9525 (v3) | no |
| t17-audit-report (near-guard) | 1.00 | 0.85 | 3 | 4c2e494 | yes |
| t17b-audit-rulings | 1.00 | 0.69 | 5 | 4c2e494 | yes |
| t1-repeat-action | 0.83 | 0.83 | 3 | 66af2ea | yes. Delta 0 |
| t3-no-evidence | 1.00 | 0.25 | 3 | 66af2ea | yes |
| t4-novice-vs-expert | 0.80 | 0.00 | 5 | 293838f (3 runs) and ed09e16 (2 runs) | yes (pooled; the 3 runs on 293838f are on an earlier text) |
| t5-dead-end | 1.00 | 0.00 | 3 | ed09e16 | yes. Task 7's first batch on 293838f was 0.80 (5 runs) |
| t7-component-reuse | 0.75 | 0.00 | 4 clean | ed09e16 (fix1 runs 1 and 3, fix2 runs 1 and 2) | yes. 2 of 4 timeouts |
| t9-rationale-pressure | 1.00 | 0.00 | 3 | ed09e16 | yes |
| t10-stops-at-g1 | 1.00 | 0.00 | 2 | ed09e16 | yes. On 66af2ea: 1.00/0.00 (5). On ed09e16 fix round 1: 0.83/0.00 (3; no-design-before-g1 2/3) |
| t11-ratchet | 0.80 | 0.50 | 5 | 66af2ea | yes (framing). tier-goes-up 3/5, the same as the 2026-10-07 GREEN. 58e93b6 3-run: 0.83/0.33; that run is before dfd0960 |
| t12-project-rule-wins | 1.00 | 1.00 | 3 | ed09e16 | yes. NO RED, as on 2026-10-07 (0.87 v 1.00) |
| t8-no-model | 1.00 | 0.00 | 3 | 58e93b6 | no, router changed in dfd0960 |
| t8b-partial-model (GUARD) | 1.00 | 1.00 | 5 | dfd0960 | yes (router). Delta 0 |
| smoke | 1.00 | 0.00 | 3 | dfd0960 | no, not re-run after the framing, mapping and reviewing changes |

Notes:
- t16, t16b, t16c, t16e: Task 3 called round 3 the "final text". Its fix round 1 (da614bb) then changed the mode line, the missing-section line and trims. t16d and t18b ran after that. The four cases did not. Earlier (v2) results: t16 0.97/0.18 (3), t16b 1.00/0.28, t16c 1.00/0.25, t16e 1.00/0.33.
- t4: the fail in the 5-run set is the judge on `names-tension`. Compliance ran in one t4 run, not in the first batch. The 2026-10-07 GREEN had 4/5. Assumption: judge variance.
- t5: one 293838f failure cited "Service" and not "Good Services 10". Assumption: judge reading.
- t7: options-named fails in each timed-out run because the reply is cut. The 2026-10-07 GREEN had 3 of 5 timeouts at 570 s.
- t11: In one run the router wrote decisions.md before G1 for an open rule (e-4riUg2). Unverified: whether step 10 caused it. t10 passed 5/5.
- smoke: each with-arm run ends at the 4-turn limit after the skill fires, as designed.
- t12: guard with no RED. The without arm scores 1.00.

## Guard and PASSES-WITH cases

These cases are not RED to GREEN evidence.

- t19b: PASSES-WITH (RED 1.00 with). `terms-drift` and `signal-missing` pass in both arms, because the fixture names `repair_closed` and `tickets.ts`. Unverified: that is the cause.
- t19d: GUARD (without arm 0.86 in RED round 2).
- t19e: PASSES-WITH in RED (0.89 with). It was labelled GUARD in the first ledger line. The without arm scored 0.33 to 0.56, so it does not meet the GUARD test.
- t16d, t8b, t12: GUARD. t8b and t12 have delta 0.
- t17: near-guard (without 0.85). t1 has delta 0.

## Grader changes

Each change has a ruling in the ledger. No grader was changed to move a without-arm score.

- Task 1 harness fixes: reply regexes use `target: last_message` (the loader rejects `source: reply`). Inline `(?i)` is replaced by `flags: i` (evals/README says it throws). The t21 and t21b scaffolds have the bash header and are executable.
- R1: Launch regexes are `Launch:\**\s*(tier\s*)?<n>`, because the template slot is bold.
- R2 (t19): the `interpretation-left` regex asserted nothing, because the scaffold already wrote `Interpretation: UNKNOWN`. It is now two `tool_used` graders (Edit and Write) with `input_match` `PRODUCT\.md[\s\S]*Interpretation:`, max 0.
- R3 and R4 (t19c): the prompt says "This is a Medium change." and "G1 is approved. Continue the design to G2." The scaffold supplies an approved issue.md and journey.md. The router sizes deposit handling Large and stops at G1, so the review lens can only be tested past G1.
- R6 (t20, t21, t21b): `sms-phantom`, and the t21 and t21b path graders measure vocabulary or paths. Each case got a merit llm grader the without arm can pass or fail (`sms-merit`, `reply-merit`).
- Task 1 fix round items 5 to 7 (not R6): t19d `processor-transfer` is case-sensitive. The t19 `interpretation-left` input_match is anchored on the PRODUCT.md path. t20 `numeric-unknown` is now llm.
- R7 (t21): `no-padding` is a reply-only check. A count:0 on an absent file fails by harness, so file-level padding is not graded.
- R10 (t16d): `offers-audit` allows an added missing Terms or Market section, and accepts an audit offer "once code exists". It predates owner decision O3. It still fails a rewrite of existing sections or a reply that does not say the docs exist.
- R11 (t18, t20b): the name-only regex graders `offers-model` and `offers-audit` are deleted. The without arm cannot know the skill names, so they measured the name. GREEN scores on `offers-model-merit`, `offers-audit-merit` and `skill-fired`. The router sentence "Name the skill in each offer." was removed with them.
- R12 (t19): `readings` accepts a stated lean with its argument. It fails a reply that decides for the owner, drops the assertive reading, or designs on one reading before the owner picks. Traces showed the failures came from strict-reading steering, not from the lean.
- R14 (t19): `readings` names the one-total reading ("the fee disclosed in the terms of business, not itemised on each invoice"). The judge read the word "assertive" both ways. The grader is tied to this fixture.
- R16 is not a grader change (see Open risks).

## Untested spec lines

The harness cannot answer questions, and no case sets up these states or grades these lines. Each stays because the spec asks for it.

- `## Market` section content in PRODUCT.md. Replies wrote it with "do nothing". No grader.
- The relationship verb `pays for` in `templates/actors.md`.
- The Engineering, Commercial, Support and ops, PM, Designer and CEO lens rows in `references/lenses.md`. The Engineering permissions and rollout rows and the Commercial upgrade-path and cost-to-serve rows are not written (R9 deferral).
- The Small-work G2 path. Before the final fix wave no text carried this spec line (final review finding 2). The router Small row now puts the readings of each touched rule with no recorded interpretation in the G2 question (R18). No case covers it.
- An open reading carried to the next gate (framing step 10). t19, t21 and t21b stop at G1.
- The designing-interactions step 1 line that builds the chosen or open reading into the flow.
- The tier 1 to 2 discovery-stage rule in mapping-journeys step 5 ("add a stage only when discovery or adoption changes").
- The Marketing lens at launch tier 2 to 3. No review case has a `Launch:` tier.
- Skip-naming: "name each skipped lens" in the lens line. One t4 run on ed09e16 named its skipped lenses. No grader.
- The reviewer-prompt line "When a rule has no recorded interpretation (`Interpretation: UNKNOWN`, or no `Interpretation:` line), report its readings … under UNKNOWN: a question for the owner, not a defect." t5 and t19c use the lettings rules with no Interpretation line, but no grader checks the UNKNOWN readings.
- The Privacy review row. t19c runs show privacy fires (4/5 on 293838f), but no grader checks a Privacy finding.
- The reviewer inputs (Compliance and Privacy read PRODUCT.md Capabilities and Constraints, the Domain rules file, the schema and the processor list). Kept traces show the reads. No grader.
- The router git-log path: "If git log shows a commit on a canonical journey's `Code:` paths after its `audited:` date, offer product-design:auditing-product-models." A t20b pass can come from a file read, and git failed in the sandbox in some runs.
- modelling-products: "Ask who reads the model" and its default of PM and Designer. Replies named the default in t16 and t16d.
- modelling-products: `Interpretation: UNKNOWN` for rules. Seen as owner questions in t16 replies. No t18b grader.
- The interview batch line, `KNOWN` retag and other lines named in the product-model GREEN record are unchanged and stay untested.

## Cases not re-run after the last change to the skill they cover

Built from `git log a8f7dbb..HEAD -- skills/<skill>` and the last run of each case. "Final" means the run used the last text of that skill. Cases are mapped to the skills their prompts and graders exercise. Router cases also load framing-problems.

| Skill | Last change | Case: commit of last run |
|---|---|---|
| modelling-products | da614bb | t16d: da614bb, final for modelling-products. t18b: da614bb, final. t16, t16b, t16c, t16e: b9d9525, NOT final. t16f routes to mapping-journeys and is listed there. |
| auditing-product-models | 1307548 | t17, t17b: 1307548, final. t19b, t19d, t20: 4c2e494, NOT final. t19e: 43dc02a, NOT final. |
| designing-products (router) | 1307548 | t10, t11, t18, t20b, smoke: fdf5d7a, final. t8b: dfd0960, NOT final. t8-no-model: 58e93b6, NOT final. t16d (router regression): 58e93b6, NOT final. t6-trivial: never run this round, NOT final. |
| framing-problems | fdf5d7a | t19, t10, t11, t18, t20b, smoke: fdf5d7a, final. t21, t21b, t1, t3: 66af2ea, NOT final. t6-trivial: never run this round, NOT final. |
| mapping-journeys | a310f27 | t21b: 66af2ea, final for mapping-journeys. t2, t2b (displaced work): never run this round, NOT final. t16f-extend-one-job: never run this round, NOT final. |
| designing-interactions | a310f27 | t5: 1307548, final. t19c: 81b6b75, final. t7, t9, t12: ed09e16, final for designing-interactions. |
| reviewing-product-design | 1307548 | t5: 1307548, final. t19c: 81b6b75, final (reviewer text unchanged after 1307548). t4, t7, t9, t12: ed09e16, NOT final. t14-style review cases are not in this list. |
| references/lenses.md, templates | 1307548 | No case reads them alone. Every final-wave case above read them. t16f reads `templates/journey.md` and was not re-run. |

Skills with no change on this branch (`git log a8f7dbb..HEAD -- skills/<skill>` is empty): filing-issues and sharing-designs (its triage.md handles comments). Their cases t13, t14 to t14d and t15 to t15c need no re-run.

Not re-run after the last change to the skill they cover: t16, t16b, t16c, t16e, t16f, t19b, t19d, t19e, t20, t2, t2b, t6, t8-no-model, t8b, t16d (router), t21, t21b, t1, t3, t4, t7, t9, t12.

## What the new text adds over the base model

All points come from the without-arm failures above.

- Terms with code names, `Signal:` lines with real events, and a `## Market` section in the product model (t18b, without 0/5 on four graders).
- Readings of a rule as one owner question, no verdict, no interpretation written for the owner (t19 readings 4/5 v 0/5 on the final text, fdf5d7a; 5/5 on 2dc83e2).
- Correction (final review finding 5): the earlier claim here, "a `Compliance` lens named in the `Reviewed:` line (t19c: 8 of 10 v 0 of 10)", is vocabulary, not added value: the grader matches the skill's lens name in the skill's file. See the Final fix wave for the `decisions-merit` result.
- An UNKNOWN for a numeric claim with no proof, and an SMS phantom found (t20; sms-phantom 3/3 v 0/3 in RED).
- A tier line and one answer per tier question in `issue.md ## Launch`, and the customer's start path at tier 3 (t21, t21b: adoption, launch-tier-0, launch-tier-3, start-path all 0/5 or 0/3 without).
- An offer of the product model when actors.md is missing (t18 1.00 v 0.00).
- An offer of an audit when the docs point to code that changed (t20b). Correction (final review finding 6): on dfd0960 the merit grader showed no measured lift (3/5 v 2/3 in RED); see the Final fix wave for the later runs. git failed in the sandbox, so the git-log path itself has no proof.

## Open risks

- Large-path review timeouts (R16). The Large path runs 3 options, 5 lenses and a full re-review. t19c took 590 to 602 s, and 4 of 5 runs hit the 600 s timeout. t7 timed out in 2 of 4 clean runs on this round and 3 of 5 on 2026-10-07. The re-review re-runs every lens, although `synthesis.md` step 7 says to re-run only the lenses whose findings changed. That file is outside this plan. Follow-up: re-review only the lenses whose findings changed, per synthesis.md step 7. Until then, owners wait longer on Large reviews.
- t18b `signals` is 7/8 on the final text. One miss has no recorded cause; the trace was not kept. Unverified: cause.
- t20b scores 0.80, exactly at the bar. 2 of 5 runs failed because git did not run in the sandbox. The router git-log path has no clean proof.
- t19c compliance-lens passes 3/5 on ed09e16 only because of timeouts, not wrong lens names. The other two runs wrote no Reviewed line before the cut.
- Compliance fires on every lettings review case (t4, t7, t12, t19c), because the lettings work touches the £250 and 24-hour rules. It takes one by-risk slot under R15.
- t19 `readings` depends on a grader tied to one fixture (R14). The eval judge failed replies that a local re-judge passed (R12 round). If the grader text changes, re-run t19.
- Correction (final review finding 16): Task 6 trims left framing-problems at 500 of 500 words, not 499. auditing-product-models was also at 500 and modelling-products at 499. After the final fix wave: framing-problems 499, auditing-product-models 500, modelling-products 499, designing-products 399. Any later addition needs a trim.
- Deferred minors from the reviews: t19b `signal-missing` and `terms-drift` match a mere quote; t18b `no-journey` misses Bash writes; t19e `no-lawful-basis` has no existence check; `scaffold.sh` fix chmod'ed 30 other scaffolds to 755.

## Final fix wave (2026-10-12)

Fixes for the final whole-branch review, findings 1–14 and 16 (rulings R17, R18). Text commits: 1307548 (all fixes), 81b6b75 (framing: no decisions.md before G1; t19c rubric), fdf5d7a (framing: the strongest-case clause kept in the reply). Same command as above, `--keep-temp`, sonnet judge, both arms in one run. JSON in `evals/results/lenses-final{,2,3}-<case>.json`.

| Case | With | Without | Runs | Behaviour graders (with v without) | Text |
|---|---|---|---|---|---|
| t19-ambiguous-rule | 0.97 | 0.67 | 5 | readings 4/5 v 0/5 | fdf5d7a |
| t10-stops-at-g1 | 1.00 | 0.00 | 3 | no-design-before-g1 3/3 v 0/3 | fdf5d7a |
| t11-ratchet | 1.00 | 0.50 | 3 | tier-goes-up 3/3 v 3/3; tier-raise-line 3/3 v 0/3 | fdf5d7a |
| t18-actors-missing | 1.00 | 0.00 | 3 | offers-model-merit 3/3 v 0/3 | fdf5d7a |
| t20b-stale-offer | 1.00 | 0.00 | 3 | offers-audit-merit 3/3 v 0/3 | fdf5d7a |
| smoke | 1.00 | 0.00 | 3 | skill-fired 3/3 v 0/3 | fdf5d7a |
| t19c-no-signoff | 1.00 | 0.20 | 3 | decisions-merit 3/3 v 0/3 (file absent); compliance-lens 3/3 v 0/3 | 81b6b75 |
| t5-dead-end | 1.00 | 0.00 | 3 | dead-end 3/3 v 0/3 | 1307548 |
| t17-audit-report (near-guard) | 1.00 | 0.85 | 3 | severity-set 3/3 v 0/3 | 1307548 |
| t17b-audit-rulings | 1.00 | 0.69 | 3 | audited-line 3/3 v 0/3; close-unknown 3/3 v 0/3 | 1307548 |

Earlier batches in this wave:
- On 1307548: t19 1.00/0.67 (readings 5/5 v 0/5, 5 runs). t10 0.83/0.00: one run wrote decisions.md before G1 to point at the open lettings rules. This is final review finding 17. The wider readings key (finding 1) made it fire on the lettings fixture, so 81b6b75 adds "Write no decisions.md before G1." t11 1.00/0.50. t18 1.00/0.00. smoke 1.00/0.00. t20b 0.67/0.00 (offers-audit-merit 1/3: two replies offered the audit but did not say the code changed). t19c 0.87/0.20 (decisions-merit 1/3 with the first rubric; both failing files held compliance findings with rulings, and the judge flagged each as a long file of 11–12k characters).
- On 81b6b75: t10 1.00/0.00 (5 runs, no-design-before-g1 5/5). t19 0.93/0.67 (readings 3/5; one failing reply argued the one-total reading down), so fdf5d7a puts "Give each reading its strongest case, the assertive one too." back in the framing reply. t11 0.83/0.50 (tier-goes-up 2/3, judge). t18, t20b, smoke 1.00/0.00. t19c 1.00/0.20 (decisions-merit 3/3 with the sharper rubric).

Notes:
- t19c: `decisions-merit` judges compliance findings about the deposit rules, with a fix, a ruling or the case for the design, and no wait on approval from anyone but the owner. The without arm wrote no decisions.md in 3/3 runs, so it fails `decisions-merit` and `no-gate-files` by file absence, not on merit. `no-gate` is a GUARD (3/3 v 3/3). All 3 with-arm runs hit the 600 s timeout after decisions.md was written (R16). t19c shows that the review behaviour holds; it is not RED-to-GREEN evidence of lift on merit.
- t20b: git failed in the sandbox in all runs of this wave (`xcode-select: Failed to locate 'git'`). Runs read `.git/logs/HEAD` or the files. The merit grader passed 6/6 on 81b6b75 and fdf5d7a, and 1/3 on 1307548. Pooled over the wave: 7/9 with v 0/9 without. The router git-log path still has no direct proof.
- t17: in all 3 runs, an audit with no rulings set `audited:` on the journey it checked (trace greps: `audited: 2026-10-12`). This is final review finding 4 and the Task 4 deferred minor.
- t5 uses the lettings fixture, which has no Interpretation line. It passes 3/3, so the wider readings key did not break the dead-end review.

Open from the final review (R17): finding 17 is now partly answered by "Write no decisions.md before G1" (t10 8/8 on 81b6b75 and fdf5d7a). Finding 18: t7 is at 0.75 and was not re-run. Finding 19: no case checks that a Medium review still catches usability findings when Compliance or Privacy takes the by-risk slot. Finding 15: only the issue.md `**Phases:**` and `**Launch:**` labels changed. modelling-products still says "recommend one tier" for the model depth.
