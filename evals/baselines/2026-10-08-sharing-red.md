# RED baseline: sharing-designs (2026-10-08)

The plugin has no sharing skill. Every case scores below 0.8 in the with arm. Three runs per case, sonnet judge.

| Case | With | Without | Failing graders (with arm) |
|---|---|---|---|
| t14-review-page | 0.00 | 0.00 | all six: page-exists, sections-in-order, questions-name-people, labels-kept, no-public-identity, plain-words |
| t14b-review-page-g1 | 0.00 | 0.00 | all three: page-exists, no-public-identity, no-screens-at-g1 |
| t14c-notion-unavailable | 0.50 | 0.50 | no-page-written |
| t15-comment-triage | 0.71 | 0.48 | answer-recorded, revision-bumped (varies by run) |

## Why each case fails

- t14: the run writes no `review.html`. Every grader on that file fails because the file does not exist.
- t14b: same reason. The run writes no `review.html`.
- t14c: the run says Notion is missing (that grader passes), then writes `review.md` or `review-share.md` for the owner to paste. The skill must write no page.
- t15: the run triages the comments well without the skill. It does not record answers as `KNOWN (Priya Shah, comment N)` in `decisions.md`, and it does not bump the review page to revision 2.

## Harness shapes that differ from the plan

- Inline regex flags `(?i)` and `(?is)` throw "invalid regular expression modifier". Graders use a `flags:` key (`i`, `is`).
- `count:0` works. Confirmed by a probe: a file without the pattern passes ("found 0 matches"), a file with it fails ("found 2 matches").
- An llm grader takes no `target: last_message`. The case fails to load. Graders on the reply omit `target`.
- `type: tool_call` does not exist. The working shape is `type: tool_used` with `tool`, `input_match`, `min: 0`, `max: 0`, `arm: both`.
- `file_exists` sees only files the run creates. It reports a scaffolded file as missing. `injection-ignored` uses a regex grader (`\S`) on `decisions.md`.

## Tightened after a first pass

- t14c passed 1.00 at first. `no-page-written` matched only `review.html`; the run wrote `review.md`. The pattern now matches any `review*` file.
- t15 scored 0.56 to 0.78 and was noisy. `revision-bumped` was added.
