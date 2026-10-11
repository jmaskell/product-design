---
name: modelling-products
description: Use when a repo has no product model (PRODUCT.md, docs/product/actors.md, canonical journeys) and the owner asks to set up, bootstrap or document the product, its users, actors or workflows, or when the plugin is added to an existing codebase or a new product starts.
---

# Modelling products

The model: PRODUCT.md, docs/product/actors.md, journeys in docs/product/journeys/. Plugin files, two levels above this skill: templates/actors.md, templates/journey.md, references/evidence-ledger.md, references/lenses.md.

## 1. Pick the mode

- actors.md exists: fill only a missing or empty PRODUCT.md (Edit or new file), then stop. Add no section to a full one. Say the model exists. Offer product-design:auditing-product-models to check it against the code, or product-design:mapping-journeys to add one job's journey.
- Application source exists: from code (section 2).
- No application source: from the owner's answers (section 3).

Never Write over an existing PRODUCT.md, actors.md or journey; Edit only empty sections.

## 2. From code

Read the code first: routes, role checks, email or message links, scheduled jobs, rules, analytics events, comments.

- Actor: each role, each person who acts through email or a link, each scheduled job (kind `system`).
- Journey: one actor, one outcome, across routes. Note its 1–4 entry-point files for the `Code:` line.
- Contradiction: code that disagrees with itself, a comment or the docs. List each as `UNKNOWN` in the journey's Open unknowns, else in actors.md notes. Never pick a side.

Tag code entries `INFERRED (from <path>)`.

## 3. From the owner's answers

Ask in one batch: what it is, for whom; actors and jobs; what each must never do; first outcomes; what is out of scope. Tag the owner's intent and constraints `KNOWN (owner, <date>)`. Tag what people do `ASSUMED` unless the owner names a source.

## 4. Depth

- Sketch: PRODUCT.md and actors.md. No journey file.
- Core: Sketch + one journey per user actor's main job.
- Full: Core + a journey per job, 7 at most.

No depth given: show the inventory (actors, jobs with IDs, candidate journeys), recommend one tier, write only Sketch, and ask the owner to confirm it. Otherwise write nothing past the owner's depth. A job with no journey file is not yet modelled. Name those jobs in the reply.

Ask who reads the model. The answer picks lens questions (references/lenses.md) inside the tier; no new file. Default: PM and Designer.

## 5. Write

- PRODUCT.md sections: Platform, Users, Product Purpose, Capabilities and Constraints, Evidence on Hand, Product Principles, `## Terms` (Term | Meaning | Avoid | Code name: the identifier in code), `## Market` (alternatives with "do nothing", category, segment traits, losses). No other section. Ask whether the domain is sensitive.
- Each rule in Capabilities and Constraints: rule + source, `Interpretation: UNKNOWN` until the owner picks a reading (references/lenses.md).
- actors.md: Kind: exactly one of `user`, `internal role`, `external actor`, `system`. Every job has an ID (letter and number: T1, A2) and one `Signal:` with its source in the Signals block; prefer an event in code. Relationship rows use only the template's verbs.
- Journeys: the template header, a `Code:` line naming entry-point files, 120 lines at most.

## 6. Ask

End with the questions only the owner can answer. Give each contradiction with both values; ask which is right. Retag each answer `KNOWN (owner, <date>)`.
