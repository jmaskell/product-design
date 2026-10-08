---
name: designing-interactions
description: Use when a framed problem and its task flow are agreed and the interface flow, screens, states or mocks are next, or when choosing between interaction approaches.
---

# Designing interactions

`templates/` and `references/` sit two levels above this skill's directory.

Input: issue.md and journey.md. Small: issue.md's previous/next step is the task flow. If the task flow is missing, stop and run product-design:mapping-journeys.

## Recipe

1. **Interface flow.** Map each task-flow step to a screen, a control or a state. A step with no interface stays in the system (no decision, no button).
2. **Options.** Medium: two genuinely different structures. Large: three. Small: one. Differ in structure (where the decision happens, what is shown), not in styling.
3. **Mocks.** Build each option as a mock (references/mocks.md). Reuse the component source. Flag every uncovered region as a new pattern.
4. **States.** For each screen: default, empty, loading, error, partial, and any domain state. Write "N/A — <reason>" for a state that cannot happen.
5. **Accessibility decisions.** Focus destination after each transition, live announcements, meaning not carried by colour alone. Full checks: references/wcag-and-inclusive-design.md.
6. **Decision record (Medium, Large).** One entry per choice in decisions.md: decision, rejected, why (as a journey moment), evidence. When the evidence is ASSUMED or UNKNOWN, add `Rests on: <tag> — <claim>`.
7. **design.md** from templates/design.md, 250 lines or less. The deliberation stays in chat.
8. **Review.** Do not review your own design. Hand it to product-design:reviewing-product-design (Medium, Large). Load that skill with the Skill tool.

## At G2

Show each option: its mock file and where its decision happens. Then give each decision in one line, with its `Rests on:` mark where it has one. When a review ran, also show everything the "At G2" section of product-design:reviewing-product-design lists.

Visual craft (typography, colour, motion, polish) belongs to the project's visual-design tooling. Pass it the chosen mock and design.md.

Project rules on mocks and formats win over this recipe. When one applies, name the rule in the reply.
