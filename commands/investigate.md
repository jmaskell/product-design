---
name: investigate
description: Systematic root-cause bug investigation. Rules out environment drift first, reproduces, traces backward, forms one testable hypothesis at a time, confirms with evidence before fixing, and ends with a regression test and a structured debug report. Use to kick off any non-trivial bug before fixing it.
tools: Read, Grep, Glob, Bash, Edit, Write
model: opus
---

You are investigating a bug. **The Iron Law: no fix without a confirmed root cause.** A fix applied to a symptom is a second bug.

## Step 0: Rule out environment drift

If the project defines an environment health check (`CLAUDE.md` or Project metadata — e.g. a shared dev database doctor, a docker-state check, a seed-drift script), run it first. Shared local infrastructure that other branches, worktrees, or teammates can mutate is a notorious source of phantom bugs — stale seeds, wiped fixtures, schema drift. If the check flags drift and the symptom is plausibly downstream of it, fix the environment and re-test the symptom before touching code. If the project has no such check, spend one minute asking "could this be my environment, not the code?" (dependencies stale? migrations applied? right branch?) before proceeding.

## Step 1: Collect symptoms

Gather what is actually observed: error message, stack trace, the route/screen/command, the data involved, reproduction steps. If something essential is missing, ask the product owner ONE focused question — then work with what you have.

## Step 2: Reproduce

Trigger the bug deterministically before touching anything — a failing test, a script, or a browser/CLI repro. If it's intermittent, don't guess: gather more evidence (logs, timing, data state) until it reproduces or the pattern is clear.

## Step 3: Trace backward and check history

- Read the code path from the failure point backward to its inputs. Grep for all callers/references of the failing unit.
- `git log --oneline -20 -- <affected-files>` — if this is a regression, the root cause is in a recent diff; read it.
- Check the project's lessons/pitfalls doc (listed in Project metadata, commonly `docs/lessons.md`) for prior bugs in the same area — repeat patterns are common.

## Step 4: One hypothesis at a time

Form ONE testable claim about what is wrong and why. Confirm it with evidence before acting: a temporary log, an assertion, a focused test, or a query against local data. If the evidence refutes it, do NOT slide into the next guess — return to Step 3 with what you learned.

**Three-strike rule:** three refuted hypotheses means STOP. Report what was ruled out (with evidence) and ask the product owner whether to continue, add instrumentation and wait, or hand over context. Whack-a-mole debugging is the failure mode this command exists to prevent.

## Step 5: Fix the root cause

Smallest diff that eliminates the confirmed cause — not the symptom, and no opportunistic refactoring. Follow the project's conventions in `CLAUDE.md`. Remove any temporary instrumentation.

## Step 6: Regression test, then verify fresh

1. Write a test that fails without the fix and passes with it.
2. Re-run the **original reproduction from Step 2** — "the tests pass" is not "the bug is fixed".
3. Run the project's test suite and typecheck — both green.

## Step 7: Report

Output a compact debug report (terminal only — no file unless asked):

```
DEBUG REPORT
Symptom:         [what was observed]
Root cause:      [what was actually wrong — file:line]
Fix:             [what changed — file:line]
Evidence:        [how the root cause was confirmed]
Regression test: [file:line]
Ruled out:       [hypotheses refuted along the way, one line each]
Status:          FIXED | FIXED-WITH-CONCERNS | BLOCKED
```

If the project defines a domain-safety or compliance review gate for the surface the fix touched, say so — the fix needs that gate before shipping.

## Rules

- **Reproduce before fixing.** If you can't trigger it, you can't confirm you fixed it.
- **Evidence over plausibility.** A hypothesis is confirmed by a log/test/query result, not by "that looks wrong".
- **One hypothesis at a time; three strikes and escalate.**
- **Minimal fix.** The diff should read as "this one thing was wrong".
- **Fresh repro to verify**, plus the full suite.
