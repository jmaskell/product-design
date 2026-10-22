# Review page and plan-file prose: RED record (2026-10-15)

Sonnet 5.5, `--judge-model sonnet`, 3 runs per arm, both arms. Billed to the subscription (no `ANTHROPIC_API_KEY`). Results are in `evals/results/` (gitignored): `red-<case>.json`, and `red2-<case>.json` for the three cases re-run after the grader fix below. Skill text: main at 95fa499.

| Case | With | Without | Failing graders (with) | Why they fail |
|---|---|---|---|---|
| t24-review-page-r2 | 0.14 | 0.10 | changes-bullets, summary-one-fact, before-release, changes-per-person, grids-collapsed, stages-as-rows (3/3 each) | The template has no changes section, writes the Summary as run-on lines, offers only two timings, and lays the grids out open, with people as rows. |
| t24b-review-play | 0.17 | 0.00 | play-in-order, notes-hidden, notes-toggle (3/3); screens-laid-out (1/3) | Nothing asks for a play control or hidden notes. The focus marker shows on load. |
| t24c-site-target | 0.00 | 0.11 | command-ran, recorded, reply-paste (3/3) | `site` is not a target value. Runs fall back to the file target and never run publish.sh. |
| t24d-branch-check | 0.33 | 0.17 | names-branch (3/3); no-page (1/3) | No run checks other branches. Runs publish from main, and one wrote the page with Write. Others wrote it through Python, which `no-page` can't see; `names-branch` fails those runs. |
| t24e-copy-change | 0.40 | 0.40 | copy-current, no-old-copy, pattern-bullets (3/3) | Runs edit the strings in place and append another → entry to the copy log. The pattern paragraph stays one paragraph. mock-updated and mock-no-old pass in both arms: the mock already changes with the copy when the limit is the subject. |
| t24f-email-notes | 0.56 | 0.00 | notes-bullets (3/3); refs-once (1/3) | Runs copy the deck's run-on note format. skill-fired passes in the with arm. |
| t24g-role-word | 0.67 | 0.50 | flags-role-word (1/3), no-false-role (1/3) | The walkthrough lens already names "repairs coordinator" against actors.md in 2 of 3 runs, inside a wider finding. No rule makes it a finding of its own. The no-false-role failure was not traced. |
| t24h-mock-links | 0.00 | 0.00 | links-next, annotation-marked, annotation-hidden (3/3) | Mocks link nowhere (`href="/repairs"` at most). Focus markers are visible outlines with no attribute. |

No case reaches 0.8 in the without arm, so there is no GUARD case.

## Grader fixes during RED

- t24c `reply-paste`, t24d `names-branch`, t24g `flags-role-word` and `no-false-role`: a helper bug wrote "x" as the judge prompt. The four were rewritten as the plan gives them, and the three cases re-ran (`red2-*`). The rows above are the re-runs.
- t24 `grids-collapsed`, t24e `no-old-copy`: zsh `echo` turned `\b` into a backspace. Restored before any run read them.
- t24d: a Bash-write variant of `no-page` was tried and dropped. A run wrote the page through Python, which no shell pattern catches. `names-branch` fails any run that publishes.

## Cost

$16.29 API-equivalent, from `costUsd` (subscription billing): first pass $12.95, re-runs $3.34.
