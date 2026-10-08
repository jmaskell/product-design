# Claude Code product workflow

A Claude Code plugin that turns a vague product idea into a shipped feature, one step at a time. It has two parts:

- **Six product-design skills.** They frame the problem, map the journey, design the interaction and get an independent critique before any engineering starts. They load on their own when you ask Claude to design, define, shape or scope a feature.
- **Eight slash commands.** You run them by name for the steps around the design: define an issue, plan the build, hand off between sessions, investigate a bug, check copy, ship.

The skills and the commands share one pattern. They read the project conventions from `CLAUDE.md`, deliberate before they produce, and write artifacts to disk for review rather than dumping output into the terminal.

## Install

```bash
claude plugin marketplace add jmaskell/product-design
claude plugin install product-design@claude-product-workflow
```

The skills then load in every repo. The plugin gives the commands as `/product-design:<command>`, for example `/product-design:architect`.

To try a local checkout for one session only:

```bash
claude --plugin-dir /path/to/product-design
```

### Commands only, without the plugin

```bash
git clone https://github.com/jmaskell/product-design.git
cd product-design
./install-symlink.sh   # live updates from `git pull`
# or
./install-copy.sh      # frozen at install time
```

This puts the commands in `~/.claude/commands/` as `/define-issue`, `/architect` and so on. It installs no skills. To uninstall, delete the files from `~/.claude/commands/`.

## The skills

| Skill | Starts when |
|---|---|
| `designing-products` | You ask to design, define, shape or scope a feature, or say "design this properly". This is the router. It sizes the work as Small, Medium or Large and runs the other skills in order. |
| `framing-problems` | A request arrives as a solution ("add a button"), or the user outcome is unstated. |
| `mapping-journeys` | A change touches more than one actor or a hand-off, or risks moving work from one person to another. |
| `designing-interactions` | The problem and task flow are agreed, and the screens, states or mocks are next. |
| `reviewing-product-design` | A design is drafted. Fresh agents critique it, one lens each (usability, accessibility, journey, domain risk), before the owner approves. |
| `filing-issues` | An approved design must go to the tracker or a plan folder. |

Two gates hold the owner in the loop. **G1** asks "is this the right problem?" and, for Large work, stops until you answer. **G2** asks "is this the right design?" and shows the mocks, the decisions and any finding that needs your ruling.

Project rules win. If your `CLAUDE.md` or `AGENTS.md` names another skill for a step (for example `superpowers:brainstorming` for specs), Claude follows your rule. To use the router in that project, change the rule or name the skill in your prompt: "Use product-design:designing-products to design …".

## The commands

### `/define-issue [brief description]`

**What it does:** Turns a half-formed idea into a tight, well-scoped tracker issue (or a multi-issue project). Interviews you, explores the codebase to fill in technical context, drafts to a file, iterates until you approve, then posts to the tracker.

**Use it when:**
- You have a feature idea but it's not crisp enough to hand to a designer or engineer
- You want to push back on vague problem statements before they become wasted build time
- You're starting a chunk of work that might be one issue or several — the command flags when scope warrants splitting

**Output:** A draft file under your plan directory, then (on approval) issues created in Linear / GitHub / locally.

---

### `/ux-designer <issue-id>`

**What it does:** Reads a feature issue and produces a detailed UX specification — interaction states, ASCII wireframes, flow descriptions, accessibility verification, interaction test plan. Explores multiple approaches before converging when complexity warrants it.

**Use it when:**
- You've defined an issue and need a design before anyone writes code
- The feature has UI changes and you want to catch interaction gaps, missing states, and accessibility issues at the design stage rather than mid-build
- You want a designer who reuses existing patterns by default and only proposes new ones when nothing in the codebase fits

**Output:** A UX spec at `<plan-dir>/<issue-id>-ux.md`, committed to the current branch.

---

### `/architect <issue-id>`

