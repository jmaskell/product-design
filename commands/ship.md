---
name: ship
description: Slim ship workflow. Syncs the base branch, runs the project's verification suite, one code-review pass with fixes, an adversarial second opinion, a conditional security review, a plan-completion check, and targeted doc touch-ups, then pushes and opens the PR. Run only after the product owner confirms the work is reviewed/QA'd.
tools: Bash, Read, Grep, Glob, Edit, Write, Skill
model: opus
---

You are running `/ship`. It takes a finished, reviewed feature branch to an open PR with exactly the review depth most projects need pre-release: a green verification suite, one correctness review, one adversarial second opinion, and a security pass when the diff warrants it.

**If the project defines its own ship command** (check `CLAUDE.md` — e.g. a project-local `/ship-lite` with project-specific gates), defer to it and stop — do not run both.

## Step 1: Guard

```bash
git branch --show-current
git status --porcelain
```

- If on the default branch, STOP — this runs on a feature branch.
- If the working tree has uncommitted changes, commit intentional work first. If there are changes you don't recognise, STOP and show the user.
- **Approval gate:** this command only runs on an explicit product-owner instruction given AFTER they confirmed the work (manual QA where the project requires it). If you reached it as an autonomous continuation of a build, STOP and end the turn instead.

## Step 2: Sync base

```bash
git fetch origin
git merge origin/<default-branch>
```

Resolve trivial conflicts (imports, adjacent additions, lockfile) yourself. If a conflict touches core business logic, data migrations, or security-sensitive code, STOP and show the user the conflicting hunks before resolving.

## Step 3: Verification suite

Determine the project's verification commands, in order of preference: a `Verify:` line in the Project metadata section of `CLAUDE.md`; otherwise infer from the toolchain (e.g. `npm test` + `npx tsc --noEmit` + `npm run lint`, or `make test`, `cargo test && cargo clippy`, `pytest && ruff check`). Also run any ratchet scripts the metadata lists (size budgets, drift counters, plan-board checks).

All must pass before any review step. Fix failures at the cause; never weaken a test to get to green.

## Step 4: Code review (correctness + quality)

If the built-in `/code-review` skill is available, invoke it at **medium** effort with `--fix`. Otherwise perform one disciplined self-review pass over the branch diff for correctness bugs and reuse/simplification cleanups.

After fixes: re-run tests + typecheck, then commit the fixes (atomic commits, one concern per commit). If a proposed fix would change behaviour the product owner already reviewed, surface it instead of applying it.

## Step 5: Adversarial second opinion

If a second-model CLI is available (e.g. `codex`), run an independent adversarial review scoped to the branch diff:

```bash
BASE=$(git merge-base HEAD origin/<default-branch>)
codex exec --sandbox read-only "You are an adversarial code reviewer. Review the diff produced by: git diff $BASE..HEAD. Actively try to break it: real bugs, unhandled edge cases, race conditions, security issues — missing authorization scoping, data leaking across tenants/users, injection, unsafe migrations. Report each finding as severity, file:line, what breaks, and a concrete scenario. No style nits. If you find nothing real, say so plainly."
```

For large or high-stakes diffs, run two or three passes in parallel with distinct lenses (correctness & data integrity / authorization & tenancy / domain-specific invariants) instead of one general pass — diverse lenses catch what redundant ones miss. Merge and dedupe before triage.

Triage the findings yourself — the second opinion is not an authority:
- **Real** → fix, re-verify, commit atomically.
- **False positive / not worth it** → record the finding and a one-line dismissal reason for the PR body. Don't silently drop findings.
- **Disputed** → settle it empirically: reproduce it, write the failing test, or trace the concrete scenario. Never dismiss on judgement alone; never accept on authority.

If the CLI is missing, warn the user loudly, continue, and note "adversarial review skipped" in the PR body — never pretend it ran.

## Step 6: Security review (conditional)

If the diff touches auth, permissions, data-access layers, server actions/endpoints, or migrations: run the built-in `/security-review` skill if available (otherwise do a focused pass over those hunks yourself). Triage and fix mechanical findings; STOP for the product owner only when a finding genuinely needs their decision. Otherwise note "security review not triggered" and move on.

## Step 7: Plan completion check

If the branch has an implementation plan, read its steps and check each one actually landed in the diff. This is a checklist pass, not another review. A step missing with no explanation → STOP and tell the user which one — missed build steps are a classic failure mode; this check is the guard.

## Step 8: Targeted docs touch-up

Only if the change added/moved a module, route, or documented pattern: update the affected entries in `CLAUDE.md` and the project's reference docs. Scope is "what this diff made stale" — never a general documentation sweep.

## Step 9: Status flip

Per the project's tracker (see Project metadata): `none` → set the issue file's status to in-review and commit; `linear`/`github` → update the tracker status/label.

## Step 10: Push and PR

```bash
git push -u origin $(git branch --show-current)
gh pr create --title "<type>(<issue-id>): <title>" --body "..."
```

PR body, concise: **Summary** (what changed and why, link to the plan) · **Review trail** (one line each: suite / code-review / adversarial / security — ran or skipped + why) · **Dismissed findings** (each with its one-line reason) · **QA** (what the product owner confirmed before this ran).

Output the PR URL.

## Rules

- **Order is fixed.** Verification suite green → reviews → PR. Never open the PR with a failing suite or an untriaged finding.
- **Every fix is verified and atomic.** Tests + typecheck after each fix batch; one concern per commit.
- **Reviews are scoped to the diff.** Don't expand into refactoring the surrounding code.
- **Feature branch only.** Never run on the default branch.
- **No ceremony the project didn't ask for.** No version bumps, changelogs, or docs sweeps unless the project's conventions require them.
