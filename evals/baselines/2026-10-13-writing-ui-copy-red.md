# RED record: writing-ui-copy (cases t22 to t22i)

Date: 2026-10-13. Claude Code 2.1.287. `skills/writing-ui-copy/` does not exist yet. Judge: sonnet. 3 runs per arm. Rows for t22c, t22d, t22f, t22g (Sonnet and Haiku) are from the fix-round re-run; see Changes after first run.

Sonnet 5.5 command per behavioural case: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --model claude-sonnet-5-5 --judge-model sonnet --case <case> --runs 3 -j 6 --keep-temp --json evals/results/<case>-red.json`. t22g runs the same without `--scaffold --allow-tools Bash Write Edit`. Haiku runs swap in `--model claude-haiku-5-5` (t22g, t22h only). Eval cost: $11.59 was the first-run batch only (11 runs, Haiku $4.18 of it). After the re-runs, the 11 result files behind the tables cost $10.69 (Haiku $3.56 of it); the superseded first-run and round-1 files, kept in `evals/results/first/`, cost $6.80 more.

Score = mean run score. `skill-fired` counts at weight 1 and fails in both arms by construction, so a case whose merit graders all pass still scores 0.5 to 0.75.

## Sonnet 5.5

| Case | With | Without | Failing graders, with arm (run 1 / 2 / 3) | Failing graders, without arm (run 1 / 2 / 3) | Status |
|---|---|---|---|---|---|
| t22-validation | 0.44 | 0.33 | errors-actionable, skill-fired / errors-actionable, skill-fired / skill-fired | errors-actionable, skill-fired / errors-actionable, skill-fired / errors-actionable, skill-fired | RED |
| t22b-empty-state | 0.75 | 0.75 | skill-fired / skill-fired / skill-fired | skill-fired / skill-fired / skill-fired | RED on skill-fired only; merit PASSES-WITHOUT |
| t22c-cancel | 0.67 | 0.67 | skill-fired / skill-fired / skill-fired | skill-fired / skill-fired / skill-fired | RED on skill-fired only; merit PASSES-WITHOUT |
| t22d-pill-creep | 0.58 | 0.75 | skill-fired / skill-fired / no-explainer, no-provenance, skill-fired | skill-fired / skill-fired / skill-fired | RED on skill-fired only; merit PASSES-WITHOUT (one with-arm run failed no-explainer and no-provenance: "Your landlord hasn't chosen a contractor yet") |
| t22e-bugfix | 0.67 | 0.67 | skill-fired / skill-fired / skill-fired | skill-fired / skill-fired / skill-fired | RED on skill-fired only; merit PASSES-WITHOUT |
| t22f-guard-rename | 1.00 | 1.00 | none / none / none | none / none / none | GUARD |
| t22g-compliance | 0.50 | 0.58 | empty-and-confirm, no-extra-elements / empty-and-confirm, no-extra-elements / empty-and-confirm, no-extra-elements | empty-and-confirm, no-extra-elements / empty-and-confirm / empty-and-confirm, no-extra-elements | RED on merit |
| t22h-project-rule | 0.00 | 0.00 | project-term, skill-fired / project-term, skill-fired / project-term, skill-fired | project-term, skill-fired / project-term, skill-fired / project-term, skill-fired | RED |
| t22i-design-handoff | 0.00 | 0.00 | skill-fired / skill-fired / skill-fired | skill-fired / skill-fired / skill-fired | RED (skill-fired only grader) |

Per-grader pass counts (with / without, out of 3):
- t22-validation: errors-actionable 1/0; no-generic-errors 3/3; skill-fired 0/0 (with / without out of 3).
- t22b-empty-state: empty-state 3/3; no-badge 3/3; no-restated-heading 3/3; skill-fired 0/0 (with / without out of 3).
- t22c-cancel: confirm-copy 3/3; no-bare-buttons 3/3; skill-fired 0/0 (with / without out of 3).
- t22d-pill-creep: no-badge 3/3; no-explainer 2/3; no-provenance 2/3; skill-fired 0/0 (with / without out of 3).
- t22e-bugfix: no-generic-errors 3/3; skill-fired 0/0; upload-error 3/3 (with / without out of 3).
- t22f-guard-rename: renamed-api 3/3; renamed 3/3; skill-not-fired 3/3 (with / without out of 3).
- t22g-compliance: buttons 3/3; empty-and-confirm 0/0; error-shape 3/3; no-extra-elements 0/1 (with / without out of 3).
- t22h-project-rule: project-term 0/0; skill-fired 0/0 (with / without out of 3).
- t22i-design-handoff: skill-fired 0/0 (with / without out of 3).

## Haiku 5.5 (spec's Haiku target)

`modelUsage` in the JSON names `claude-haiku-5-5`; the `unrecognized_model` warning is cosmetic.

| Case | With | Without | Failing graders, with arm (run 1 / 2 / 3) | Failing graders, without arm | Status |
|---|---|---|---|---|---|
| t22g-compliance | 0.50 | 0.50 | empty-and-confirm, no-extra-elements / buttons, empty-and-confirm / empty-and-confirm, no-extra-elements | buttons, empty-and-confirm, no-extra-elements / empty-and-confirm / buttons, empty-and-confirm | RED on merit |
| t22h-project-rule | 0.50 | 0.50 | skill-fired / skill-fired / skill-fired | skill-fired / skill-fired / skill-fired | PASSES-WITHOUT on merit: Haiku reads AGENTS.md and docs/copy-examples.md itself (5 of 6 traces list `copy-examples.md`); Sonnet never opens either |

Per-grader (with / without): t22g buttons 2/1; empty-and-confirm 0/0; error-shape 3/3; no-extra-elements 1/2; t22h project-term 3/3; skill-fired 0/0.

## Probe (Step 3)

`t22b-empty-state`, 1 run, with arm only, kept trace. File-focus graders did not report "does not exist". `empty-state` returned PASS (votes PASS PASS PASS) and `no-restated-heading` returned FAIL (votes FAIL FAIL FAIL) with the edited `RepairsList.tsx` as evidence. No skill fired in the trace. Cost $0.07.

## Why each RED grader fails

- `skill-fired` (every case but t22f, t22g): the skill does not exist; no `Skill` call names it. t22i's with arm calls `designing-products`, `designing-interactions` and `reviewing-product-design`, not `writing-ui-copy`.
- t22g `skill-fired`: grader deleted (see Changes after first run). Skill load in t22g will be checked from traces in Task 4.
- t22 errors-actionable: both arms write "Description is required." and "Photo must be 10MB or smaller." (problem statements, no fix). The with-arm run that passed wrote "Describe what needs fixing." for the empty case.
- t22g empty-and-confirm: every run adds a confirmation body ("you can't undo this") but also a pep or extra line in the no-updates message ("We'll let you know when your landlord or a contractor replies.", "We'll show messages about this repair here."); the grader fails in all 3 runs of each of the four model and arm combinations (12 of 12 before and after the re-run).
- t22g no-extra-elements: every run adds elements beyond the seven (back link, status values, success toast, other upload error, "Uploading photo…", "Reported on {date}", Photos heading). First-run grader counted all of them; the narrowed grader (categories only) still failed in all 12 round-1 runs. Round 2 (prompt no longer invites extras): Sonnet with arm 0/3, without arm 1/3 pass; Haiku with arm 1/3, without arm 2/3 pass. Haiku also fails `buttons` in 3 round-2 runs. The judge rationale was not captured; Unverified: which element it quotes. Superseded by fix round 2: the grader now judges scope against the given spec.
- t22h project-term (Sonnet, 6 of 6): the email is "Reminder: ${visit.category} visit tomorrow at ${visit.address}" with body "What: ${visit.category}"; it never says "job". Sonnet does not open AGENTS.md or docs/copy-examples.md, so it never sees the rule.

## Merit graders that pass without the skill

t22b, t22c, t22d, t22e: every merit grader passes 3/3 in the without arm. Strings the without arm wrote: t22b "You have no repairs. When you report one, it will appear here."; t22c "Cancel this repair? This can't be undone." with "Yes, cancel repair" and "Keep repair"; t22d plain columns "Contractor" and "Last updated" with "Not yet assigned"; t22e "Your photo couldn't be uploaded. Please try again." and "Your photo didn't upload. Please try again, or submit without a photo.". Scores are below 0.8 only because `skill-fired` fails. These four cases show the failure to load the skill and nothing else. They are not evidence that rules answer a copy failure. No without arm scored 0.8 or more, so no case was changed at first; the controller decided whether to tighten or relabel them GUARD before Task 2. Several were changed afterwards: see Changes after first run.

## Skills fired

Every `Skill` call in the kept traces (`/private/tmp/e-*/out/trace.jsonl`, matched with `grep -ohE '"skill"\s*:\s*"[^"]*"'`):
- t22, t22b, t22c, t22d, t22e, t22f, t22h (Sonnet and Haiku), both arms: none.
- t22g first run, Sonnet: `writing-ui-copy` once in each arm; Haiku: in all 6 runs; every call returned `Unknown skill`. The re-run has no skill-fired grader.
- t22i with arm: `designing-products` (2 runs), `designing-interactions` (3), `reviewing-product-design` (3). Without arm: none.
- No other copy skill (ux-writing, ux-microcopy-audit, copywriting) fired in any without arm. The owner's global disable holds.

## Strings outside the graded file

None. Every run kept its strings in the file the prompt named. t22c wrote to `CancelRepair.tsx` and `RepairsList.tsx` (both named in the prompt); t22e edited `upload.ts` in 3 of 6 runs without adding strings there. t22g strings are in the reply, as designed. t22i wrote design files under `docs/plans/repair-status/` as asked; some traces also list reference files read from the plugin.

## Changes after first run

Made after the task review, before any skill text existed. No change was made to move a without-arm score toward a target.

First-run numbers for the changed cases (with / without): t22c 0.67 / 0.67; t22d 0.75 / 0.75; t22f 1.00 / 1.00; t22g Sonnet 0.40 / 0.47; t22g Haiku 0.60 / 0.53 (round-1 re-run below: Sonnet 0.50 / 0.50, Haiku 0.50 / 0.58 with no-extra-elements 0/3 in all four model and arm combinations).

- t22g `skill-fired.md` deleted. The prompt names the skill and `tool_used` matched even the "Unknown skill" call, so it was vacuous (Sonnet 1/3, Haiku 3/3 in both arms). Task 4 checks skill load from traces.
- t22g `no-extra-elements.md` narrowed to five listed categories (pill or badge, restated heading, redundant helper text, explainer under a button, who-made or who-sees caption). Navigation, loading, success or error messages and dates no longer count. Reason: the first wording failed 12 of 12 runs on any added element.
- t22g `empty-and-confirm.md` sharpened: the no-updates message must carry no promise, reassurance or explanation, and the judge must quote the failing text. Same bar, clearer.
- t22d `no-badge.md`: removed `Updated` from the alternation. A plain `<th>Updated</th>` column would have failed it. Kept New, Live, Recently updated, Just updated and `<Badge\b`.
- t22f: added `renamed-api.md` (same as `renamed.md`, `path: src/api/repairs.ts`). `renamed.md` checked only `src/types.ts`.
- t22c `no-bare-buttons.md`: regex now also matches `{"Cancel"}` style literals.
- Record format: the failing-graders column is now per run, rebuilt from the result JSONs.

Re-run commands: the Step 4 Sonnet commands for t22c, t22d, t22f (with `--scaffold --allow-tools Bash Write Edit`), the t22g Sonnet command, and the t22g Haiku command; 3 runs per arm. t22d was run twice: the first re-run used the old regex because the BSD `sed` edit failed; the recorded t22d row is from the second re-run with the corrected grader. The first-run t22 JSONs are copied to `evals/results/first/` (gitignored).
- t22g prompt (fix round 2): deleted the sentence "Add any other element you think the screen needs." and rewrote `no-extra-elements.md` to pass only when the reply gives strings for the seven listed elements, plus at most the confirmation's two buttons and a retry action for the upload error; it fails on any other element and quotes the first. Reason: the prompt invited extras, and the round-1 grader failed 12 of 12 runs on volume (a Haiku with-arm reply added 18 elements, none clearly in the five named categories). Round-1 numbers: Sonnet 0.50 / 0.50, Haiku 0.50 / 0.58, no-extra-elements 0/3 everywhere. The table now shows the round-2 scores.
- During GREEN (Task 2, fix round 2), `t22g-compliance/graders/no-extra-elements.md` was deleted. Reason: across GREEN waves 6 to 8, the judge failed lists holding exactly the seven elements plus the two confirmation buttons, so the grader measured judge noise. Rule 2 stays covered by t22b (no-restated-heading, no-badge) and t22d (no-badge, no-explainer). The t22g RED scores above include no-extra-elements. Without it, the graders are buttons, empty-and-confirm and error-shape. See the GREEN record for the re-run.
