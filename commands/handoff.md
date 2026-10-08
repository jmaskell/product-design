---
name: handoff
description: Generate a paste-ready kickoff prompt for a fresh session at a workflow phase boundary. Detects the current phase from branch, plan artifacts, .tracker.md, and git state, verifies the handoff artifact is on disk, and prints the exact prompt to paste after /clear. Use at the natural clear points — before /architect, before Build, or mid-build — when you want to drop the previous phase's deliberation and start the next phase lean.
tools: Bash, Read
model: sonnet
---

You are running `/handoff`. Its job: at a workflow phase boundary, produce a **paste-ready kickoff prompt** for the next session so the product owner can `/clear` and start the next phase with a clean context — free of the previous phase's deliberation.

You do **not** clear the session yourself (`/clear` is a native CLI command, not yours to call) and you make **no changes** to any file. This command is read-only. Its only output is the detected phase, a short safety check, and the prompt to paste.

Why this is safe: the workflow hands off through files. Plan artifacts travel with the branch, `.tracker.md` survives context compaction, and the issue is the source of truth. The next phase re-reads those artifacts from disk — it does not need the conversation. Clearing at a boundary drops noise, not signal. Your job is to confirm the artifact is on disk before the owner clears, and to hand them the right next prompt.

## Step 1: Inspect state

Read the Project metadata section in `CLAUDE.md` for the plan directory and tracker mode, then run (batched):

```bash
git branch --show-current
ls <plan-dir> 2>/dev/null
git status --short
git log --oneline -6
[ -f .tracker.md ] && echo "TRACKER PRESENT" || echo "no tracker"
```

If `.tracker.md` exists, read it.

## Step 2: Derive the issue ID and tier

**Issue ID** — derive from, in order of preference:
1. Plan artifacts touched on this branch (`git log --name-only --diff-filter=AM <base>..HEAD -- '<plan-dir>' | head`). Under `Tracker: none` these live in a per-issue folder (`<plan-dir>/<n>-<slug>/`); under linear/github they are flat files (`<plan-dir>/<id>-ux.md`, `<id>-plan.md`).
2. The branch name (normalise per the project's ID convention, including any historical ID aliases the metadata documents).

If you can't find an issue ID, say so and stop — there's nothing to hand off.

**Tier** — prefer an explicit `tier` field in the issue's frontmatter. If unset, infer from artifact presence: UX spec **and** plan → **full**; plan only → **medium**; neither → small tier or pre-UX (see "no handoff point" below).

## Step 3: Determine the phase and the next prompt

Decide in this priority order:

**C — Mid-build resume.** `.tracker.md` exists and has at least one row that is not `done`.
→ Next prompt:
```
Resume building <issue-id>. Read .tracker.md for the current step, then the plan (and UX spec if present) for full step detail. Continue from the first non-done step using test-first development. Set the issue status to in-progress only if it isn't already.
```

**B — Before Build.** The plan exists and is committed, and there is no `.tracker.md` (or every tracker row is `done` from a prior, unrelated build). This is the highest-value clear point — the planning + plan-review conversation is the longest and least relevant to building.
→ Next prompt (fill in the tier from Step 2):
```
Build <issue-id> [tier]
```

**A — Before `/architect`.** The UX spec exists and is committed, and the plan does **not** exist yet.
→ Next prompt:
```
/architect <issue-id>
```

**No handoff point.** No plan artifacts and no tracker → small-tier work runs in one session; there's nothing to hand off. Say so plainly and stop. Do not invent a prompt.

## Step 4: Safety check before clearing

The fresh session reads the handoff artifact from disk, so it must exist there. Check and report:

- **Artifact on disk?** The relevant file for the detected phase (UX spec, plan, or `.tracker.md`) exists. If not → **STOP**, do not emit a clear prompt; the context only lives in this conversation and would be lost. Tell the owner to write/commit it first.
- **Committed?** If the handoff artifact shows in `git status` as modified/untracked, warn (⚠) that it isn't committed yet. It will still persist on disk across `/clear`, but the workflow keeps plan artifacts committed to the branch — recommend committing first. Not a hard stop.
- **Unwritten decisions.** Remind the owner once, plainly: anything decided in this conversation but **not** captured in the issue, the plan artifacts, or `.tracker.md` will be lost on clear. If important context is only in the chat, write it down before clearing.

Best-effort, optional: read the issue's title to show in the human-facing preamble (so the owner can confirm they're handing off the right issue). Skip silently if unavailable. **Never** put the title or any conversation context into the paste block — that defeats the purpose of clearing.

## Step 5: Output

Print, in this order:

1. One line: detected phase (A/B/C), issue ID, tier, and — if read — the issue title.
2. The safety check results (✓ / ⚠ / STOP).
3. The paste-ready prompt in its own fenced block, **minimal** — exactly what's specified above with `<issue-id>`/`[tier]` filled in. No extra context, no summary, no preamble inside the block.
4. A final instruction: "Run `/clear`, then paste the prompt above."

## Rules

- **Read-only.** Never edit, write, or commit. Never run `/clear`.
- **Minimal prompts.** The paste block carries no conversation context — the fresh session reads the artifact itself. Padding it defeats the point of clearing.
- **Artifact must be on disk.** If the handoff artifact isn't written, STOP — clearing would lose it.
- **Don't hand off mid-unit.** A/B/C are the only clear points. There is deliberately no handoff between Build → QA → ship; that's one continuous unit on the live tree. If state looks like that span (tracker all done, uncommitted code changes, no new plan), say the session should stay intact through ship.
