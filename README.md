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

- **G1 (right problem?)** shows the outcome, the journey, the evidence, the launch tier with its answers, the readings of any open rule and the questions for your domain expert. Large work stops here until you answer. Medium work shows G1 in one message and goes on.
- **G2 (right design?)** shows the mocks, the decisions, the dismissed findings and any tension that needs your ruling. A CRITICAL finding blocks approval until it is fixed or you accept it with a reason.
- **Small** work frames in three lines with a launch tier, makes one mock or none, and skips G1 and the review agents. Its G2 question carries the launch answers and the readings of any open rule. **Medium** work gets two design options. **Large** work gets three options and a fuller review.
- Medium and Large work offers a review page at each gate, so your team can comment.
- Before each gate, the router checks where each new value comes from. If another person must enter it, the router raises the size. It never lowers the size, and says so each time. G1 carries the offer to save a newly mapped journey.
- The router offers `modelling-products` when `PRODUCT.md` or `docs/product/actors.md` does not exist. It offers `auditing-product-models` when git log shows a commit on a canonical journey's `Code:` paths after its `audited:` date.
- After G2, engineering edits the product code. The skills do not, except `writing-ui-copy`, which is written to load whenever a change adds user-facing text.

## The skills

| Skill | Starts when |
|---|---|
| `designing-products` | You ask to design, define, shape, scope or revise a feature. This is the router. |
| `framing-problems` | A request arrives as a solution ("add a button"), or the user outcome is unstated. |
| `mapping-journeys` | A change touches more than one actor or a hand-off, or risks moving work from one person to another. |
| `designing-interactions` | The problem and task flow are agreed, and the screens, states or mocks are next. |
| `reviewing-product-design` | A design is drafted. Fresh agents critique it, one lens each (task walkthrough, service, usability, accessibility, cognitive load, compliance, privacy, marketing). The size and the risk pick the lenses. Compliance runs when the work touches a rule that PRODUCT.md or the `Domain rules` file records, or a sensitive domain, privacy when the code stores personal data, and marketing when the issue's launch tier is 2 or 3. These three share the by-risk slots; the review names any lens it skips. Each compliance or privacy finding gives a fix or the case for the current design, never a verdict. |
| `sharing-designs` | You ask to share a design or check its comments, or you accept the offer to share at a gate. It never designs: a request to revise goes to the router. |
| `filing-issues` | An approved design must go to the tracker or a plan folder, work must split into several issues, or a bug skips design. |
| `modelling-products` | The repo has no product model yet, the plugin joins an existing codebase or a new product starts. It reads the code first and asks only what the code cannot tell. You set the depth. |
| `auditing-product-models` | The product docs may no longer match the code, or you ask to audit or refresh them. It reports drift and gaps with evidence, patches the docs where the code is right, and lists an issue where the code is wrong. It judges code against the owner's recorded interpretation of a rule, checks Terms, Signals and README or site claims, and runs one lens from `references/lenses.md` on request ("audit for privacy"). It never edits product code. |
| `writing-ui-copy` | Code or a design adds or changes a string a person will see: UI text, buttons, errors, empty states, emails, notifications. That includes copy written while building a feature or fixing a bug. It reads the project's copy rules and `Copy examples:` file first. It cuts each line that isn't needed at that moment, with `references/needed-now.md`, and keeps a line that stops a named mistake. |

Haiku does not call plugin skills on its own. For Haiku sessions, add this line to the project's CLAUDE.md: "Before adding or changing user-facing strings, use product-design:writing-ui-copy." (t22l: Haiku loaded the skill in 5 of 5 runs with it.)

Every claim about people carries an evidence label: `KNOWN (source)`, `INFERRED (from what)`, `ASSUMED` or `UNKNOWN`. Every finding has a severity: CRITICAL, SIGNIFICANT, MINOR or UNKNOWN.

## Sharing for review

Set `Review space` to a Notion database, a Notion page, or `artifact`. With a page, the first share creates a "Design review" database in it and asks you to put the database URL in the line. The skill rebuilds the review page from the plan files. The journey shows as two swim-lane grids, Today and Proposed: one row per person, one column per stage, and ◆ on each step that changes. In Notion, the text goes up first and the screenshots follow, one per screen. In Notion, a comment on a journey grid cannot point to one cell, so the page asks reviewers to quote the stage and person they mean. In Notion, each reviewer with an open question is tagged and notified, from the people list in `docs/product/people.md`. The skill publishes only when you ask to share or to check the comments, or when you accept the offer at a gate. The next design run, or a request to revise, triages the comments before anything else and reports to you without publishing. A request to check the comments triages and then publishes the next revision, but only if a plan file changed after the last publish. The skill skips threads it already answered and comments that decisions.md already records. An answer lands in decisions.md. A fact correction changes journey.md or issue.md, and marks each decision that rests on the old fact `Needs review` for you. An objection becomes a finding in decisions.md, and the skill reports it to you. A comment never approves a gate.

## Adopting in a project

The skills work with nothing set up: they frame from the code and your answers, then offer to save what they mapped. To set up the whole model at once, ask Claude to set up the product docs (modelling-products). They do better with these files.

