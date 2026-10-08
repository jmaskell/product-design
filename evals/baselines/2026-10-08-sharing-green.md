# GREEN record: sharing-designs (2026-10-08)

Compare with `2026-10-08-sharing-red.md`. Sonnet judge, `--ablation with-without`, threshold 0.8. Counts come from the task reports in `.superpowers/sdd/2026-10-08-sharing-designs/`. The result JSON files in `evals/results/` are not in git.

## Scores

| Case | With | Without | Runs | Graders (with arm) | Text the run used |
|---|---|---|---|---|---|
| t14-review-page | 1.00 | 0.00 | 5 | 7 of 7 graders 5/5, swim-lanes included | Task 8 first text (0120bcc) |
| t14b-review-page-g1 | 1.00 | 0.00 | 3 | all 3 graders pass | Task 8 first text |
| t14c-notion-unavailable | 1.00 | 0.50 | 3 | no-page-written passes | Task 4 text |
| t14d-mock-privacy | 1.00 | 0.33 | 3 | mock-flagged, no-public-identity, page-exists 3/3 | Task 8 first text |
| t15-comment-triage | 1.00 | 0.51 | 5 | all 9 graders 5/5 | Task 3 text, before fix round 1 |
| t15b-mixed-comment | 1.00 | 0.00 | 5 | answer-recorded 5/5, objection-is-finding 5/5 | Task 3 fix round 1 |

Every case meets the 0.8 threshold. Every case shows a positive delta. The RED record had t14 and t14b at 0.00 with the with arm.

## Which numbers come from the last text change

- t14: Task 8 fix round 1 changed the template and notion.md. t14 re-ran for 3 runs after it: 1.00, 7 of 7 graders 3/3.
- t15: Task 3 fix round 1 re-ran t15 for 3 runs: 1.00 with, 0.55 without. Task 4 fix round 2 changed triage.md last. t15 re-ran for 3 runs: 1.00. The 5-run row above is earlier text.
- t15b: Task 4 fix round 2 changed triage.md after the 5-run result. I did not re-run t15b on the last text.
- t14b, t14d: the rows are from the first Task 8 text. Task 8 fix round 1 changed notion.md and the template. I did not re-run t14b and t14d after it.
- t14c: the row is from Task 4. Task 8 later changed notion.md (database, screenshots). I did not re-run t14c after it.
- The brief gave t14d as 5 runs. The task reports show 3 runs for t14d. This record follows the reports.

## Router regression after the router change (Task 5)

Command: 5 runs per arm, both arms, `--json evals/results/router-*.json`.

| Case | With | Without | Graders (with arm) |
|---|---|---|---|
| t6-trivial | 0.90 | 0.50 | no-subagent 5/5; one-short-pass 4/5 |
| t10-stops-at-g1 | 1.00 | 0.00 | both graders 5/5 |
| t1-repeat-action | 1.00 | 0.40 | both graders 5/5 |

The failing t6 run lost one-short-pass only. These runs kept no traces (no `--keep-temp`).

## Manual runs by the owner (2026-10-08)

Setting: the ntx test worktree, with real Notion and claude.ai.

- Artifact path: works. The owner rated the result as working well.
- Notion path: works. The run found three problems. Task 8 fixed each one:
  - The Notion MCP edits properties only on a database it created. Now `Review space` can name a page, and the skill creates the database.
  - Screenshot uploads were slow and the images were huge. Now the skill writes the text first, takes one screenshot per screen at a set viewport, and scales it to 1000 px wide or less (about 300 KB).
  - The owner asked for a swim-lane journey. Now the page has a Today grid and a Proposed grid, with ◆ on each changed cell.
- Tagging: Confirmed by the owner's run. Mentions notified each person.
- I did not test the duplicate-name prompt. The owner did not report on it.
- I did not test the Notion revision and Superseded flow. The owner did not report on it.

## Not re-run after Task 8

- Unverified: the page-URL database creation against live Notion.
- Unverified: the text-first upload against live Notion.
- Unverified: the screenshot sizing against live Notion.
- Unverified: the tool name notion-update-data-source. Task 8 took it from the hosted Notion MCP docs (ctx7), not from a live call.

## Gaps with no eval

- Small never offers sharing. No grader reads the t6 output text, and the t6 runs kept no traces.
- The no-comments rule in triage.md. t15 and t15b both have comments.
- The artifact reply on threads sent to Claude. The eval target is a file, and a file has no threads. The owner's artifact run is the only check.
- The graders `objection-is-finding` (t15, t15b) read the reply only. They do not read a finding in a plan file.
- No RED result for t15b. The old "sort each comment" wording was never run against it.

## Harness notes

See the RED record for the grader shapes that work (`flags:` key, `count:0`, `tool_used`). Task 8 added the llm grader `swim-lanes` to t14. RED: it failed before the change. First GREEN pass: 0.97 over 5 runs (4 of 5 on swim-lanes). The failing run copied "Nothing" into a cell. The template now says "never 'nothing' or a blank cell", and the final runs pass 5 of 5.