**What it does:** Reads an issue and its UX spec, then produces a concrete implementation plan — file-by-file changes, decomposed steps with tests-first guidance, data flow / state diagrams, migration risk classifications, failure-mode tables, standalone test plan. Explores multiple technical approaches before converging when complexity warrants it.

**Use it when:**
- The UX is settled and you need a build plan grounded in the actual codebase
- You want to surface schema, migration, and API trade-offs before someone starts writing code
- You want every step to lead with the failing tests to write, so the builder can do TDD

**Output:** An implementation plan at `<plan-dir>/<issue-id>-plan.md`, committed to the current branch.

---

### `/accessibility-check <file, route or plan folder>`

**What it does:** Runs the accessibility lens of the `product-design:reviewing-product-design` skill on one file, route or plan folder. One fresh agent checks it against WCAG 2.2 AA and the persona spectrum. Each finding has a severity: CRITICAL, SIGNIFICANT, MINOR or UNKNOWN.

**Use it when:**
- You want an accessibility check on one screen, component, route or design before you merge it
- You want findings that separate "this blocks a person" from "this is polish"

**Output:** The findings, in the terminal. The command writes no file.

---

### `/handoff`

**What it does:** At a workflow phase boundary, detects the current phase from the branch, plan artifacts, `.tracker.md`, and git state, verifies the handoff artifact is committed to disk, and prints a minimal paste-ready kickoff prompt for a fresh session. You run `/clear` and paste — the next phase starts lean, free of the previous phase's deliberation.

**Use it when:**
- The plan is approved and you're about to build — the single biggest context win
- The UX spec is approved and you're about to run `/architect`
- A build session has grown long and you want to resume from `.tracker.md` in a clean session

**Output:** Terminal only — the detected phase, a safety check (is the artifact on disk and committed?), and the exact prompt to paste.

---

### `/investigate <bug description>`

**What it does:** Systematic root-cause bug investigation. Rules out environment drift first, reproduces deterministically, traces backward through code and git history, then tests one hypothesis at a time with evidence — three refuted hypotheses and it stops and escalates rather than whack-a-moling. Ends with the minimal fix, a regression test, a fresh re-run of the original repro, and a structured debug report.

**Use it when:**
- Any non-trivial bug, before anyone proposes a fix
- A "fix" already bounced once — symptom-patching is exactly what this prevents

**Output:** The fix + regression test on the working tree, and a compact `DEBUG REPORT` in the terminal (symptom / root cause / evidence / ruled out).

---

### `/copy-check`

**What it does:** Extracts every user-facing string the branch diff added, judges each against the project's copy rules plus a baseline (name the thing, give the action, stop; no provenance captions; no defensive hedging), rewrites violations in place, and reports before→after. Feeds reviewer refinements back into a per-project copy-examples file so the same over-writing isn't repeated.

**Use it when:**
- A build is finishing and the diff touches UI text, empty states, errors, emails — run it before handing over for review
- Reviewers keep trimming rationale clauses and disclaimers out of your copy

**Output:** In-place edits committed as one `polish:` commit, plus a verdict table in the terminal.

---

### `/ship`

**What it does:** Takes a finished, reviewed feature branch to an open PR: syncs the base branch, runs the project's verification suite and ratchet scripts, one code-review pass with fixes, an adversarial second opinion from a different model (multi-lens for high-stakes diffs), a conditional security review, a plan-completion check against the implementation plan, targeted doc touch-ups, status flip, push, PR. Disputed findings are settled empirically — repro or failing test, never one model taking another's word.

**Use it when:**
- The product owner has confirmed the work (including manual QA where the project requires it) and it's time to open the PR
- You want every PR to carry a review trail: what ran, what was found, what was dismissed and why

**Output:** An open PR with a concise summary, review trail, and dismissed-findings list. (Defers automatically to a project-local ship command if the project defines one.)

## How they fit together

