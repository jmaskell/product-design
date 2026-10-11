# GREEN record: modelling-products and auditing-product-models (2026-10-11)

Compare with `2026-10-11-product-model-red.md`. Sonnet judge, `--ablation with-without`, threshold 0.8, Claude Code 2.1.287. Counts come from the task reports in `.superpowers/sdd/2026-10-11-product-model-skills/`. The result JSON files in `evals/results/` are not in git.

Commits: e55fbfc (modelling-products), f716257 (modelling-products tier fix), 80ff645 (auditing-product-models), 743c27c and cbb3436 (router).

## Scores

| Case | With | Without | Runs | Graders (with arm) | Text the run used |
|---|---|---|---|---|---|
| t16-model-from-code | 1.00 | 0.22 | 3 | all graders 3/3 | f716257 (5-run result on e55fbfc: 1.00 / 0.24) |
| t16b-model-from-interview | 1.00 | 0.27 | 5 | all 6 graders 5/5 | e55fbfc |
| t16c-model-partial | 1.00 | 0.25 | 3 | all graders 3/3 | f716257 (5-run result on e55fbfc: 1.00 / 0.25) |
| t16d-model-exists (GUARD) | 1.00 | 0.80 | 5 | all 3 graders 5/5 | 80ff645; modelling-products text is f716257 |
| t16e-depth-not-given | 1.00 | 0.33 | 5 | recommends-tier 5/5, no-journey-before-depth 5/5 | f716257 |
| t16f-extend-one-job (GUARD) | 0.95 | 0.75 | 5 | job-cited 4/5; the other graders 5/5 | f716257 |
| t17-audit-report (near-guard) | 1.00 | 0.82 | 5 | all 12 graders 5/5 | 80ff645 |
| t17b-audit-rulings | 1.00 | 0.65 | 5 | all 11 graders 5/5 | 80ff645 |

Every case meets the 0.8 threshold in the with arm. Compare the RED record: t16 0.70, t16b 0.56, t16c 0.67, t16e 0.33, t17 0.78, t17b 0.67.

## Guard cases

These cases check that the skill does no harm. They are not RED to GREEN evidence.

- t16d: the skill must not rebuild an existing model. Without the skill, the run already leaves the docs alone (RED 0.89 without).
- t16f: "add one journey" goes to `mapping-journeys`, not to `modelling-products`. The case passed 0.8 before any skill text for it (RED 1.00 with). The skill has no extend mode (ruling R8). The delta comes only from the `Code:` line in `templates/journey.md`.
- t17 is a near-guard. The without arm scores 0.82, above 0.8. The delta comes from `severity-set` and `skill-fired` only.

## Which numbers come from the last text change

- modelling-products last changed in f716257.
  - t16b: I did not re-run it after f716257. The row is from e55fbfc. f716257 changed the no-depth branch and the interview batch line. t16b gives a depth and its answers.
  - t16d: re-run after f716257, in Task 3 on 80ff645. The modelling-products text did not change between f716257 and 80ff645 (Confirmed by `git diff --stat f716257..HEAD -- skills/modelling-products templates`: no output).
  - t16, t16c: re-run after f716257, 3 runs each.
  - t16e, t16f: run on f716257.
- auditing-product-models has one text, 80ff645. t17 and t17b ran on it.
- The router last changed in cbb3436 (the separate sentence for R9).
  - smoke, t10, t11: I did not re-run them after cbb3436. They ran on 743c27c with the trimmed router. The cbb3436 change is in section 4 only.
  - t8-no-model, t8b: re-run on cbb3436.
- README and `templates/journey.md` changes are older than the last skill text. No case reads the README.
- The t16 and t16c 5-run scores are older text than the 3-run scores in the table. Both pairs pass.

## Router regression (Task 4)

Router: `skills/designing-products/SKILL.md`, now 400 of 400 words. 3 runs per arm unless stated.

