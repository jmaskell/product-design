---
name: reviewing-product-design
description: Use when a journey, flow or interaction design is drafted and needs critique before the owner approves it, or when asked to review a product or UX design against design principles.
---

# Reviewing product design

`templates/` and `references/` sit two levels above this skill's directory. reviewer-prompt.md and synthesis.md sit in this skill's directory.

The designer never reviews its own work. Each lens runs as a fresh agent with reviewer-prompt.md.

## Choose lenses

| Lens | Reference | Run when |
|---|---|---|
| Task walkthrough | references/norman-and-walkthrough.md | Medium and Large, always |
| Service | references/good-services.md, references/service-standard.md | Large; Medium with another actor or a hand-off |
| Usability (flow level) | references/nielsen.md | New screen or new pattern |
| Accessibility | references/wcag-and-inclusive-design.md | New control or interaction |
| Cognitive | references/cognitive-principles.md | Dense screens, many choices, recall demands |
| Domain risk | project metadata `Domain rules` | PRODUCT.md flags a sensitive domain |

Medium: walkthrough + one lens by risk. Large: walkthrough + service + accessibility + one or two by risk. Say which lenses run and why, in one line.

Screen-level visual and heuristic scoring belongs to the project's visual-design tooling. Do not repeat it.

## Run

1. Dispatch one agent per lens, in parallel, with reviewer-prompt.md and the lens name. Use the project's reviewer agent type if it defines one.
2. Synthesise with synthesis.md.

## At G2

Show each Tension entry first, also the ones you ruled: its trade-off name, its Options line as written in decisions.md (A → moment; B → moment), and its ruling or the question for the owner. Then show each finding, open or fixed in the revision, with its reviewer format line, `<SEVERITY> · <source + principle> · <journey stage / mock state>`, and its consequence or its fix. A count per severity is not a finding. Then show every dismissal with its reason, and the dimension table.

## Red flags

| Thought | Reality |
|---|---|
| "The designer explained why it is fine" | Rationale never lowers severity. Show the dismissal at G2. |
| "The heuristics agree, so it is settled" | Look for the lens that disagrees. A tension is a finding. |
| "Average the two recommendations" | Name the trade-off. Rule or ask. |
| "Give it a score out of 10" | No totals. Severity and evidence only. |
