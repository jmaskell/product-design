# Build principles: GREEN record (2026-10-22)

Sonnet 5.5, judge Sonnet. Final text: `c2dc5ea`. Each run came from a checkout pinned to the commit named in its row. RED is in `2026-10-21-build-principles-red.md`.

The without arm can't pass `skill-fired`, so its ceiling is (n−1)/n.

## What changed between GREEN rounds

1. **`5919d6e`:** the four waves. Only t25h moved. In the traces, the references were read in some runs and not others (t25 and t25e read none). t25c read all four and still built a flat list. The cause: "After writing" checked against the skill's body rules only.
2. **`f557f03`, `e680395`:** a seven-line build checklist in writing-ui-copy's "After writing". A with-arm trial at `1bb123e` fixed t25b, t25c, t25e, t26 and t26b. The owner raised the writing-ui-copy limit to 700 words (2026-10-22).
3. **`e64e0ae`:** case fixes.
   - t25 had no offer page to land on; the fixture now has one.
   - t25d's prompt named the list file; it is now neutral.
   - t26d's grader failed an optional County fallback; it now fails only a required County.
   - t26g's grader failed an in-place expand button.
4. **`d89cd47`:** restored rule 2's "no text or error for a limit the control enforces", which the 600-word trims had cut (t23 had regressed to 0.53). The done-page check now names payment, sign-up or application.
5. **`c2dc5ea`:** fixes from the final review.
   - Rule clashes fixed in needed-now, product-behaviour, controls-and-dialogs and forms.
   - The Undo hold must survive the person leaving the page.
   - Examples that echoed the case prompts replaced.
   - Graders fixed: t25b, t25g and t25k.

## New cases

| Case | With | Without | Runs | Text | Failing (with) | Label |
|---|---|---|---|---|---|---|
| t25-send-offer | 0.85 | 0.75 | 5 | `c2dc5ea` | says-recipient 3/5 | GUARD (RED passes once the fixture has an offer page) |
| t25b-undo-email | 1.00 | 0.75 | 5 | `c2dc5ea` | — | GUARD. RED with arm had a false Undo 1/3, and GREEN at `5919d6e` 4/5; now 0/5. |
| t25c-applicant-page | 0.80 | 0.00 | 5 | `e680395` | grouped 2/5; 0.89 (3 runs, with arm) at `d89cd47` | GREEN |
| t25d-applicant-flags | 0.87 | 0.33 | 5 | `e64e0ae` | no-list-flags 4/5; 0.78 (3, with arm) at `c2dc5ea`, one run without the skill firing | GREEN |
| t25e-holding-deposit-done | 1.00 | 0.33 | 5 | `e680395` | —; 1.00 (3, with arm) at `d89cd47` | GREEN |
| t25f-amounts | 1.00 | 0.50 | 5 | `e680395` | — | GUARD |
| t25g-one-name | 0.50 | 0.00 | 5 | `c2dc5ea` | one-name 0/5; RED at old text 0.50 / 0.00 (3) | **Not GREEN** |
| t25h-inline-cancel | 1.00 | 0.50 | 5 | `c2dc5ea` | — | GREEN (fixes a skill-caused RED) |
| t25i-empty-panel | 1.00 | 0.50 | 5 | `e680395` | — | GUARD |
| t25j-template-editable | 1.00 | 0.50 | 5 | `e680395` | — | GUARD |
| t25m-list-status | 1.00 | 0.50 | 5 | `e680395` | — | GUARD |
| t25n-unavailable | 0.80 | 0.00 | 5 | `e680395` | focusable-unavailable 3/5 | GREEN |
| t26-form-check | 1.00 | 0.24 | 5 | `e680395` | —; 1.00 (3, with arm) at `d89cd47` | GREEN |
| t26b-record-gaps | 1.00 | 0.10 | 5 | `e680395` | —. The without arm had 4 harness spawn errors, so its score is unreliable. | GREEN |
| t26c-routine-undo | 1.00 | 0.47 | 5 | `e680395` | — | GUARD (RED 0.89) |
| t26d-derived-field | 1.00 | 0.50 | 5 | `e64e0ae` | —; 1.00 (3, with arm) at `c2dc5ea` | GUARD (RED passes after the grader fix) |
| t26e-audience-word | 1.00 | 0.50 | 5 | `e680395` | — | GUARD |
| t26f-wait-feedback | 1.00 | 0.50 | 5 | `e680395` | — | GUARD |
| t26g-labels-dialog | 1.00 | 0.75 | 5 | `e680395` | —; 1.00 (3, with arm) at `c2dc5ea` | GUARD (after the grader fix, both arms pass link-vs-button) |
| t26h-split-actor | 1.00 | 0.00 | 5 | `5919d6e` | — | GUARD (the current skill already splits) |
| t25k-design-offer | 1.00 | 1.00 | 5 | `5919d6e` | —; 1.00 (3, with arm) at `c2dc5ea` | GUARD |
| t25l-review-offer | 0.83 | 0.70 | 5 | `e680395` | p4 1/5 (mid-page actions); keeper 4/5 | GREEN (narrow) |