| Case | With | Without | Failing graders (with arm) | Text |
|---|---|---|---|---|
| smoke | 1.00 | 0.00 | none | 743c27c |
| t8-no-model | 1.00 | 0.00 | none | cbb3436 (also 1.00 on 743c27c; without arm from 743c27c) |
| t8b-partial-model | 1.00 (5 runs) | not re-run | none; uses-product-md 5/5 | cbb3436 |
| t10-stops-at-g1 | 0.83 | 0.00 | no-design-before-g1, 1 run | 743c27c |
| t11-ratchet | 0.83 | 0.50 | tier-goes-up, 1 run | 743c27c |

### R9 history for t8b

- The brief wording put the offer in the "With nothing" sentence. t8b scored 1,0,0 and 0,1,0 over two sets. The runs said "no product model yet" while PRODUCT.md existed. That fails `uses-product-md`.
- Baseline on the HEAD router, before the change: 1,1,1. The router change caused the fall.
- First fix, "if PRODUCT.md is missing" inside the same sentence: 1,0,1; then 1,1,1,1; then 1,1,0 (official, 0.67); then 1,1,1,1,1,0. Pooled 13 of 16 (0.81). The offer in that sentence still made some runs say the model is absent.
- Ruling R9 and fix: put the offer in its own conditional sentence: "If PRODUCT.md does not exist, also offer product-design:modelling-products." t8b scored 1.00 over 5 runs (cbb3436). The router offer stays.
- The t10 and t11 failures are one run each. Unverified: I did not read those traces. The without arm of t10 scores 0.00, and that of t11 scores 0.50.

## What the skills add over the base model

All points come from the without-arm failures in the table above.

### modelling-products

- Four actor kinds in `actors.md` (the without arm scored 0/5 on actor-kinds in t16, t16b, t16c).
- Job IDs, a letter and a number (0/5 on job-ids in t16b).
- The template relationship verbs (0/5 on relationship-verbs in t16).
- `INFERRED (from <path>)` tags on entries read from code (0/5 on inferred-from-code in t16).
- `KNOWN (owner, <date>)` tags on interview answers (0/5 on owner-source in t16b).
- The depth the owner gave, held (0/5 on depth-held in t16).
- One recommended tier when the owner gives no depth, with no journey written before the owner agrees (0/5 on recommends-tier in t16e).
- The `actors.md` path itself. The without arm writes other file names (for example `journeys.md`, `rules.md`). Those graders partly measure a path that only the skill names.
- The skill does not add the price-threshold question. The without arm asks it as well (threshold-question 5/5 in both arms).

### auditing-product-models

Base Claude already finds the seeded faults: the threshold drift, the chase-landlord gap, the stale anchor and the Close phantom (t17 without arm 5/5 on each). The skill adds convention and rulings handling.

- The plugin severity set CRITICAL, SIGNIFICANT, MINOR (severity-set 0/5 without).
- A likely-intended read that cites the commit (RED: failed in 2 of 3 with-arm runs; the without arm passes in GREEN).
- The `verified:` line updated after a "code is right" ruling (0/5 without).
- An `UNKNOWN` Open unknown with the finding ID after a "model is right" ruling (0/5 without).
- The old value replaced everywhere in the model (old-threshold-gone 0/5 without).
- No edit to product code after a "docs are right" ruling. The without arm edited a file under `src/` in 2 of 3 RED runs. In GREEN, no-code-edit scores 4/5 without. Confirmed by a grep of the 10 with-arm traces: no `sed -i`, `perl -pi` or redirect to `src/`.

## Gaps and concerns

- `skill-fired` passes 5/5 in the with arm for t16, t16b, t16c, t16e, t17 and t17b. t16d has no such grader. In t16f, `mapping-journeys` fires. `skill-fired` has weight 1 (ruling R4).
- The interview batch line in modelling-products has no case. The harness cannot answer questions.
- The t16f job-cited failure (4/5): Unverified: I did not read that trace.
- The no-write graders can miss a Bash heredoc or `sed -i` (deferred from Task 1). I did not test that path.
- Deferred minors: the modelling-products mode row offers "ask which job to add" with no extend mode; the "Unruled contradiction" line says "list it" without `UNKNOWN`; the router has two `-ing` forms.
