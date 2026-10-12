# GREEN record: lenses, compliance and model depth (2026-10-11)

Compare with `2026-10-11-lenses-red.md`. Sonnet judge, with and without arms in one run, threshold 0.8. Command: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --judge-model sonnet --case <case> --runs N -j 6 --json <file>`. Counts come from the task reports and the ledger in `.superpowers/sdd/2026-10-11-lenses-and-model-depth/`. The result JSON files in `evals/results/` are not in git. Where two sources disagree, this record uses the later one and says so.

Last text commit per skill:
- `references/lenses.md`: 6e7d474.
- modelling-products: da614bb.
- auditing-product-models: 4c2e494.
- router (designing-products): dfd0960.
- framing-problems, mapping-journeys, designing-interactions: 66af2ea (2dc83e2 changed a grader only).
- reviewing-product-design: ed09e16.

## Scores: new cases

| Case | With | Without | Runs | Failing graders (with arm) | Text the run used | On final text? |
|---|---|---|---|---|---|---|
| t18-actors-missing | 1.00 | 0.00 | 5 | none (skill-fired 5/5, offers-model-merit 5/5) | dfd0960 | yes (router) |
| t18b-terms-signals | 1.00 | 0.17 | 5 | none (signals 5/5) | da614bb | yes |
| t19-ambiguous-rule | 1.00 | 0.63 | 5 | none (readings 5/5 v 0/5) | 66af2ea, grader at 2dc83e2 | yes |
| t19b-audit-position (PASSES-WITH) | 1.00 | 0.78 | 3 | none | 4c2e494 | yes |
| t19c-no-signoff | 0.90 | 0.25 | 5 | compliance-lens 3/5 (2 timeouts before the Reviewed line) | ed09e16 | yes |
| t19d-privacy-gdpr (GUARD) | 1.00 | 0.74 | 5 | none | 4c2e494 | yes |
| t19e-privacy-ccpa (GUARD) | 0.87 | 0.40 | 5 | ccpa-terms 1, no-lawful-basis 1 | 43dc02a | no |
| t20-claims | 0.97 | 0.63 | 5 | valid-not-flagged 1 | 4c2e494 | yes |
| t20b-stale-offer | 0.80 | 0.00 | 5 | offers-audit-merit 3/5 | dfd0960 | yes (router) |
| t21-internal-tool | 1.00 | 0.20 | 3 | none | 66af2ea | yes |
| t21b-big-launch | 1.00 | 0.00 | 3 | none | 66af2ea | yes |

RED for comparison: t18 0.56/0.00, t18b 0.33/0.17, t19 0.83/0.67, t19b 1.00/0.72, t19c 0.75/0.25, t19d 0.90/0.86, t19e 0.89/0.33, t20 0.83/0.61, t20b 0.56/0.11, t21 0.40/0.27, t21b 0.40/0.00 (round 2 where the RED record has one).

Notes per case:
- t19: the 5/5 run before the grader change (a310f27 text, old grader) scored 1.00/0.67. After the lean text (66af2ea) the old-grader score fell to 0.90/0.67 (readings 2/5). A local re-judge passed the 4 failing replies. R14 named the reading in the grader. The R14 run is the number in the table. Without arm: readings 0/5.
- t19c: 4 of 5 with-arm runs hit the 600 s timeout. The files and the Reviewed line were on disk in the 3 runs that reached the write. On ed09e16 alone: 0.90/0.25. The earlier batch on 293838f scored 1.00/0.25 (5 runs; 4/5 timeouts). The earlier fix-round batch lost its timing to a session limit, and its 5 runs scored 1.00/0.25. In all 10 with-arm runs on the two reviewing texts, 8 wrote a Reviewed line that names compliance. Without arm 0/10. The without arm also fails `no-gate-files` by file absence.
- t19d: GUARD. The without arm scored 0.86 in RED round 2 and 0.71 to 0.77 in GREEN.
- t19e: not re-run after the auditing-product-models fix round (4c2e494). The 0.87/0.40 run is from 43dc02a. An earlier 3-run result on the first text was 0.78/0.56. The with arm lost skill-fired once on t19d (0.90/0.71, 3 runs, 43dc02a) and once on t19e. Unverified: the cause is description noise.
- t20: sms-phantom separates the arms (RED 3/3 v 0/3). The 3-run result on 43dc02a was 1.00/0.61. t20 `numeric-unknown` and `sms-merit` do not separate arms (judge noise).
- t20b: exactly at the 0.80 bar. Both failing runs said git did not run in the sandbox ("xcode-select error"). They found the drift by reading the files, and the judge failed them because the reply did not say the code changed after the last check. See Open risks.
- t21: round 6 on a310f27 scored 1.00/0.24 (5 runs). The 66af2ea number is 3 runs.
- t21b: round 6 on a310f27 scored 0.96/0.00 (5 runs; start-path 4/5). The 66af2ea number is 3 runs. The later source wins.
- t18b: pooled `signals` on the final text is 7/8 (fix round 1: 2/3; fix round 2: 5/5). See Open risks.

## Scores: existing cases re-run this round

| Case | With | Without | Runs | Text the run used | On final text of the skill it covers? |
|---|---|---|---|---|---|
| t16-model-from-code | 1.00 | 0.18 | 5 | b9d9525 (v3) | no, modelling-products changed in da614bb |
| t16b-model-from-interview | 1.00 | 0.28 | 3 | b9d9525 (v3) | no |
| t16c-model-partial | 1.00 | 0.25 | 3 | b9d9525 (v3) | no |
| t16d-model-exists (GUARD) | 1.00 | 0.80 | 5 | 1a3db20 (grader R10; skill da614bb) | yes. A later 3-run result on dfd0960 was 1.00/0.78 |
| t16e-depth-not-given | 1.00 | 0.33 | 3 | b9d9525 (v3) | no |
| t17-audit-report (near-guard) | 1.00 | 0.85 | 3 | 4c2e494 | yes |
| t17b-audit-rulings | 1.00 | 0.69 | 5 | 4c2e494 | yes |
| t1-repeat-action | 0.83 | 0.83 | 3 | 66af2ea | yes. Delta 0 |
| t3-no-evidence | 1.00 | 0.25 | 3 | 66af2ea | yes |
| t4-novice-vs-expert | 0.80 | 0.00 | 5 | 293838f (3 runs) and ed09e16 (2 runs) | yes (pooled) |
| t5-dead-end | 1.00 | 0.00 | 3 | ed09e16 | yes. Task 7's first batch on 293838f was 0.80 (5 runs) |
| t7-component-reuse | 0.75 | 0.00 | 4 clean | 293838f (2) and ed09e16 (2) | yes (pooled). 2 of 4 timeouts |
| t9-rationale-pressure | 1.00 | 0.00 | 3 | ed09e16 | yes |
| t10-stops-at-g1 | 1.00 | 0.00 | 2 | ed09e16 | yes. On 66af2ea: 1.00/0.00 (5). On ed09e16 fix round 1: 0.83/0.00 (3; no-design-before-g1 2/3) |
| t11-ratchet | 0.80 | 0.50 | 5 | 66af2ea | yes (framing). tier-goes-up 3/5, the same as the 2026-10-07 GREEN. dfd0960 3-run: 0.83/0.33 |
| t12-project-rule-wins | 1.00 | 1.00 | 3 | ed09e16 | yes. NO RED, as on 2026-10-07 (0.87 v 1.00) |
| t8-no-model | 1.00 | 0.00 | 3 | dfd0960 | yes (router) |
| t8b-partial-model (GUARD) | 1.00 | 1.00 | 5 | dfd0960 | yes (router). Delta 0 |
| smoke | 1.00 | 0.00 | 3 | dfd0960 | no, not re-run after the framing, mapping and reviewing changes |

Notes:
- t16, t16b, t16c, t16e: Task 3 called round 3 the "final text". Its fix round 1 (da614bb) then changed the mode line, the missing-section line and trims. t16d and t18b ran after that. The four cases did not. Earlier (v2) results: t16 0.97/0.18 (3), t16b 1.00/0.28, t16c 1.00/0.25, t16e 1.00/0.33.
- t4: the fail in the 5-run set is the judge on `names-tension`. No compliance lens ran in t4. The 2026-10-07 GREEN had 4/5. Assumption: judge variance.
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
- R6 (t20, t21, t21b): `sms-phantom`, and the t21 and t21b path graders measure vocabulary or paths. Each case got a merit llm grader the without arm can pass or fail (`sms-merit`, `reply-merit`). t20 `numeric-unknown` is now llm. t19d `processor-transfer` is case-sensitive. t19 `interpretation-left` is anchored on the PRODUCT.md path.
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
- The Small-work G2 path ("framing raises any open interpretation in the G2 question"). No case covers it.
- An open reading carried to the next gate (framing step 10). t19, t21 and t21b stop at G1.
- The designing-interactions step 1 line that builds the chosen or open reading into the flow.
- The tier 1 to 2 discovery-stage rule in mapping-journeys step 5 ("add a stage only when discovery or adoption changes").
- The Marketing lens at launch tier 2 to 3. No review case has a `Launch:` tier.
- Skip-naming: "name each skipped lens" in the lens line. One t4 run on ed09e16 named its skipped lenses. No grader.
- The reviewer-prompt line "When the rule has `Interpretation: UNKNOWN`, give its open readings as an UNKNOWN finding."
- The Privacy review row. t19c runs show privacy fires (4/5 on 293838f), but no grader checks a Privacy finding.
- The reviewer inputs (Compliance and Privacy read PRODUCT.md Capabilities and Constraints, the Domain rules file, the schema and the processor list). Kept traces show the reads. No grader.
- The router git-log path: "If git log shows a commit on a canonical journey's `Code:` paths after its `audited:` date, offer product-design:auditing-product-models." A t20b pass can come from a file read, and git failed in the sandbox in some runs.
- modelling-products: "Ask who reads the model" and its default of PM and Designer. Replies named the default in t16 and t16d.
- modelling-products: `Interpretation: UNKNOWN` for rules. Seen as owner questions in t16 replies. No t18b grader.
- The interview batch line, `KNOWN` retag and other lines named in the product-model GREEN record are unchanged and stay untested.

## Cases not re-run after the last change to the skill they cover

- t16f-extend-one-job: routes to mapping-journeys. Not re-run after the mapping-journeys change (66af2ea) or the `templates/journey.md` change. No run this round.
- t19e-privacy-ccpa: last run on 43dc02a. auditing-product-models changed in 4c2e494 (the lens path moved into parentheses; check 4, 5, 6, 8 wording and the Open unknowns line).
- t16, t16b, t16c, t16e: last run on b9d9525. modelling-products changed in da614bb.
- t2, t2b, t8 (mapping-journeys): mapping-journeys gained step 5 text in a310f27. Not re-run.
- smoke: last run on dfd0960. The framing, mapping and reviewing skills changed after it.
- t6, t13, t14 to t14d, t15 to t15c: cases for other skills or the review path. Task 7 lists them as not re-run after ed09e16. I did not check their skill coverage again.
- t17 and t17b ran on 4c2e494, with 3 and 5 runs. t19b ran 3 runs.
- Every case outside t4, t5, t7, t9, t10, t12 and t19c is not re-run on ed09e16 (reviewing-product-design).

## What the new text adds over the base model

All points come from the without-arm failures above.

- Terms with code names, `Signal:` lines with real events, and a `## Market` section in the product model (t18b, without 0/5 on four graders).
- Readings of a rule as one owner question, no verdict, no interpretation written for the owner (t19 readings 5/5 v 0/5).
- A `Compliance` lens named in the `Reviewed:` line when the work touches a recorded rule (t19c: 8 of 10 v 0 of 10).
- An UNKNOWN for a numeric claim with no proof, and an SMS phantom found (t20; sms-phantom 3/3 v 0/3 in RED).
- A tier line and one answer per tier question in `issue.md ## Launch`, and the customer's start path at tier 3 (t21, t21b: adoption, launch-tier-0, launch-tier-3, start-path all 0/5 or 0/3 without).
- An offer of the product model when actors.md is missing (t18 1.00 v 0.00).
- An offer of an audit when the git log shows code newer than the `audited:` date (t20b 0.80 v 0.00, but see Open risks).

