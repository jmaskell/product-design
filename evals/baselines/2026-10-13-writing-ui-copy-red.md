# RED record: writing-ui-copy (cases t22 to t22i)

Date: 2026-10-13. Claude Code 2.1.287. `skills/writing-ui-copy/` does not exist yet. Judge: sonnet. 3 runs per arm. No case or grader changed after its first run.

Sonnet 5.5 command per behavioural case: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --model claude-sonnet-5-5 --judge-model sonnet --case <case> --runs 3 -j 6 --keep-temp --json evals/results/<case>-red.json`. t22g runs the same without `--scaffold --allow-tools Bash Write Edit`. Haiku runs swap in `--model claude-haiku-5-5` (t22g, t22h only). Total eval cost across the 11 RED runs: $11.59 (Haiku runs $4.18 of it).

Score = mean run score. `skill-fired` counts at weight 1 and fails in both arms by construction, so a case whose merit graders all pass still scores 0.5 to 0.75.

## Sonnet 5.5

| Case | With | Without | Failing graders (3 runs, both arms unless noted) | Status |
|---|---|---|---|---|
| t22-validation | 0.44 | 0.33 | skill-fired 0/3; errors-actionable 1/3 with, 0/3 without | RED |
| t22b-empty-state | 0.75 | 0.75 | skill-fired 0/3 only | RED on skill-fired only; merit PASSES-WITHOUT |
| t22c-cancel | 0.67 | 0.67 | skill-fired 0/3 only | RED on skill-fired only; merit PASSES-WITHOUT |
| t22d-pill-creep | 0.75 | 0.75 | skill-fired 0/3 only | RED on skill-fired only; merit PASSES-WITHOUT |
| t22e-bugfix | 0.67 | 0.67 | skill-fired 0/3 only | RED on skill-fired only; merit PASSES-WITHOUT |
| t22f-guard-rename | 1.00 | 1.00 | none | GUARD |
| t22g-compliance | 0.40 | 0.47 | empty-and-confirm 0/3, no-extra-elements 0/3 (both arms); skill-fired 1/3 (both arms, see below) | RED |
| t22h-project-rule | 0.00 | 0.00 | skill-fired 0/3, project-term 0/3 | RED |
| t22i-design-handoff | 0.00 | 0.00 | skill-fired 0/3 | RED (skill-fired only, the only grader) |

Per-grader pass counts (with arm / without arm, out of 3):
- t22: skill-fired 0/0, errors-actionable 1/0, no-generic-errors 3/3.
- t22b: skill-fired 0/0, empty-state 3/3, no-restated-heading 3/3, no-badge 3/3.
- t22c: skill-fired 0/0, confirm-copy 3/3, no-bare-buttons 3/3.
- t22d: skill-fired 0/0, no-badge 3/3, no-provenance 3/3, no-explainer 3/3.
- t22e: skill-fired 0/0, upload-error 3/3, no-generic-errors 3/3.
- t22f: skill-not-fired 3/3, renamed 3/3.
- t22g: skill-fired 1/1, buttons 2/3, error-shape 3/3, empty-and-confirm 0/0, no-extra-elements 0/0.
- t22h: skill-fired 0/0, project-term 0/0.
- t22i: skill-fired 0/0.

## Haiku 5.5 (spec's Haiku target)

`modelUsage` in the JSON names `claude-haiku-5-5`; the `unrecognized_model` warning is cosmetic.

| Case | With | Without | Per-grader (with / without) | Status |
|---|---|---|---|---|
| t22g-compliance | 0.60 | 0.53 | skill-fired 3/3 and 3/3, buttons 3/2, error-shape 3/3, empty-and-confirm 0/0, no-extra-elements 0/0 | RED on merit (two graders 0/3 in both arms) |
| t22h-project-rule | 0.50 | 0.50 | skill-fired 0/0, project-term 3/3 and 3/3 | PASSES-WITHOUT on merit: Haiku reads AGENTS.md and docs/copy-examples.md itself (5 of 6 traces list `copy-examples.md`); Sonnet never opens either |

## Probe (Step 3)

`t22b-empty-state`, 1 run, with arm only, kept trace. File-focus graders did not report "does not exist". `empty-state` returned PASS (votes PASS PASS PASS) and `no-restated-heading` returned FAIL (votes FAIL FAIL FAIL) with the edited `RepairsList.tsx` as evidence. No skill fired in the trace. Cost $0.07.

## Why each RED grader fails

- `skill-fired` (every case but t22f, t22g): the skill does not exist; no `Skill` call names it. t22i's with arm calls `designing-products`, `designing-interactions` and `reviewing-product-design`, not `writing-ui-copy`.
- t22g `skill-fired` (1/3 Sonnet, 3/3 Haiku, both arms): the prompt says "Use the writing-ui-copy skill". The model calls `Skill` with `"skill":"writing-ui-copy"` and gets `Unknown skill: writing-ui-copy`. The `tool_used` grader matches the call input, so a failed call passes. It cannot fail for Haiku while the prompt names the skill.
- t22 errors-actionable: both arms write "Description is required." and "Photo must be 10MB or smaller." (problem statements, no fix). The with-arm run that passed wrote "Describe what needs fixing." for the empty case.
- t22g empty-and-confirm: every run adds a confirmation body ("you can't undo this") but also a pep or extra line in the no-updates message ("We'll let you know when your landlord or a contractor replies.", "We'll show messages about this repair here."); the grader fails in all 3 runs of each of the four model and arm combinations (12 of 12).
- t22g no-extra-elements: every run adds elements beyond the seven (back link, status values, success toast, other upload error, "Uploading photo…", "Reported on {date}", Photos heading) and the judge counts them as extras (failing in all 12 runs).
- t22h project-term (Sonnet, 6 of 6): the email is "Reminder: ${visit.category} visit tomorrow at ${visit.address}" with body "What: ${visit.category}"; it never says "job". Sonnet does not open AGENTS.md or docs/copy-examples.md, so it never sees the rule.

## Merit graders that pass without the skill

t22b, t22c, t22d, t22e: every merit grader passes 3/3 in the without arm. Strings the without arm wrote: t22b "You have no repairs. When you report one, it will appear here."; t22c "Cancel this repair? This can't be undone." with "Yes, cancel repair" and "Keep repair"; t22d plain columns "Contractor" and "Last updated" with "Not yet assigned"; t22e "Your photo couldn't be uploaded. Please try again." and "Your photo didn't upload. Please try again, or submit without a photo.". Scores are below 0.8 only because `skill-fired` fails. These four cases show the failure to load the skill and nothing else. They are not evidence that rules answer a copy failure. The cases were not changed (no without arm scored 0.8 or more); the controller decides whether to tighten or relabel them GUARD before Task 2.

## Skills fired

Every `Skill` call in the kept traces (`/private/tmp/e-*/out/trace.jsonl`, matched with `grep -ohE '"skill"\s*:\s*"[^"]*"'`):
- t22, t22b, t22c, t22d, t22e, t22f, t22h (Sonnet and Haiku), both arms: none.
- t22g Sonnet: `writing-ui-copy` once in the with arm and once in the without arm (run 0 each); result `Unknown skill`. Haiku: `writing-ui-copy` in all 6 runs, same result.
- t22i with arm: `designing-products` (2 runs), `designing-interactions` (3), `reviewing-product-design` (3). Without arm: none.
- No other copy skill (ux-writing, ux-microcopy-audit, copywriting) fired in any without arm. The owner's global disable holds.

## Strings outside the graded file

None. Every run kept its strings in the file the prompt named. t22c wrote to `CancelRepair.tsx` and `RepairsList.tsx` (both named in the prompt); t22e edited `upload.ts` in 3 of 6 runs without adding strings there. t22g strings are in the reply, as designed. t22i wrote design files under `docs/plans/repair-status/` as asked; some traces also list reference files read from the plugin.
