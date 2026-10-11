---
name: modelling-products
description: Use when a repo has no product model (PRODUCT.md, docs/product/actors.md, canonical journeys) and the owner asks to set up, bootstrap or document the product, its users, actors or workflows, or when the plugin is added to an existing codebase or a new product starts.
---

# Modelling products

The model is PRODUCT.md, docs/product/actors.md and canonical journeys in docs/product/journeys/. The templates sit two levels above this skill's directory: templates/actors.md and templates/journey.md. Evidence tags: references/evidence-ledger.md.

## 1. Pick the mode

| State | Mode |
|---|---|
| actors.md exists | Fill only a missing or empty PRODUCT.md (Edit or new file), then stop. Say the model exists. Offer product-design:auditing-product-models to check it against the code, or product-design:mapping-journeys to add one job's journey. |
| Application source exists | From code (section 2) |
| No application source | From the owner's answers (section 3) |

Never Write over an existing PRODUCT.md, actors.md or journey. Use Edit, and fill only empty sections.

## 2. From code

Read the code before you ask: routes, role checks, links sent by email or message, scheduled jobs, rules, and their comments.

- Actor: each role, each person who acts through email or a link, each scheduled job (kind `system`).
- Journey: one actor, one outcome, across routes. Note its 1–4 entry-point files for the `Code:` line.
- Contradiction: code that disagrees with itself, a comment or the docs. List each contradiction as `UNKNOWN` in the journey's Open unknowns, or in actors.md notes if no journey exists. Never pick a side.

Tag every entry from code `INFERRED (from <path>)`.

## 3. From the owner's answers

Ask in one batch: what it is and for whom; the actors and their jobs; what each must never do; the first outcomes; what is out of scope. Tag the owner's intent and constraints `KNOWN (owner, <date>)`. Tag what people do `ASSUMED` unless the owner names a source.

## 4. Depth

| Tier | Writes |
|---|---|
| Sketch | PRODUCT.md and actors.md. No journey file. |
| Core | Sketch + one journey for each user actor's main job |
| Full | Core + a journey for each job, 7 at most |

If the owner gave no depth, show the inventory: actors, jobs with IDs, candidate journeys. Recommend one tier, write only Sketch, and ask the owner to confirm the tier.

Use the depth the owner gave. Write nothing past it. A job with no journey file is not yet modelled. Name those jobs in the reply.

## 5. Write

- PRODUCT.md sections: Platform, Users, Product Purpose, Capabilities and Constraints, Evidence on Hand, Product Principles. Never add a section. Ask whether the domain is sensitive.
- actors.md: Kind is exactly `user`, `internal role`, `external actor` or `system`, one per actor row. Every job has an ID: a letter and a number (T1, A2). Relationship rows use only the template's verbs.
- Journeys: the template header with a `Code:` line that names the entry-point files. A journey is 120 lines or less.

## 6. Ask

End with the questions only the owner can answer. Give each contradiction with both values, and ask which is right. When the owner answers, change the tag to `KNOWN (owner, <date>)`.
