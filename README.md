# Product design for Claude Code

A Claude Code plugin that makes Claude do product design before engineering starts. It frames the problem, maps the journey, designs the interaction and gets an independent critique, then files the approved work for the build. You stay in the loop at two gates.

## Install

```bash
claude plugin marketplace add jmaskell/product-design
claude plugin install product-design@claude-product-workflow
```

The skills then load in every repo. To try a local checkout for one session only:

```bash
claude --plugin-dir /path/to/product-design
```

## How it works

Ask Claude to design, define, shape or scope a feature, or say "design this properly". The router skill sizes the work and runs the other skills in order.

```
"Design this…" ─► designing-products: Small, Medium or Large
     │
     ├─ framing-problems ─► mapping-journeys ─► G1: right problem?
     │                                          └──► sharing-designs (team comments)
     │
     ├─ designing-interactions ─► reviewing-product-design ─► G2: right design?
     │                                                        └──► sharing-designs (team comments)
     │
     └─ filing-issues ─► tracker or plan folder ─► engineering
```

- **G1 (right problem?)** shows the outcome, the journey, the evidence and the questions for your domain expert. Large work stops here until you answer. Medium work shows G1 in one message and goes on.
- **G2 (right design?)** shows the mocks, the decisions, the dismissed findings and any tension that needs your ruling. A CRITICAL finding blocks approval until it is fixed or you accept it with a reason.
- **Small** work frames in three lines, makes one mock or none, and skips G1 and the review agents. **Medium** work gets two design options. **Large** work gets three options and a fuller review.
- Medium and Large work offers a review page at each gate, so your team can comment.
- The router raises the size, never lowers it, when it finds a trigger later. It says so each time.
- After G2, engineering edits the product code. The skills do not.

## The skills

| Skill | Starts when |
|---|---|
| `designing-products` | You ask to design, define, shape or scope a feature. This is the router. |
| `framing-problems` | A request arrives as a solution ("add a button"), or the user outcome is unstated. |
| `mapping-journeys` | A change touches more than one actor or a hand-off, or risks moving work from one person to another. |
| `designing-interactions` | The problem and task flow are agreed, and the screens, states or mocks are next. |
| `reviewing-product-design` | A design is drafted. Fresh agents critique it, one lens each (task walkthrough, service, usability, accessibility, cognitive load, domain risk). The size and the risk pick the lenses. |
| `sharing-designs` | A design is at a gate and the team must review it, or you ask to share a design or check its comments. |
| `filing-issues` | An approved design must go to the tracker or a plan folder, work must split into several issues, or a bug skips design. |

Every claim about people carries an evidence label: `KNOWN (source)`, `INFERRED (from what)`, `ASSUMED` or `UNKNOWN`. Every finding has a severity: CRITICAL, SIGNIFICANT, MINOR or UNKNOWN.

## Sharing for review

Set `Review space` to a Notion database or to `artifact`. The skill rebuilds the review page from the plan files. In Notion, each reviewer with an open question is tagged and notified, from the people list in `docs/product/people.md`. Comments come back on the next run. They land in decisions.md, in journey.md, or as findings. A comment never approves a gate.

## Adopting in a project

The skills work with nothing set up: they frame from the code and your answers, then offer to save what they mapped. They do better with these files.

**Project metadata**, in `CLAUDE.md` or `AGENTS.md`:

```markdown
## Project metadata

- Tracker: none                 # none | linear | github
- Plan directory: docs/plans/
- Component source: none        # a gallery route, a registry URL, or none
- Tier triggers: payment or health data → Large
- Domain rules: docs/domain-rules.md
- Review space: notion <database URL>     # or: artifact
```

| Key | Used by |
|---|---|
| `Tracker` | filing-issues: where approved work goes (`none`, `linear` or `github`). With `linear`, it needs Linear's MCP server. With `github`, it needs the `gh` CLI. |
| `Plan directory` | framing-problems, mapping-journeys, designing-interactions, filing-issues: where `issue.md`, `journey.md`, `design.md`, `decisions.md` and `mocks/` go. The default is `docs/plans/<slug>/`. With `Tracker: none`, filing-issues numbers the folders and the merged folder is the tracker. |
| `Component source` | designing-interactions: what the mocks are built from. |
| `Tier triggers` | designing-products: extra predicates that raise the size. |
| `Domain rules` | reviewing-product-design: the file the domain-risk reviewer checks against. |
| `Review space` | sharing-designs: where the review page goes — a Notion database or a Claude artifact; unset uses an artifact if available, else a local review.html. |

**Product files:**

- `PRODUCT.md` at the repo root: the product, its users, and any sensitive-domain flag. A sensitive domain raises the work to Large. PRODUCT.md alone is enough to start.
- `docs/product/actors.md` and `docs/product/journeys/`: the saved actors and journeys. The skills write these files from `templates/`: `actors.md`, `journey.md`, `issue.md`, `design.md` and `decisions.md`. sharing-designs builds the team review page from `templates/review-page.md`, publishes it with `skills/sharing-designs/artifact.md`, and triages the comments with `skills/sharing-designs/triage.md`.
- `docs/product/people.md`: names, roles and Notion user IDs for tagging reviewers; no email addresses. The skill writes it from `templates/people.md`.

**Project rules win.** If your `CLAUDE.md` or `AGENTS.md` names another skill for a step (for example `superpowers:brainstorming` for specs), Claude follows your rule. To use the router there, change the rule or name the skill in your prompt: "Use product-design:designing-products to design …".

## Philosophy

- **Problem before screens.** No mock until the outcome, the evidence and the journey are written. Small work writes the previous and next step instead of a journey.
- **Evidence is labelled.** A guess is marked as a guess, so you know what to check.
- **Independent critique.** The reviewers did not design the work. A stated rationale never lowers a severity, and a dismissal shows at G2 with its reason.
- **Files over chat.** Decisions go to files in the plan folder. Deliberation stays in chat.
- **You approve.** The skills stop at the gates. A reply approves only the stage shown.

## Developing the plugin

```bash
bash scripts/check-portability.sh   # skill text names no domain, stack or project
bash scripts/check-skill-size.sh    # each SKILL.md stays inside its word budget
bash scripts/check-readme.sh        # the README matches the skills and scripts
```

To ban your own project names as well, list them in a `.portability-banned` file at the repo root, one regex per line. Git ignores that file.

Change a file in `skills/`, `references/`, `templates/`, `evals/` or `scripts/`? Update this README in the same commit when it describes that file.

`evals/` holds the eval cases for `claude plugin eval`. Each case runs with and without the plugin. See `evals/README.md` for how to run them, and `evals/baselines/` for the recorded results.
