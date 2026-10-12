---
name: designing-products
description: Use when asked to design, define, shape or scope a feature, flow or product change before engineering starts, when asked to revise a design or take it to its next gate, or when told to "design this properly".
---

# Designing products

## 1. Pick the tier and say it

Size the request before reading files. Write `Tier: <tier> — <the predicate that matched>` as your first text.
Then read PRODUCT.md and the `Tier triggers` metadata; raise the tier if one matches.

| Tier | Any one of |
|---|---|
| Large | Two or more actors act differently; a hand-off; a changed canonical journey stage; a sensitive-domain flag in PRODUCT.md |
| Medium | A new screen or dialog; a changed task flow for one actor; a new component pattern |
| Small | Otherwise |

In doubt, take the heavier tier. Before each gate, check where each new value comes from; if another actor must enter it, raise the tier and update the issue.md Phases line. Never lower it. Open every gate reply with the tier line, showing each raise: `Tier: <old> → <new> — <the predicate found>`.

## 2. Phases

If decisions.md has a `Review page:` line, run product-design:sharing-designs triage first.

Load and follow each named skill (REQUIRED SUB-SKILL). Do not do its work yourself.

| Tier | Phases |
|---|---|
| Small | Frame in three lines (outcome, previous and next step, job) and the issue.md Launch line → product-design:designing-interactions (one mock or none) → G2: one approval question, launch answers, readings (references/lenses.md) for each open rule. No reviewers. |
| Medium | product-design:framing-problems → product-design:mapping-journeys → G1 in one message → product-design:designing-interactions (2 options) → product-design:reviewing-product-design → G2 |
| Large | product-design:framing-problems → product-design:mapping-journeys → **G1, stop** → product-design:designing-interactions (3 options) → product-design:reviewing-product-design → G2 |

## 3. Gates

- **G1 — right problem?** Once journey.md exists, show the framing-problems reply in its order, each launch answer and reading in full, the journey and its save offer.
- **G2 — right design?** Show the mocks, decisions.md, dismissals, and tensions to rule on.
- Medium and Large: offer product-design:sharing-designs at each gate.
- A reply approves only the presented stage.

## 4. Missing context

With no model, frame from code and owner answers; offer to save the mapped journey. If PRODUCT.md or docs/product/actors.md is missing, offer product-design:modelling-products. If git log shows a commit on a canonical journey's `Code:` paths after its `audited:` date, offer product-design:auditing-product-models.

## 5. Handoff

After G2: REQUIRED SUB-SKILL product-design:filing-issues. Do not edit product code.

Project rules win over this skill.
