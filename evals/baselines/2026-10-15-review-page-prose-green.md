# Review page and plan-file prose: GREEN record (2026-10-15)

RED: `2026-10-15-review-page-prose-red.md`. Sonnet 5.5, `--judge-model sonnet`, billed to the subscription. Results are in `evals/results/` (gitignored), named `<wave>-<case>.json`.

The owner chose the cheaper option: GREEN at 3 runs per arm, not 5. AGENTS.md asks for 5, so this is an owner waiver. A case at 0.80–0.87 was to be topped up to 5 runs; see t24 below for why it wasn't.

Final skill text (blob @ last commit that changed it):

| File | Blob | Last changed |
|---|---|---|
| references/plain-prose.md | 0eb16f6 | 7f31cab |
| references/mocks.md | 4d43f93 | cc06dab |
| templates/review-page.md | 3b17829 | 3d83d15 |
| templates/design.md | 9641110 | 5f65377 |
| skills/sharing-designs/SKILL.md | 3168a2d | 80b04be |
| skills/sharing-designs/artifact.md | 15f9c81 | 3d4abb7 |
| skills/sharing-designs/notion.md | c9e0cf4 | 3d83d15 |
| skills/writing-ui-copy/SKILL.md | 6e246c3 | 80b04be |
| skills/reviewing-product-design/synthesis.md | 793d5c1 | 25bd231 |

## Cases, 3 runs per arm

| Case | With | Without | Failing graders (with) | Text the number came from | Status |
|---|---|---|---|---|---|
| t24-review-page-r2 | 0.83 (`g2`) | 0.17 | summary-one-fact 3/3, stages-as-rows 1/3 | 80b04be | GREEN on score; summary-one-fact unproven in the harness |
| t24b-review-play | 0.92 (`green`) | 0.00 | screens-laid-out 1/3 | 3d4abb7 (sharing SKILL.md changed after: branch check, wording) | GREEN |
| t24c-site-target | 1.00 (`green`) | 0.11 | none | 3d4abb7 | GREEN |
| t24d-branch-check | 0.50 (`g2`) | 0.00 | names-branch 2/3, no-page 1/3 | 80b04be | HARNESS-LIMITED |
| t24e-copy-change | 0.80 (`router4`, 5 runs) | 0.40 | pattern-bullets 3/5, copy-current 1/5, no-old-copy 1/5 | 718e78c | GREEN (router addendum) |
| t24f-email-notes | 0.56 (`g2`) | 0.00 | notes-bullets 2/3, refs-once 2/3 | 80b04be | NOT GREEN |
| t24g-role-word | 1.00 (`green`) | 0.33 | none | 25bd231 | GREEN |
| t24h-mock-links | 0.89 (`g2`) | 0.11 | links-next 1/3 | cc06dab | GREEN |

Notes:
- **t24:** summary-one-fact fails 3/3 in the harness, which judges the whole 8,000-character page and warns that long inputs are noisy. A Sonnet judge given only the Summary section passed all 3 runs (`claude -p --model sonnet`). No top-up: more runs would repeat the same noise.
- **t24d:** in the eval sandbox, `/usr/bin/git` (the xcrun shim) fails with "Operation not permitted". 2 of 3 runs got no git output and published. The run that fell back to `/opt/homebrew/bin/git` stopped and named the branch, passing both graders. The command, run by hand on the scaffold, prints `refs/heads/build/contractor-date`.
- **t24e:** with the skill named in the prompt, designing-products fires but edits design.md itself for a one-limit revision. It never loads designing-interactions, so neither plain-prose.md nor the design.md template is read. Fixing this means changing the router, which is out of scope this round.
- **t24f:** across 4 waves, runs went from run-on notes to `- ` bullets. Some bullets still hold two facts plus a reason ("No apology or reason line; no button, because …").

## Waves

1. Tasks 2–6 text (5f65377 to 7f31cab): t24 0.71, t24b 0.92, t24c 1.00, t24g 1.00, t24h 0.56, t24d 0.50, t24e 0.40, t24f 0.67 → 0.56.
   - t24f: runs read plain-prose.md but kept the deck's one-line notes. The prompt said "in the same format", and runs obeyed it, so it was dropped from the prompt (case fix). The rule became "Copy-deck notes are `- ` bullets, one fact each" in writing-ui-copy rule 9.
   - t24e: no skill fired in 3/3 runs. The prompt now names product-design:designing-products.
   - t24d: runs ran both `git log` commands and published anyway. The check became one command whose output names the branch (`--source … %S`).
2. 80b04be: t24 0.83, t24h 0.89, t24d 0.50 (sandbox git), t24f 0.56, t24e 0.40.

## Grader changes after RED

- t24 changes-bullets: llm → regex (a `<ul>` of 3+ items right after the "Changed since" heading), plus changes-no-decision (regex, count:0). The llm judge failed a clean list in 1 of 3 runs. The regex passes all 3 GREEN outputs and fails 2 of 3 RED outputs.
- t24 summary-one-fact: one action in two verbs counts as one fact. The without arm still fails it 3/3.
- t24h links-next: also accepts `action=` and a `#fragment`. annotation-hidden: llm → regex on the hide rule. Both failed runs that had the right markup.
- t24f prompt and t24e prompt: see Waves.