**Project metadata**, in `CLAUDE.md` or `AGENTS.md`:

```markdown
## Project metadata

- Tracker: none                 # none | linear | github
- Plan directory: docs/plans/
- Component source: none        # a gallery route, a registry URL, or none
- Tier triggers: payment or health data → Large
- Domain rules: docs/domain-rules.md
- Copy examples: docs/copy-examples.md
- Review space: notion <database URL>     # or: notion <page URL>, or: artifact
```

| Key | Used by |
|---|---|
| `Tracker` | filing-issues: where approved work goes (`none`, `linear` or `github`). With `linear`, it needs Linear's MCP server. With `github`, it needs the `gh` CLI. |
| `Plan directory` | framing-problems, mapping-journeys, designing-interactions, filing-issues: where `issue.md`, `journey.md`, `design.md`, `decisions.md` and `mocks/` go. The default is `docs/plans/<slug>/`. With `Tracker: none`, filing-issues numbers the folders and the merged folder is the tracker. |
| `Component source` | designing-interactions: what the mocks are built from. |
| `Tier triggers` | designing-products: extra predicates that raise the size. |
| `Domain rules` | reviewing-product-design: the file the compliance and privacy reviewers check against. |
| `Copy examples` | writing-ui-copy: before→after pairs and project copy rules; a project rule wins. |
| `Review space` | sharing-designs: where the review page goes — a Notion database, a Notion page (gets a new database), or a Claude artifact; unset uses an artifact if available, else a local review.html. |

**Product files:**

- `PRODUCT.md` at the repo root: the product, its users, and any sensitive-domain flag. A sensitive domain raises the work to Large. PRODUCT.md alone is enough to start. modelling-products adds two sections: `Terms` (term, meaning, words to avoid, code name) and `Market` (alternatives, category, segment traits, losses). Each rule in Capabilities and Constraints keeps `Interpretation: UNKNOWN` until you pick a reading. modelling-products asks who will read the model and picks lens questions inside the tier (default PM and Designer).
- `docs/product/actors.md` and `docs/product/journeys/`: the saved actors and journeys. The skills write these files from `templates/`: `actors.md`, `journey.md`, `issue.md`, `design.md` and `decisions.md`. sharing-designs builds the team review page from `templates/review-page.md`, publishes it with `skills/sharing-designs/artifact.md` or `skills/sharing-designs/notion.md`, and triages the comments with `skills/sharing-designs/triage.md`.
- `actors.md` holds a `Signal:` line per job and the relationship verb `pays for`. `issue.md` holds a `**Launch:**` line: tier, audience and goal, provisional until the owner confirms. framing-problems proposes it and answers only that tier's questions, in the issue.md `## Launch` section. For each rule the work touches with no recorded interpretation (`Interpretation: UNKNOWN`, or no `Interpretation:` line), framing-problems sets out 2–3 readings for you to pick in the issue.md `## Rules for the owner` section, each with its strongest case and its risk; it may name a lean, gives no verdict, and no reading waits on a ruling from legal, an expert or anyone else. Small work has no framing skill, so the router puts those readings in the G2 question. The audit and the reviewer report an uninterpreted rule's readings as an UNKNOWN for you. mapping-journeys adds a stage only when discovery or adoption changes; for tier 3 it maps the path from discovery to first value. designing-interactions builds the chosen reading, or each open reading that changes the design, into the flow; no option tests a reading stricter than one you recorded.
- `references/lenses.md` holds the question list for each role (PM, Designer, Engineering, Commercial, Marketing, Support and ops, Compliance, Privacy, CEO), the launch tiers (a change that helps only after people learn something new, or that the product must explain, is tier 2), and the readings of a rule. Each question names its home in the model and what Claude can check from code or a site.
- `references/needed-now.md` holds the line test ("If this line were gone, would this person do something wrong, or not know what to do next?"), seven rules (a limit the control enforces, a check step that repeats its summary or reads as done, onboarding on return visits, repeated counts, results that list side effects, helper lines that name no mistake), before → after examples and a "kept on purpose" list.
- modelling-products writes the first model. Each canonical journey has a `Code:` line with its entry-point files. auditing-product-models sets `audited:` on each journey it checks, so a clean audit stops the router's audit offer. It never changes `verified:`.
- `docs/product/people.md`: names, roles and Notion user IDs for tagging reviewers; no email addresses. The skill writes it from `templates/people.md`.

**Project rules win.** If your `CLAUDE.md` or `AGENTS.md` names another skill for a step (for example `superpowers:brainstorming` for specs), Claude follows your rule. To use the router there, change the rule or name the skill in your prompt: "Use product-design:designing-products to design …".

## Philosophy

- **Problem before screens.** No mock until the outcome, the evidence and the journey are written. Small work writes the previous and next step instead of a journey.
- **Evidence is labelled.** A guess is marked as a guess, so you know what to check.
- **Independent critique.** The reviewers did not design the work. A stated rationale never lowers a severity, and a dismissal shows at G2 with its reason. A finding against a KNOWN owner interpretation is a dismissal that cites the row, not a tension, an option or a question. A tension's recommendation rests on the moments and the evidence, not on a heuristic name alone.
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