GREEN: t25c, t25d, t25e, t25h, t25n, t26, t26b, t25l. Not GREEN: t25g. The rest are GUARD.

## Opus 5.5 (1 run, with arm)

Runs on `d89cd47`; the last 8 cases re-run on `c2dc5ea`. Every new case scores 1.00 except:
- t25g: 0.50 (one-name).
- t25l: 0.67 (p4 and p5 missed).
- t25k: 1.00, but one of its two runs timed out.

## Regression (with arm, 3 runs)

| Case | Score | Text | Earlier GREEN |
|---|---|---|---|
| t22-validation, t22b, t22c, t22d, t22e, t22i, t22j | 1.00 each | `e64e0ae`; t22c, t22d and t22j also 1.00 at `d89cd47` or `c2dc5ea` | 1.00 |
| t23-book-visit | 0.53 at `e64e0ae` → 0.93 at `d89cd47` → 0.87 at `c2dc5ea` (result-only 1/3) | | 1.00 |
| t23b-visit-email | 1.00 | `d89cd47` | 0.93 |
| t23c-return-page | 1.00 | `d89cd47` | 1.00 |
| t23d-tighten | 1.00 | `c2dc5ea` | 1.00 |
| t23e-design-needed | 1.00 | `e64e0ae` | 0.95 |
| t23f-review-needed | 1.00 (one run timed out) | `e64e0ae` | 0.90 |
| t7-component-reuse | 0.89 | `e64e0ae` | 0.93 |
| t10-stops-at-g1 | 1.00 | `e64e0ae` | 1.00 |
| t4-novice-vs-expert | 0.67 | `e64e0ae` | 0.67–0.80 (noisy) |
| t5-dead-end, t9-rationale-pressure | 1.00 | `e64e0ae` | 1.00 |
| t16-model-from-code | 0.97 | `e64e0ae` | 0.98–1.00 |
| t16b-model-from-interview | 0.94 | `e64e0ae` | 1.00 |
| t17-audit-report, t18-actors-missing | 1.00 | `e64e0ae` | 1.00 |

## Not re-run after the last text change (`c2dc5ea`)

- New cases: t25c, t25e, t25f, t25i, t25j, t25m, t25n, t26, t26b, t26c, t26e, t26f and t26h, apart from the single Opus runs that used `c2dc5ea`.
- Regression cases: all except t22c, t23, t23d, t26d, t26g, t25d and t25k.
- `c2dc5ea` changed needed-now rules 1 and 2, the Cancel wording, product-behaviour's hold, controls-and-dialogs, forms, and the examples.

## Untested

- Posture.
- Remembered answers and defaults.
- The working-memory row (B7).
- The plain-prose Content Design rules (deciding word first, headings first).
- The audit's route check (t25l p5 covers the reviewer's per-actor check, not the audit).
- t25k's "design.md records what a removed step guarded".
- t26h's "a split changes no permission".

## Cost

- API key (before the owner's switch): about $83.
- Subscription (API-equivalent): about $71.
