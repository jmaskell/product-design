---
name: designing-products
description: Use when asked to design, define, shape or scope a feature, flow or product change before engineering starts, or when told to "design this properly".
---

# Designing products

Diverge, then converge, twice: first on the problem, then on the solution.

## 1. Pick the tier and say it

Size the request alone, before you read any file. Write `Tier: <tier> — <the predicate that matched>` as your first text.
Then read PRODUCT.md and the project metadata `Tier triggers`, and raise the tier if a predicate matches.

| Tier | Any one of |
|---|---|
| Large | Two or more actors act differently; a hand-off; a changed canonical journey stage; a sensitive-domain flag in PRODUCT.md |
| Medium | A new screen or dialog; a changed task flow for one actor; a new component pattern |
| Small | Otherwise |

In doubt, take the heavier tier. When you find a predicate later, raise the tier, update the issue.md Phases line, and say so: `Tier: <old> → <new> — <the predicate found>`. Never lower it. Open every gate reply with the tier line, and show each raise in it.

## 2. Run the phases

Each named skill is a REQUIRED SUB-SKILL. Load it with the Skill tool and follow it. Do not do its work yourself.

| Tier | Phases |
|---|---|
| Small | Frame in three lines (outcome, previous and next step, job) → product-design:designing-interactions (one mock or none) → G2 as one approval question. No reviewer agents. |
| Medium | product-design:framing-problems → product-design:mapping-journeys → G1 in one message → product-design:designing-interactions (2 options) → product-design:reviewing-product-design → G2 |
| Large | product-design:framing-problems → product-design:mapping-journeys → **G1, stop** → product-design:designing-interactions (3 options) → product-design:reviewing-product-design → G2 |

## 3. Gates

- **G1 — right problem?** Show the outcome, the journey, the evidence ledger and the questions for the expert. In Large, stop and wait.
- **G2 — right design?** Show the mocks, decisions.md, dismissals, and tensions that need a ruling. A CRITICAL finding blocks approval until it is fixed or the owner accepts it with a reason.
- A reply approves only the stage you presented.

## 4. Missing context

Use what exists. PRODUCT.md alone is enough to start. With nothing, frame from code and the owner's answers, then offer to save the journey you mapped. Never block on a missing model.

## 5. Handoff

After G2: REQUIRED SUB-SKILL product-design:filing-issues. Engineering edits product code after the handoff. Do not edit it.

Project rules win over this skill.