## Regression (with arm, `--ablation none`, 3 runs)

| Case | Earlier | Now | Cost |
|---|---|---|---|
| t14-review-page (swim-lanes grader updated for stages as rows) | 1.00 | 1.00 | $0.81 |
| t22-validation | 1.00 | 1.00 | $0.29 |
| t23f-review-needed | 0.90 | 1.00 | $1.99 |

Cheaper option, so these were not re-run: t14b, t14d, t15, t22b, t22e, t23e, t5. t14 has no git repo, so it doesn't test the branch check on a single-branch repo (Review Focus 5).

## Opus 5.5 (1 run, with arm, final text)

| Case | Score | Failing | Cost |
|---|---|---|---|
| t24-review-page-r2 | 0.88 | summary-one-fact | $0.50 |
| t24b-review-play | 0.75 | screens-laid-out | $0.60 |
| t24h-mock-links | 1.00 | timed out at 570 s; graders ran on the files written | $1.73 |

## Untested spec lines

- The 20-word sentence limit: no regex grader. The llm graders judge it only inside "one fact per sentence".
- Script access to the mock iframes inside a claude.ai artifact (the evals use the file target).
- The Notion toggle block and the Notion screen-order list.
- Older mocks without `data-annotation`, listed for the owner.
- The `site` target when the publish command fails.

## Final review fixes (fresh reviewer, Opus)

- Branch check (Critical): the `--all --source` command named a ref that HEAD already had: main, a remote or the stash. It stopped the share on an ordinary feature branch. It now runs `git log --branches --not HEAD --source -1` and compares dates. Repro on a cloned scaffold: the old command printed `refs/remotes/origin/build/contractor-date` on a plain feature branch, and the new one prints nothing. In the true case (t24d scaffold) the new one still prints `build/contractor-date`.
- mocks.md: a design note is its own element, never the designed region. Hiding the region would hide the new pattern under review.
- plain-prose.md rule 6: decisions.md is append-only.
- t24h: new grader notes-kept (llm), which the without arm can pass on its merits.

Re-run after the fixes (3 runs per arm, 74204e4):

| Case | With | Without | Failing (with) | Status |
|---|---|---|---|---|
| t24i-branch-guard (new) | 0.67 | 0.00 | no-false-stop 2/3 | GUARD, HARNESS-LIMITED: every run wrote the page and none stopped on a branch. The 2 failures are runs that told the owner git failed in the sandbox and asked them to run the check. |
| t24h-mock-links | 0.92 | 0.08 | notes-kept 1/3 | GREEN |

Not re-run after 74204e4: t24, t24b, t24c (sharing SKILL.md lost its evidence-label bullet, which the template still states; t14's labels-kept passed at 1.00 before the change), t24d (sandbox git), t24f, t24e (plain-prose rule 6 changed).


## Router addendum (2026-10-16, owner approved, same PR)

On a small revision, designing-products edited design.md itself and never read plain-prose.md (t24e at 0.40).

| Wave | Text | t24e with | Without | What the runs did |
|---|---|---|---|---|
| 1 | 2e925b8: line at the end of the router | 0.40 | 0.40 | 1/3 read plain-prose. All kept the copy log. |
| 2 | 4e1b7ca: line moved into Phases ("Before editing a plan file, read …"); plain-prose: a touched log becomes the current state | 0.53 | 0.40 | 3/3 kept the log heading; 2 made the pattern a list. |
| 3 | 39274de: plain-prose: rename the log (`## Copy`); grader pattern-bullets aligned to "one fact per sentence" (the spec rule, not "per item") | 0.80 (3 runs), 0.64 (5 with a 2-run top-up) | 0.40 | The top-up runs read plain-prose and kept the log "as history". |
| 4 | 718e78c: plain-prose rule 6: never keep a log, not even as history | 0.80 (5 runs) | 0.40 | 4/5 replaced the log with `## Copy`. pattern-bullets fails 3/5 on lists of one-fact sentences; the entry says "week 4", not "4 weeks". |

Router regression on the final router text (4e1b7ca; later commits changed plain-prose.md only), with arm, 3 runs:

| Case | Earlier | Now | Note |
|---|---|---|---|
| t1-repeat-action | 1.00 | 1.00 | |
| t6-trivial | 0.90 | 1.00 | |
| t10-stops-at-g1 | 1.00 | 1.00 | |
| t12-project-rule-wins | 1.00 | 0.78 | Both failures are in the one run that timed out at 570 s; the other 2 runs pass every grader. |
| t7-component-reuse | 0.93 | 0.67 | options-named 3/3. **The same on main (95fa499): 0.67, options-named 3/3.** Drift that predates this branch, not a regression. |

Not tested: whether the router fires on an unnamed "revise" (t24e's prompt names the skill).

## Cost

$64.55 API-equivalent (subscription billing): RED $16.30, GREEN $23.47, regression $3.09, Opus $2.83, final-review re-runs $4.24, router addendum $14.63 (t24e $4.87, regression $7.40 including a stopped run, t7 on main $2.36).
