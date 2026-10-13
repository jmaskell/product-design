# GREEN record: writing-ui-copy (cases t22 to t22h)

Date: 2026-10-13. Claude Code 2.1.287. Judge: sonnet. 5 runs per arm. t22i is excluded (Task 3 owns it). Task 4 finishes this record (t22i, Opus pass, t22g skill-load check from traces).

Command per behavioural case: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --model claude-sonnet-5-5 --judge-model sonnet --case <case> --runs 5 -j 6 --keep-temp --json evals/results/<wave>/<case>-green.json`. t22g runs the same without `--scaffold --allow-tools Bash Write Edit`.

Text the numbers came from: `skills/writing-ui-copy/SKILL.md` blob `f751b631e7c5addf6083516cd89fdc190be4502f`, committed in "feat: writing-ui-copy skill" (the commit that adds this file). Every case below was run on that exact text (wave 5); no case is stale.

## Scores (wave 5, final text)

| Case | With | Without | Runs | Failing graders, with arm | Per grader, with / without (of 5) | Status |
|---|---|---|---|---|---|---|
| t22-validation | 1.00 | 0.33 | 5 | none | errors-actionable 5/0; no-generic-errors 5/5; skill-fired 5/0 | GREEN |
| t22b-empty-state | 1.00 | 0.70 | 5 | none | empty-state 5/5; no-badge 5/5; no-restated-heading 5/4; skill-fired 5/0 | GREEN (selection only; merit graders are no-regression guards) |
| t22c-cancel | 1.00 | 0.67 | 5 | none | confirm-copy 5/5; no-bare-buttons 5/5; skill-fired 5/0 | GREEN (selection only) |
| t22d-pill-creep | 1.00 | 0.75 | 5 | none | no-badge 5/5; no-explainer 5/5; no-provenance 5/5; skill-fired 5/0 | GREEN (selection only) |
| t22e-bugfix | 1.00 | 0.67 | 5 | none | no-generic-errors 5/5; skill-fired 5/0; upload-error 5/5 | GREEN (selection only) |
| t22f-guard-rename | 1.00 | 1.00 | 5 | none | renamed 5/5; renamed-api 5/5; skill-not-fired 5/5 | GUARD holds |
| t22g-compliance | 0.75 | 0.55 | 5 | no-extra-elements (5 of 5) | buttons 5/5; empty-and-confirm 5/0; error-shape 5/5; no-extra-elements 0/1 | BELOW BAR (see Open) |
| t22h-project-rule | 1.00 | 0.00 | 5 | none | project-term 5/0; skill-fired 5/0 | GREEN |

`writing-ui-copy` fired in 35 of 35 with-arm build runs (t22, t22b to t22e, t22h) and in 0 of 5 t22f runs.

## Waves

| Wave | Blob | t22 | t22b | t22c | t22d | t22e | t22f | t22g | t22h |
|---|---|---|---|---|---|---|---|---|---|
| 1 (brief text) | a73ab30 | 0.67 / 0.33 | 1.00 / 0.75 | 0.73 / 0.67 | 0.45 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.60 / 0.55 | 0.50 / 0.00 |
| 2 | c879e87 | 0.80 / 0.33 | 1.00 / 0.70 | 0.67 / 0.67 | 0.25 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.85 / 0.45 | 0.60 / 0.10 |
| 3 | f36305a | 0.73 / 0.33 | 1.00 / 0.75 | 0.73 / 0.67 | 0.45 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.85 / 0.55 | 0.50 / 0.00 |
| 4 | 79b4696 | 0.93 / 0.33 | not run | 0.73 / 0.67 | 1.00 / 0.75 | not run | 1.00 / 1.00 | not run | 0.80 / 0.00 |
| 5 (final) | f751b63 | 1.00 / 0.33 | 1.00 / 0.70 | 1.00 / 0.67 | 1.00 / 0.75 | 1.00 / 0.67 | 1.00 / 1.00 | 0.75 / 0.55 | 1.00 / 0.00 |

Skill fired, with arm (of 5), waves 1 to 5: t22 0, 2, 1, 4, 5; t22c 1, 0, 1, 1, 5; t22d 0, 0, 0, 5, 5; t22h 4, 4, 2, 5, 5. t22b and t22e fired 5 of 5 in every wave run.

## Rules pruned (Step 2)

None. Each harness-tested rule had at least one failing grader in a RED run:
- Rule 2: no-explainer (t22d Sonnet with arm, 1 of 3), no-extra-elements (t22g, every combination).
- Rule 3: no-provenance (t22d Sonnet with arm, 1 of 3).
- Rule 5: buttons (t22g Haiku, with 1 of 3, without 2 of 3 failing).
- Rule 6: errors-actionable (t22, 5 of 6 runs failing).
- Rule 7: empty-and-confirm part 1, the no-updates message (t22g, 12 of 12 failing).
- Rule 8: empty-and-confirm part 2 and buttons (t22g).

## Skill text changes and the failure each answered

- Wave 2, rule 8: "name the thing" became "name the specific thing (its name or title, not just its type)"; example "Delete this invoice?" became "Delete invoice INV-042?". Failure: t22g empty-and-confirm failed 5 of 5 with the skill loaded on replies such as "Withdraw this repair? You can't undo this." with "No updates yet". A harness probe (canned reply, 2 runs) showed the judge fails "Withdraw this repair?" 6 of 6 votes and passes "Withdraw your {category} repair?" 6 of 6. Result: empty-and-confirm 5/5 in waves 2, 3 and 5.
- Wave 2, Before writing: added that a project term is applied by using it, not by avoiding the banned word. Failure: t22h with arm read docs/copy-examples.md, then wrote "Visit tomorrow: ${category}" and "What: ${category}", never "job" (4 of 5 failing). Wave 3 tightened it with the example "Rule 'say order, never purchase': 'Your purchase shipped' → 'Your order shipped', not 'It shipped'" after 3 of 5 still failed. Result: project-term passes whenever the skill fired in waves 3 to 5 except 2 runs in wave 4.
- Waves 2 to 5, description and the "Load this before…" line. Failure: skill-fired 0 of 5 (t22, t22d) and 1 of 5 (t22c) in wave 1; the traces go Read → Write/Edit with no Skill call. Steps: wave 2 listed form errors, dialogs, table headers and placeholders and said "side effect of building a feature or fixing a bug" (no clear gain: 2, 0, 0 fired); wave 3 keyed it to "building or changing anything a person sees" (no clear gain: 1, 1, 0); wave 4 opened with "Use when writing code that shows anything to a person" and added "including plain build or bug-fix work with no design step" (t22 4/5, t22d 5/5, t22h 5/5; t22c 1/5). Assumption: the "no design step" clause counters the case answer "No design document or plan is needed", which made the agent skip product-design skills. Wave 5 added "and even when the wording seems obvious" (t22c 5/5). The "Load this before…" line now reads "before the first edit to anything a person sees, whatever the task is called".
- Wave 5, Before writing: "instructions file (CLAUDE.md or equivalent)" became "instructions files (CLAUDE.md or any equivalent at the repo root)". Failure: one wave-4 t22h run loaded the skill, globbed only for CLAUDE.md, never opened the project's other instructions file, and missed the term rule.

No case or grader was changed. The temporary `zz-probe-*` cases used for judge probes were deleted after each probe.

## Open: t22g no-extra-elements

t22g is below the bar after 4 fix waves (with 0.75, without 0.55; waves 2 and 3 scored 0.85). The with-arm replies give the seven elements plus the confirmation's two buttons, which the grader allows, and empty-and-confirm now passes 5 of 5. Harness probes with canned replies (2 runs, 3 votes each) show the judge is unstable on spec-meeting text:
- Wave-5 run 1 reply, list lines only: PASS 6 of 6 votes. The same reply with its one-line preface ("The project has no copy rules, so these follow the skill's defaults…"): FAIL 6 of 6.
- The list-only reply with the heading "Repair: {repair title}" changed to "Repair details": FAIL 6 of 6. With the status "{Reported / Scheduled / Completed}" changed to "In progress": FAIL 4 of 6.
- Adding "A placeholder or example values for a listed element count as that element. Notes outside the list of strings are not elements." to the grader did not change the verdicts (FAIL 12 of 12).
- A local re-judge with the same prompt (`claude -p`, sonnet 5.5 and 4.6) passed the replies the harness failed. This matches the judge anomaly in evals/README.md.

Unverified: which line the harness judge treats as an extra element; it records votes only. The skill was not changed for this grader: no wave-5 reply adds an element outside the spec, so a rule 2 change would answer no observed failure. One reply-level pattern may matter: the replies open or close with notes on which rules were used, and the preface probe flipped the verdict.

## Untested lines

- Rule 1 (name the thing, give the action, stop), rule 4 (no hedging or disclaimers), rule 9 (conventions): no grader tests them alone.
- The "After writing" self-check: no grader isolates it.
- Icon-only buttons and links getting an accessible name (rule 5, second sentence): no case has an icon-only control.
