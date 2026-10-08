---
name: mapping-journeys
description: Use when a framed problem needs its place in the person's whole journey, when a change touches more than one actor or a hand-off, when a design risks moving work from one person to another, or when asked to simplify, remove or merge steps, fields or screens.
---

# Mapping journeys

`templates/` and `references/` sit two levels above this skill's directory.

Reason in this order. Never skip a level (references/journey-mapping.md).

1. **Experience journey.** Read docs/product/journeys/ for the canonical journey this change sits in. Name the stage. If no journey exists, map the stages from trigger to outcome yourself, from the person's start to their end, even outside the product.
2. **Task flow.** For this change: steps, decisions, information needed at each decision, failure and recovery.
3. **Every actor.** For each actor in docs/product/actors.md that the change touches: what they do differently after the change. Write the work that moves, and to whom.
4. **Backstage.** Where a stage has a hand-off or invisible work, fill the Backstage section (references/service-blueprinting.md).

Write `docs/plans/<slug>/journey.md` from templates/journey.md, or use the plan directory the project names. Write it as a diff against the canonical journey: changed stages only, each marked `changed` or `new`. For a Small change, write no journey.md. Add two lines to issue.md instead: the previous step and the next step.

## Displacement check (required)

| Removed or simplified for | Work now done by | Stage | Cost |
|---|---|---|---|

If the table has a row, the framing must answer it before design starts. The owner answers it, so the reply shows each row with all four columns. Name the stage as the journey names it.

## Red flags

| Thought | Reality |
|---|---|
| "This only changes one screen" | Name the stage before and after. One screen can move work to another actor. |
| "My safeguard means nothing is lost" | Map the change as asked first. Its displacement rows are its cost. The safeguard is an alternative. |

At the end, if no canonical journey existed, offer to save this one to docs/product/journeys/. Do not write it without the owner's yes.
