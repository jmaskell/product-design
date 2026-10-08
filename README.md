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
     │
     ├─ designing-interactions ─► reviewing-product-design ─► G2: right design?
     │
     └─ filing-issues ─► tracker or plan folder ─► your build workflow
```

- **G1 (right problem?)** shows the outcome, the journey, the evidence and the questions for your domain expert. Large work stops here until you answer.
- **G2 (right design?)** shows the mocks, the decisions and any finding that needs your ruling. A CRITICAL finding blocks approval until it is fixed or you accept it with a reason.
- **Small** work skips G1 and the review agents. **Large** work gets three design options and a full review.

## The skills

| Skill | Starts when |
|---|---|
| `designing-products` | You ask to design, define, shape or scope a feature. This is the router. |
| `framing-problems` | A request arrives as a solution ("add a button"), or the user outcome is unstated. |
| `mapping-journeys` | A change touches more than one actor or a hand-off, or risks moving work from one person to another. |
| `designing-interactions` | The problem and task flow are agreed, and the screens, states or mocks are next. |
| `reviewing-product-design` | A design is drafted. Fresh agents critique it, one lens each (usability, accessibility, journey, domain risk). |
| `filing-issues` | An approved design must go to the tracker or a plan folder. |

Every claim carries an evidence label: `KNOWN (source)`, `INFERRED (from what)`, `ASSUMED` or `UNKNOWN`. Every finding has a severity: CRITICAL, SIGNIFICANT, MINOR or UNKNOWN.

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
```

| Key | Used by |
|---|---|
| `Tracker`, `Plan directory` | filing-issues: where approved work goes. With `linear`, it needs Linear's MCP server. With `github`, it needs the `gh` CLI. |
| `Component source` | designing-interactions: what the mocks are built from. |
| `Tier triggers` | designing-products: extra predicates that raise the size. |
| `Domain rules` | reviewing-product-design: the file the domain-risk reviewer checks against. |

**Product files:**

- `PRODUCT.md` at the repo root: the product, its users, and any sensitive-domain flag. A sensitive domain raises the work to Large. PRODUCT.md alone is enough to start.
- `docs/product/actors.md` and `docs/product/journeys/`: the saved actors and journeys. Templates are in `templates/`.

**Project rules win.** If your `CLAUDE.md` or `AGENTS.md` names another skill for a step (for example `superpowers:brainstorming` for specs), Claude follows your rule. To use the router there, change the rule or name the skill in your prompt: "Use product-design:designing-products to design …".

## Philosophy

- **Problem before screens.** No mock until the outcome, the journey and the evidence are on the table.
- **Evidence is labelled.** A guess is marked as a guess, so you know what to check.
- **Independent critique.** The reviewers did not design the work and do not trust the designer's reasoning. A stated rationale never lowers a severity.
- **Files over chat.** Decisions go to files in the plan folder. Deliberation and review transcripts stay in chat.
- **You approve.** The skills stop at the gates. Nothing advances on its own.

## Developing the plugin

```bash
bash scripts/check-portability.sh   # skill text names no domain, stack or project
bash scripts/check-skill-size.sh    # each SKILL.md stays inside its word budget
```

To ban your own project names as well, list them in a `.portability-banned` file at the repo root, one regex per line. Git ignores that file.

`evals/` holds the eval cases for `claude plugin eval`. Each case runs with and without the plugin. See `evals/README.md` for how to run them, and `evals/baselines/` for the recorded results.
