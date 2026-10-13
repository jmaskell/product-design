# Evals

Run all: `claude plugin eval . --trust-plugin --no-publish --model claude-sonnet-5-5 --runs 5 --threshold 0.8`
Run one: add `--case <name>`.

Harness facts (confirmed by `evals/results/smoke.json`, 2026-10-07, Claude Code 2.1.285):
- Case score: the weighted share of passing graders in a run, 0 to 1. The case score is the mean of its run scores in the `with` arm. The JSON also holds `scoreWithout` and `delta` for the no-plugin arm.
- Threshold: `--threshold` exits 1 when any case score is below it. The JSON records it as `suite.threshold` (default 1).
- Working `plugins:` value: `["../../.."]`, relative to the case directory. It resolves to the repo root.
- `--case` repeatable in one run: no. A second `--case` replaces the first, and brace globs match nothing. Run each case separately.
- Ablation: the default `with-without` mode runs each case in a second arm without the plugin, so it doubles the runs. Use `--ablation none` for one arm.

Cases are single prompts. The harness cannot answer AskUserQuestion, so each prompt carries the owner's answers and says where to stop.

Case format facts (confirmed by probe runs and the RED baseline, 2026-10-07):
- `prompt.md` frontmatter does not accept `context`. A case that needs a fixture or a scaffold uses `case.yaml` (`schema_version: "1.0"`). Put `max_turns`, `timeout_seconds` and `allowed_tools` under `execution:`. A sibling `prompt.md` with no frontmatter gives the prompt, and `graders/*.md` merge in.
- `add_dirs` must name a directory inside the case directory. A path or a symlink out of it is refused. The behavioural cases copy the fixture in `scaffold.sh` instead: `cp -R "$(dirname "$0")/../../fixtures/<name>/." .`
- `scaffold_script` is a path to a script file, relative to the case directory. It runs in the workspace root, so every behavioural case needs `--scaffold`.
- The llm grader key is `focus`, not `target`. `focus: files` gives the judge only the list of changed paths. `focus: {source: file, path: <exact path>}` gives the file content, with no glob. An llm grader takes no `target`. With no `focus`, the judge reads the reply.
- `file_exists` accepts a glob, but it sees only the files the run creates. A file that `scaffold.sh` wrote does not count.
- Bash, Write and Edit are gated. Pass `--allow-tools Bash Write Edit`. Without it, the run withholds them and a `max: 0` Write grader passes for no reason.
- The subagent tool is `Agent` in the trace.
- The default judge (haiku) gave wrong verdicts in both directions. Use `--judge-model sonnet`.
- `--keep-temp` keeps each trace at `/private/tmp/e-*/out/trace.jsonl`.
- Regex `match: count:N` passes only when the match count is exactly N (confirmed by the 2.1.285 source: `matches.length === N`). For "at least N", use `match: contains` with a repeated group, for example `(?:TAG)(?:[\s\S]*?(?:TAG)){4}` for at least 5.
- A file-focus grader fails with "does not exist" when the run did not write that exact path.

Case format facts (confirmed by the sharing-designs runs, 2026-10-08):
- An inline `(?i)` in a regex throws. Put the flags in the `flags:` key, for example `flags: im`.
- There is no `tool_call` grader. Use `tool_used`.
- `weight:` works on any grader.
- Regex `match: count:0` works as an absence check.

Judge anomalies (2026-10-07, Task 5). Cause unverified; do not rely on one run:
- The eval judge failed all votes on t3 replies that a local re-judge with the same prompt passed (`claude -p`, sonnet, haiku and opus).
- The judge varies between runs on the same case: the t1 without arm scored 1.00 in the RED baseline, then 0.30 and 0.60 in later runs.
- The harness warns that llm judges are noisy on long inputs and suggests a regex grader for large artifacts. An "every sentence" llm check over a 6,000-character issue.md failed in almost every with-arm run.

Run one behavioural case (both arms, about 1 to 3 minutes):
`claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --model claude-sonnet-5-5 --judge-model sonnet --case <case> --runs 3 -j 6 --json evals/results/<name>.json`

Model under test (2026-10-12, 12 core cases, one run each, plugin arm only):

| Model | Mean cost per run | Mean score | Mean turns |
|---|---|---|---|
| Opus 5.5 | $0.53 | 0.98 | 11 |
| Sonnet 5.5 | $0.17 | 0.92 | 10 |
| Haiku 5.5 | $0.62 | 0.42 | 12 |

- Use Sonnet 5.5 (`--model claude-sonnet-5-5`) for RED, GREEN and regression runs. Without `--model`, the run uses the session's default model.
- Before a merge, run the changed cases once on Opus 5.5 (`--model claude-opus-5-5`) and record both in the GREEN record.
- Haiku 5.5 lists the plugin's skills but does not call them, even when a request matches a skill description (smoke and t10 traces, 2026-10-12). Its scores measure skill selection, not skill text. A plugin hook could force the call, but it breaks the skills-only rule, so the plugin does not use one.
- Haiku 5.5 calls a skill the prompt names (t22g, 2026-10-13: skill-fired 5/5, counted from the traces) and does not call one it is not told about (t22, t22b, t22c, t22d, t22e, t22j, t22h: 0 of 11 runs). t22h, which names no skill, scored 0.40 on Haiku (skill-fired 0/5).
- This CLI (2.1.287) prints `unrecognized_model` for `claude-haiku-5-5`. That is a warning only: `modelUsage` in `--output-format json` confirms the model ran.