```
/define-issue        ──→  Issue in tracker
       │
       ▼
/ux-designer ID      ──→  <id>-ux.md           (calls /accessibility-check internally)
       │
       ▼   ← /handoff → /clear (fresh session)
/architect ID        ──→  <id>-plan.md
       │
       ▼   ← /handoff → /clear (fresh session — the biggest context win)
[builder works against the plan]                (/investigate for bugs, /copy-check at build end)
       │
       ▼
/ship                ──→  Open PR with review trail
```

Each command stops after producing its artifact. None of them auto-advance the workflow — that's deliberate, so you stay in the loop between stages. The `/handoff` clear points work because every stage reads its inputs from committed files, not from the conversation.

## Adopting in a project

Add this section to your project's `CLAUDE.md`. The commands read it on every run.

```markdown
## Project metadata

- Tracker: linear            # linear | github | none
- Tracker team: ENG          # only used when Tracker = linear (the issue ID prefix)
- Plan directory: docs/plans/
- Reference docs: docs/architecture.md, docs/lessons.md, docs/reference/
- Branch prefix: yourname/
- Status workflow: UX → Architect → In Progress → In Review → Done
- Domain: short sentence describing the product and its users
```

If the section is missing, the commands prompt for the values they need and offer to append.

The skills also read these, when present:

- `PRODUCT.md` at the repo root: the product, its users and any sensitive-domain flag. A sensitive domain raises the work to Large. PRODUCT.md alone is enough to start.
- `Tier triggers` in the project metadata: extra predicates that raise the size.
- `Domain rules` in the project metadata: the file the domain-risk reviewer checks against.
- `docs/product/actors.md` and `docs/product/journeys/`: the saved actor list and journeys. Templates are in `templates/`.

The commands also pick up project-specific lessons (recurring accessibility traps, feasibility gotchas, build pitfalls) from `docs/lessons.md` if it exists. Curate that file over time and the commands get smarter about your project automatically.

## Tracker behaviour

| Tracker | Fetch | Status updates | Posting |
|---------|-------|---------------|---------|
| `linear` | `mcp__linear` | `save_issue` with the workflow's state name | only when explicitly approved |
| `github` | `gh issue view` | label changes via `gh issue edit` | only when explicitly approved |
| `none` | reads `<plan-dir>/<id>.md` if present, else prompts you | skipped | n/a |

For `linear`, install Linear's MCP server. For `github`, install the [`gh` CLI](https://cli.github.com).

## Per-project overrides

Claude Code prefers project commands (`<repo>/.claude/commands/`) over global ones (`~/.claude/commands/`). To customise a command for a specific project, copy the file into the project and edit it there. The global version stays untouched.

## Philosophy

These commands embody a few opinions:
- **Deliberation over speed.** For anything beyond trivial work, the design and architecture commands explore multiple approaches and ask you to pick one before producing the full artifact.
- **Files over chat.** Every artifact is written to disk and reviewed in your editor. Terminal output stays terse — file path, summary, open questions.
- **Tests-first guidance.** Every implementation step in the architect's plan leads with the tests to write before the code.
- **Reuse before invention.** Commands prefer extending existing patterns over introducing new ones, and flag explicitly when they don't.
- **Tracker-pluggable.** Use Linear, GitHub Issues, or local files. The workflow stays the same.
- **Structure over judgement.** Where a single model's judgement is the weak link — plan review, finding triage, screenshot verdicts — the commands use independent lenses, cross-model second opinions, and empirical reconciliation (repro or failing test, never one model taking another's word).
- **Fresh contexts beat long ones.** Every stage reads committed artifacts, so `/handoff` + `/clear` at phase boundaries drops deliberation noise without losing signal — and mid-session compaction stops being a failure mode.

## Developing the plugin

```bash
bash scripts/check-portability.sh   # skill text names no domain, stack or project
bash scripts/check-skill-size.sh    # each SKILL.md stays inside its word budget
```

To ban your own project names as well, list them in a `.portability-banned` file at the repo root, one regex per line. Git ignores that file.

`evals/` holds 16 eval cases for `claude plugin eval`. Each case runs with and without the plugin. See `evals/README.md` for how to run them, and `evals/baselines/` for the recorded results.
