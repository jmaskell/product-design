---
name: designing-interactions
description: Use when a framed problem and its task flow are agreed and the interface flow, screens, states or mocks are next, or when choosing between interaction approaches.
---

# Designing interactions

`templates/` and `references/` sit two levels up; open them with Read.

Input: issue.md and journey.md. Small: issue.md's previous/next step is the task flow. If the task flow is missing, stop and run product-design:mapping-journeys.

## Recipe

1. **Interface flow.** Map each task-flow step to a screen, a control or a state. A step with no interface stays in the system (no decision, no button). Build the chosen reading of each rule in issue.md, or each open reading that changes the design, into the flow as a design problem: where consent sits, how a check feels, an audit trail as a Backstage stage. Every option keeps each reading the owner recorded as KNOWN; no option tests a stricter one. Its decisions.md entry points to the PRODUCT.md row and adds no reading of its own.
2. **Options.** Take the tier from the issue.md `Phases:` line. With no issue.md, a new screen or pattern is Medium. Medium: two genuinely different structures. Large: three. Small: one. Differ in structure (where the decision happens, what is shown), not in styling.
3. **Mocks.** Load `writing-ui-copy` first, then build each option as a mock (references/mocks.md). Reuse the component source. Flag every uncovered region as a new pattern.
4. **States.** For each screen: default, empty, loading, error, partial, and any domain state. Write "N/A — <reason>" for a state that cannot happen.
5. **Accessibility decisions.** Focus destination after each transition, live announcements, meaning not carried by colour alone. Full checks: references/wcag-and-inclusive-design.md.
6. **Decision record (Medium, Large).** One entry per choice in decisions.md: decision, rejected, why (as a journey moment), evidence. When the evidence is ASSUMED or UNKNOWN, add `Rests on: <tag> — <claim>`.
7. **design.md** from templates/design.md, 250 lines or less. The deliberation stays in chat.
8. **Review.** Do not review your own design. Hand it to product-design:reviewing-product-design (Medium, Large). Load that skill with the Skill tool.

## At G2

Show each option: its mock file and where its decision happens. Then give each decision in one line, with its `Rests on:` mark where it has one. When a review ran, also show everything the "At G2" section of product-design:reviewing-product-design lists.

Visual craft (typography, colour, motion, polish) belongs to the project's visual-design tooling. Pass it the chosen mock and design.md.

Project rules on mocks and formats win over this recipe. When one applies, name the rule in the reply.
