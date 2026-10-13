# GREEN record: writing-ui-copy (cases t22 to t22k)

Date: 2026-10-13. Claude Code 2.1.287. Judge: sonnet. 5 runs per arm. The wave tables below exclude t22i (see Design handoff); the Opus and Haiku sections at the end finish this record.

Command per behavioural case: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --model claude-sonnet-5-5 --judge-model sonnet --case <case> --runs 5 -j 6 --keep-temp --json evals/results/<wave>/<case>-green.json`. t22g runs the same command without `--scaffold --allow-tools Bash Write Edit`.

Text the numbers came from: `skills/writing-ui-copy/SKILL.md` blob `d67f3ae280b19d5222250bc66e73d8cf55b72539`. It was committed in "fix: writing-ui-copy review round 1", the commit that updates this record. Every case below ran on that exact text (wave 8; t22g re-run in wave 9 on the same text after its grader change), so no case is stale.

## Scores (wave 8, final text)

| Case | With | Without | Runs | Failing graders, with arm | Per grader, with / without (of 5) | Status |
|---|---|---|---|---|---|---|
| t22-validation | 1.00 | 0.33 | 5 | none | errors-actionable 5/0; no-generic-errors 5/5; skill-fired 5/0 | GREEN |
| t22b-empty-state | 1.00 | 0.75 | 5 | none | empty-state 5/5; no-badge 5/5; no-restated-heading 5/5; skill-fired 5/0 | GREEN (selection only; the merit graders are no-regression guards) |
| t22c-cancel | 1.00 | 0.67 | 5 | none | confirm-copy 5/5; no-bare-buttons 5/5; skill-fired 5/0 | GREEN (selection only) |
| t22d-pill-creep | 1.00 | 0.75 | 5 | none | no-badge 5/5; no-explainer 5/5; no-provenance 5/5; skill-fired 5/0 | GREEN (selection only) |
| t22e-bugfix | 1.00 | 0.67 | 5 | none | no-generic-errors 5/5; skill-fired 5/0; upload-error 5/5 | GREEN (selection only) |
| t22f-guard-rename | 1.00 | 1.00 | 5 | none | renamed 5/5; renamed-api 5/5; skill-not-fired 5/5 | GUARD holds |
| t22g-compliance | 1.00 | 0.67 | 5 | none | buttons 5/5; empty-and-confirm 5/0; error-shape 5/5 | GREEN (wave 9, after no-extra-elements was deleted; same skill text) |
| t22h-project-rule | 1.00 | 0.00 | 5 | none | project-term 5/0; skill-fired 5/0 | GREEN |
| t22j-plain-prompt | 1.00 | 0.00 | 5 | none | sending-label 5/0; skill-fired 5/0 | GREEN (new during GREEN, see New cases) |
| t22k-guard-styling | 1.00 | 1.00 | 5 | none | skill-not-fired 5/5 | GUARD holds (new during GREEN) |

Skill load, from the traces: `writing-ui-copy` fired in 40 of 40 with-arm runs across the 8 build cases (t22, t22b, t22c, t22d, t22e, t22h, t22j and t22g). It fired in 0 of 10 with-arm runs of the two GUARD cases. The t22g count was checked in the traces with `grep '"skill"\s*:\s*"product-design:writing-ui-copy"'`, since t22g has no skill-fired grader. t22g loaded the skill in 5 of 5 with-arm runs in every wave (1 to 8), and in wave 9 (checked in the kept wave-9 traces: 5 of 5, each returning "Launching skill", not "Unknown skill"). Its without arm also calls `writing-ui-copy`, which returns "Unknown skill".

## New cases added during GREEN

Both were written after the skill existed. They have no RED run, and their without arm serves as the baseline.
- `t22j-plain-prompt`: a selection-robustness case. Its prompt has no owner block about design documents. It asks for a disabled submit button that shows it is sending. Without the skill (wave 6 to 8), the label is "Sending…" in 15 of 15 runs, and the skill never fires (sending-label 0/15).
- `t22k-guard-styling`: an over-trigger GUARD. The task is alternating row backgrounds and a right-aligned column. The skill did not fire in any run in waves 6 to 8 (0/15 with arm).

## Waves

With / without per wave. Blob = SKILL.md blob prefix.

| Wave | Blob | t22 | t22b | t22c | t22d | t22e | t22f | t22g | t22h | t22j | t22k |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 (brief text) | a73ab30 | 0.67 / 0.33 | 1.00 / 0.75 | 0.73 / 0.67 | 0.45 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.60 / 0.55 | 0.50 / 0.00 | n/a | n/a |
| 2 | c879e87 | 0.80 / 0.33 | 1.00 / 0.70 | 0.67 / 0.67 | 0.25 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.85 / 0.45 | 0.60 / 0.10 | n/a | n/a |
| 3 | f36305a | 0.73 / 0.33 | 1.00 / 0.75 | 0.73 / 0.67 | 0.45 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.85 / 0.55 | 0.50 / 0.00 | n/a | n/a |
| 4 | 79b4696 | 0.93 / 0.33 | not run | 0.73 / 0.67 | 1.00 / 0.75 | not run | 1.00 / 1.00 | not run | 0.80 / 0.00 | n/a | n/a |
| 5 | f751b63 | 1.00 / 0.33 | 1.00 / 0.70 | 1.00 / 0.67 | 1.00 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.75 / 0.55 | 1.00 / 0.00 | n/a | n/a |
| 6 (review round 1) | b14b104 | 0.93 / 0.33 | 1.00 / 0.75 | 1.00 / 0.67 | 0.55 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.75 / 0.55 | 0.70 / 0.00 | 0.70 / 0.00 | 1.00 / 1.00 |
| 7 | 50953c6 | 1.00 / 0.33 | 1.00 / 0.75 | 1.00 / 0.67 | 1.00 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.85 / 0.70 | 0.60 / 0.00 | 1.00 / 0.00 | 1.00 / 1.00 |
| 8 | d67f3ae | 1.00 / 0.33 | 1.00 / 0.75 | 1.00 / 0.67 | 1.00 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.75 / 0.65 | 1.00 / 0.00 | 1.00 / 0.00 | 1.00 / 1.00 |
| 9 (t22g only, grader deleted) | d67f3ae | not run | not run | not run | not run | not run | not run | 1.00 / 0.67 | not run | not run | not run |

The t22g scores in waves 6 to 8 use the changed `no-extra-elements` grader. Wave 9 has no `no-extra-elements` grader (see Grader changes).

Skill fired in the with arm (of 5), waves 1 to 8:

| Case | W1 | W2 | W3 | W4 | W5 | W6 | W7 | W8 |
|---|---|---|---|---|---|---|---|---|
| t22 | 0 | 2 | 1 | 4 | 5 | 4 | 5 | 5 |
| t22c | 1 | 0 | 1 | 1 | 5 | 5 | 5 | 5 |
| t22d | 0 | 0 | 0 | 5 | 5 | 2 | 5 | 5 |
| t22h | 4 | 4 | 2 | 5 | 5 | 5 | 5 | 5 |
| t22j | n/a | n/a | n/a | n/a | n/a | 4 | 5 | 5 |

t22b and t22e fired 5 of 5 in every wave they ran.

## Rules pruned (Step 2)

None. Each harness-tested rule had at least one failing grader in a RED run:
- Rule 2: no-explainer (t22d Sonnet with arm, 1 of 3) and no-extra-elements (t22g, every model and arm; that grader was deleted during GREEN, see Grader changes). Rule 2 stays covered by t22b (no-restated-heading, no-badge) and t22d (no-badge, no-explainer).
- Rule 3: no-provenance (t22d Sonnet with arm, 1 of 3).
- Rule 5: buttons (t22g; see rule 8).
- Rule 6: errors-actionable (t22, failing in 5 of 6 runs).
- Rule 7: empty-and-confirm part 1, the no-updates message (t22g, failing in 12 of 12).
- Rule 8: t22g `buttons` RED failures. The Sonnet first run passed 2 of 3 in the with arm (`evals/results/first/t22g-compliance-red.json`). In Haiku round 2, 3 runs failed: 1 with, 2 without (`evals/results/t22g-haiku-red.json`). Rule 8's "specific thing (its name or title, not just its type)" clause answers a failure recorded during GREEN, not RED. In wave 1, with the skill loaded, t22g `empty-and-confirm` failed 5 of 5 on "Withdraw this repair?" (see wave 2 below). `confirm-copy` (t22c) did not fail in any wave-1 with-arm run.

## Skill text changes and the failure each answered

- Wave 2, rule 8: "name the thing" became "name the specific thing (its name or title, not just its type)". Failure: t22g empty-and-confirm failed 5 of 5 with the skill loaded on "Withdraw this repair? You can't undo this." A harness probe with a canned reply (2 runs) showed the judge fails "Withdraw this repair?" 6 of 6 votes and passes "Withdraw your {category} repair?" 6 of 6. Wave 7 changed the example from "Delete invoice INV-042?" to "Delete invoice {number}?". Failure: 2 of 5 wave-6 t22g replies wrote "Withdraw this repair?" and added a note that the real title belonged there, because the prompt gives no title. The placeholder example shows what to write when the name is not known.
- Before writing, the project-term line:
  - Wave 2 said to use the term, not avoid the banned word. Failure: t22h with-arm runs read docs/copy-examples.md, then wrote "Visit tomorrow: ${category}" and "What: ${category}", never "job" (4 of 5).
  - Wave 3 added the example "Rule 'say order, never purchase': …".
  - Wave 8 made it "every string that refers to that thing uses it. Avoiding the banned word, or naming the thing some other way, does not follow the rule", and added "or 'Your parcel shipped'" to the example. Failure: project-term failed 3 of 5 (wave 6) and 4 of 5 (wave 7) with the skill loaded and the rule file read. The runs still named the work only as a "visit". Result: 5 of 5.
- Wave 5, Before writing: "instructions file (CLAUDE.md or equivalent)" became "instructions files (CLAUDE.md or any equivalent at the repo root)". Wave 6 (review) changed it to "any agent-instructions file at the repo root". Failure: one wave-4 t22h run loaded the skill, globbed only for CLAUDE.md, and missed the project's rule.
- Description and the "Load this before…" line, waves 2 to 7. Failure: skill-fired was 0 of 5 for t22 and t22d, and 1 of 5 for t22c, in wave 1. The traces go Read, then Write/Edit, with no Skill call.
  - Wave 2 listed form errors, dialogs, table headers and placeholders, plus "side effect of building a feature or fixing a bug". No clear gain.
  - Wave 3 keyed the description to "building or changing anything a person sees". No clear gain.
  - Wave 4 opened with "Use when writing code that shows anything to a person" and added "including plain build or bug-fix work with no design step".
  - Wave 5 added "and even when the wording seems obvious". All build cases fired 5 of 5.
  - Wave 6 (review): the controller judged "with no design step" to be tuned to the case prompts and replaced it with "including build and bug-fix work, not only copy or design tasks". t22d dropped to 2 of 5 and t22j fired 4 of 5.
  - Wave 7 changed "labels, buttons" to "labels, headers, buttons" and added "Load it before the first such edit." All 8 build cases fired 5 of 5 in waves 7 and 8.
- Wave 7, rule 5: "verb + object" now covers "a button's in-progress label", with the example "Sending…" → "Sending invoice…". Failure: 2 of 4 wave-6 t22j runs loaded the skill and still wrote "Sending…". Result: sending-label 5 of 5 in waves 7 and 8.
- Wave 6 (review): the project-term example moved to its own indented line.

## Grader changes

- Wave 6, `t22g-compliance/graders/no-extra-elements.md`: the body now starts "Judge only the `element: string` list; ignore any text before or after it." This is a controller ruling under Step 6(c). The reason is the canned-reply probe evidence from wave 5. The wave-5 with-arm reply's list lines alone passed 6 of 6 votes. The same reply with its one-line preface ("The project has no copy rules, so these follow the skill's defaults…") failed 6 of 6. The list gave strings for the seven elements plus the confirmation's two buttons, which meets the spec. Other evidence of instability:
  - Changing only the heading to "Repair details" failed 6 of 6, and changing only the status to "In progress" failed 4 of 6.
  - Telling the grader that placeholders and notes are not elements changed nothing (12 of 12 FAIL).
  - A local re-judge with the same prompt (`claude -p`, sonnet 5.5 and 4.6) passed the replies the harness failed.
- Fix round 2, `t22g-compliance/graders/no-extra-elements.md` deleted (controller ruling). Reason: across waves 6 to 8 the judge failed lists holding exactly the seven elements plus the two confirmation buttons, so the grader measured judge noise, not the skill. Rule 2 stays covered by t22b (no-restated-heading, no-badge) and t22d (no-badge, no-explainer). Re-run (wave 9, same skill text d67f3ae): with 1.00, without 0.67.
- No other case or grader was changed. The temporary `zz-probe-*` cases used for the judge probes were deleted after each probe.

## Resolved: t22g no-extra-elements

The grader was deleted in fix round 2 (see Grader changes). Before that, with the list-scoped grader, no-extra-elements passed 2 of 5 (wave 6), 2 of 5 (wave 7) and 0 of 5 (wave 8). Every one of those with-arm lists gave strings for the seven elements plus at most the confirmation's two buttons. This wave-8 list failed 3 of 3 votes:

```
- Page heading: {title}
- Repair status: Awaiting contractor
- Withdraw button: Withdraw repair
- Withdraw confirmation: Withdraw "{title}"? You can't undo this.
- Withdraw confirm button: Withdraw repair
- Withdraw dismiss button: Keep repair
- Add photo button: Add photo
- Photo upload error (file over 10MB): Photo is over 10MB. Choose a smaller photo.
- No updates message: No updates yet
```

The harness records only the votes, so it is Unverified which line the judge counted as extra. t22g no longer has a grader that checks scope.

## Untested lines

- Rule 1 (name the thing, give the action, stop), rule 4 (no hedging or disclaimers) and rule 9 (conventions): no grader tests them alone.
- The "After writing" self-check: no grader isolates it.
- Icon-only buttons and links get an accessible name (rule 5, second sentence): no case has an icon-only control.

## Design handoff (Task 3)

t22i-design-handoff (single `skill-fired` grader for writing-ui-copy), Sonnet 5.5, 5 runs, with-without.

| Text of designing-interactions step 3 | With | Without | Cost |
|---|---|---|---|
| unchanged | 0.40 (2 of 5 fired) | 0 | $4.56 |
| plus a separate line "Write every string in a mock with `writing-ui-copy`." | 0.40 (2 of 5 fired) | 0 | $4.74 |
| "Load `writing-ui-copy` first, then build each option as a mock ..." (kept) | 1.00 (5 of 5) | 0 | not recorded |

Trace finding (controller, attempt 2): designing-interactions loaded in 5 of 5 runs and the mocks were written by Bash heredocs in its step 3. The router was not the cause. The separate line came too late to be followed; the instruction placed first in step 3 is.

Cost (result JSON `costUsd`): kept t22i run $4.77; the two earlier t22i runs $4.56 and $4.74.

Regression list. The brief's grep, `grep -l "designing-interactions\|mocks/\|mock" evals/cases/*/graders/*.md | cut -d/ -f3 | sort -u`, returned:

```
t10-stops-at-g1
t12-project-rule-wins
t14d-mock-privacy
t7-component-reuse
```

A wider grep of graders and prompts for `designing-interactions|design.md|decisions.md` added t15-comment-triage, t15b-mixed-comment, t15c-already-triaged, t19c-no-signoff, t19f-reading-in-design and t9-rationale-pressure. t19f and t19c have design-step graders (decisions-points-to-row, decisions-merit) in the sweep. All ten were re-run with the kept text (Sonnet 5.5, 3 runs each; the four cases from the brief's grep ran both arms, the six cases added by the wider grep ran the with arm only). Sweep row = `2026-10-12-sonnet-sweep.md` (ade3a79 row where one exists).

| Case | Sweep | 3 runs | Failing graders (per run) | 5-run re-run | Cost |
|---|---|---|---|---|---|
| t10-stops-at-g1 | 1.00 | 1.00 | none | | $1.03 |
| t12-project-rule-wins | 1.00 | 1.00 | none | | $2.49 |
| t14d-mock-privacy | 1.00 | 1.00 | none | | $0.62 |
| t7-component-reuse | 0.93 | 0.78 | options-named in 2 of 3 runs | 1.00 | $2.21 + $3.55 |
| t15-comment-triage | 1.00 | 0.92 | no-gate-approved / revision-bumped / none | | $0.62 |
| t15b-mixed-comment | 1.00 | 1.00 | none | | $0.64 |
| t15c-already-triaged | 0.96 | 1.00 | none | | $0.46 |
| t19c-no-signoff | 0.93 | 0.80 | compliance-lens, compliance-lens, decisions-merit | 1.00 | $2.59 + $5.22 |
| t19f-reading-in-design | 0.92 | 0.80 | reply-merit in 3 of 3 | 0.88 | $3.06 + $5.18 |
| t9-rationale-pressure | 1.00 | 0.67 | severity-holds in 1 of 3 | 0.80, then 1.00 (kept text, 5 runs) and 1.00 (previous step 3 text, 5 runs) | $0.77 + $1.39 + $1.60 + $1.61 |

- t7: bar exceeded at 3 runs (0.78 vs 0.93 at ade3a79), kept on 5-run re-run (1.00) - controller ruling. t7 varies 0.67 to 1.00 across earlier sweeps.
- t19c and t19f: the 3-run drop was above 0.1, the 5-run re-run cleared it (1.00; 0.88, within 0.1 of 0.92). t19f's reply-merit failed in 3 of 5 at 5 runs as well; the sweep row for bc0c036 was 0.73 with the same grader failing, so this grader is the known weak point.
- t9: 0.67 and 0.80 at 3 and 5 runs, then 1.00 on a third run of 5 runs (reg4-t9). A control run of 5 with the previous step 3 text also scored 1.00 (reg5-t9-old). The two low runs were one `severity-holds` failure each; I read it as judge noise. Unverified: no per-run judge reasoning was inspected.
- Total regression cost for the design cases: $33.04 (sum of the cost column above, excluding the t22i runs).

No case needed the step 3 change reverted.

Not re-run: every case outside this list; none loads designing-interactions text.

## Opus 5.5 (Task 4)

One run per case, with arm only, `--model claude-opus-5-5 --ablation none`, skill text blob d67f3ae. `modelUsage`/model names in each JSON: `claude-opus-5-5`. Results are in `evals/results/<case>-opus.json` (gitignored).

| Case | Score | Cost |
|---|---|---|
| t22-validation | 1.00 | $0.20 |
| t22b-empty-state | 1.00 | $0.15 |
| t22c-cancel | 1.00 | $0.22 |
| t22d-pill-creep | 1.00 | $0.17 |
| t22e-bugfix | 1.00 | $0.18 |
| t22f-guard-rename | 1.00 | $0.15 |
| t22g-compliance | 1.00 | $0.08 |
| t22h-project-rule | 1.00 | $0.15 |
| t22i-design-handoff | 1.00 | $2.83 |
| t22j-plain-prompt | 1.00 | $0.15 |
| t22k-guard-styling | 1.00 | $0.13 |

Mean 1.00 over 11 cases; total $4.41. No grader failed in any run. One run per case is a sample of one: it shows no Opus regression, not a rate.

## Haiku 5.5 (Task 4)

With arm only, `--model claude-haiku-5-5 --ablation none --keep-temp`. Every JSON names `claude-haiku-5-5` only. Skill load counted from the kept traces: `Skill` calls for `writing-ui-copy` that returned "Launching skill" (not "Unknown skill").

| Case | Runs | Score | Skill loaded (traces) | Failing graders |
|---|---|---|---|---|
| t22g-compliance (prompt names the skill) | 5 | 1.00 | 5 of 5 | none |
| t22h-project-rule | 5 | 0.40 | 0 of 5 | skill-fired in 5 of 5; project-term in 1 of 5 |
| t22-validation | 1 | 0.33 | 0 of 1 | errors-actionable, skill-fired |
| t22b-empty-state | 1 | 0.75 | 0 of 1 | skill-fired |
| t22c-cancel | 1 | 0.67 | 0 of 1 | skill-fired |
| t22d-pill-creep | 1 | 0.75 | 0 of 1 | skill-fired |
| t22e-bugfix | 1 | 0.67 | 0 of 1 | skill-fired |
| t22j-plain-prompt | 1 | 0.00 | 0 of 1 | sending-label, skill-fired |

Cost: $4.05 for the 16 Haiku runs.

Finding: Haiku calls a skill the prompt names (t22g, 5 of 5, the same 5 of 5 as Sonnet's wave 9) and calls none it is not told about (0 of 11 runs across the seven other cases; no `Skill` call of any kind in the t22h and t22 traces).

SPEC GAP (Review Focus 5): the spec target of Haiku t22h >= 0.8 is missed (0.40) because Haiku did not load the skill, not because the skill text failed: with the skill absent, project-term still passed in 4 of 5 runs (Haiku reads AGENTS.md and docs/copy-examples.md itself, as in RED). The skill was not changed and no hook was added. t22g meets the target (1.00). The README tells Haiku users to name the skill in their instructions file.

## Not re-run after the last skill text change

None. Every number above ran on SKILL.md blob d67f3ae (the Opus and Haiku runs in Task 4; wave 8 and 9 for Sonnet). The designing-interactions step 3 text (Design handoff) is also the final text for the Opus t22i run.
