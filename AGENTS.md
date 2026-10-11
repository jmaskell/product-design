# product-design plugin

Skills-only Claude Code plugin. The skills are in `skills/`, shared text in `references/` and `templates/`, eval cases in `evals/`.

Every change to `skills/`, `references/`, `templates/`, `evals/` or `scripts/` updates `README.md` in the same commit when the README describes it.

Run the three check scripts before you commit:

- `bash scripts/check-portability.sh`
- `bash scripts/check-skill-size.sh`
- `bash scripts/check-readme.sh`

## Adding or changing a skill

Every new skill, and every behaviour change to a skill, follows this process. It is test-driven: no skill text without a failing eval first. Harness facts and grader shapes are in `evals/README.md`.

1. **Decide with the owner.** Batch the open decisions into one question, recommendation first. Read the core spec and the existing skills first, so the new skill reuses the product model, templates, evidence tags and severities.
2. **Spec.** Write `docs/superpowers/specs/<date>-<name>-design.md`: outcome, what exists, scope, owner decisions, skill shape, eval cases, open points. The owner approves it before the plan.
3. **Plan.** Use superpowers:writing-plans. Write `docs/superpowers/plans/<date>-<name>.md` with Global Constraints, a Review Focus list (each risk pinned to an eval case or grader), and Task 1 = the RED cases.
4. **RED.** Write the cases in `evals/cases/tNN-<slug>/` and any fixture in `evals/fixtures/`. Run each case, both arms. Record `evals/baselines/<date>-<name>-red.md`: scores per case and arm, the failing graders, and why each fails. Commit. If the without arm already passes 0.8, the case teaches nothing. Tighten it or drop it.
5. **GREEN.** Write only the skill text that answers a recorded failure. Run the three check scripts. Run each case, 5 runs, until the with arm scores 0.8 or more and beats the without arm. One commit per task, with the README change in the same commit.
6. **Execute.** Use superpowers:subagent-driven-development. Keep briefs, reports and review diffs in `.superpowers/sdd/<date>-<name>/`. Review each task, then fix in waves.
7. **Regression.** When a change touches a skill that other cases cover (the router especially), re-run those cases.
8. **GREEN record.** Write `evals/baselines/<date>-<name>-green.md`: with and without scores, run counts, the text each number came from, and every case not re-run after the last text change.

`docs/superpowers/`, `.superpowers/` and `evals/results/` are gitignored. The baselines in `evals/baselines/` are the committed record.

Lessons from earlier rounds:
- Pair every file grader with a check the without arm can pass or fail on its merits. A grader on a path only the skill names measures the path, not the behaviour.
- Judge named rows or sections, phrased "PASS when …". Whole-file llm judging of long files is noisy.
- Compare with and without inside one run. The judge varies between runs.
- Every skill line answers a recorded RED or with-arm failure. Do not copy a case prompt's wording into a skill. Delete lines that answer no failure.