## Open risks

- Large-path review timeouts (R16). The Large path runs 3 options, 5 lenses and a full re-review. t19c took 590 to 602 s, and 4 of 5 runs hit the 600 s timeout. t7 timed out in 2 of 4 clean runs on this round and 3 of 5 on 2026-10-07. The re-review re-runs every lens, although `synthesis.md` step 7 says to re-run only the lenses whose findings changed. That file is outside this plan. Follow-up: re-review only the lenses whose findings changed, per synthesis.md step 7. Until then, owners wait longer on Large reviews.
- t18b `signals` is 7/8 on the final text. One miss has no recorded cause; the trace was not kept. Unverified: cause.
- t20b scores 0.80, exactly at the bar. 2 of 5 runs failed because git did not run in the sandbox. The router git-log path has no clean proof.
- t19c compliance-lens passes 3/5 on ed09e16 only because of timeouts, not wrong lens names. The other two runs wrote no Reviewed line before the cut.
- Compliance fires on every lettings review case (t4, t7, t12, t19c), because the lettings work touches the £250 and 24-hour rules. It takes one by-risk slot under R15.
- t19 `readings` depends on a grader tied to one fixture (R14). The eval judge failed replies that a local re-judge passed (R12 round). If the grader text changes, re-run t19.
- Task 6 trims left framing-problems at 499 of 500 words and modelling-products at 499 of 500. Any later addition needs a trim.
- Deferred minors from the reviews: t19b `signal-missing` and `terms-drift` match a mere quote; t18b `no-journey` misses Bash writes; t19e `no-lawful-basis` has no existence check; `scaffold.sh` fix chmod'ed 30 other scaffolds to 755.
