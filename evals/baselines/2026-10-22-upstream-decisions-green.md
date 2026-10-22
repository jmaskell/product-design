# Upstream decisions: GREEN record (2026-10-22)

Sonnet 5.5, judge Sonnet, on the subscription. Final text: `8ba56f4`. Each batch ran from its own detached worktree, pinned to the commit named in its row. RED is in `2026-10-22-upstream-decisions-red.md`.

The without arm can't pass `skill-fired`, so its ceiling is (n−1)/n.

## Changes between GREEN rounds

1. **`3b09977`:** Tasks 2–5. Terms gained `Seen by`, and mapping asks for one word. design.md gained Build notes. The review checks the mocks against them. writing-ui-copy follows them, flags a missing design and reads Terms.
2. **`c0a06ed`:**
   - Text: `Like:` may be "none (new pattern)"; unavailable actions stay visible; rule 9 searches the code.
   - Graders fixed: t27 (accepts "tenancy plan template"), t27b (`Like: none`), t27e (the Payments link in any wording). Each rejected replies that met the intent.
3. **`fc04b7c`:** rule 9 searches for the same data, not the name. t27b's prompt now names the agent's page for one applicant: "applicant page" had been read as the page the applicant sees.
4. **`3ba8e2a`:** fixes from the final review.
   - The reviewer may open the `Like:` files and the route table.
   - A naming question stops mapping, as a displacement row does.
   - New GUARD case t27g.
5. **`8ba56f4`:** the G2 reply opens with the options; Build notes stay in design.md. This fixed a t7 regression.

## New and target cases (5 runs, both arms, unless noted)

| Case | With | Without | Text | Failing (with) | Label |
|---|---|---|---|---|---|
| t27-terms-clash | 0.90 | 0.30 | `3ba8e2a` | no-templates-stage 4/5 | GREEN |
| t27b-build-notes | 0.80 | 0.00 | `fc04b7c`; 0.89 (3, with) at `8ba56f4` | notes-send 2/5 | GREEN |
| t27c-follows-notes | 1.00 | 0.75 | `3b09977` | — | GUARD (RED 1.00) |
| t27d-no-design-nudge | 1.00 | 0.33 | `3b09977` | — | GREEN |
| t27e-review-notes | 1.00 | 0.60 | `c0a06ed`; 1.00 (3, with) at `3ba8e2a` | — | GREEN |
| t27f-like-screen | 1.00 | 0.20 | `3b09977`; 1.00 (3, with) at `3ba8e2a` | — | GREEN |
| t27g-audit-no-seen-by | 1.00 | 0.50 | `3ba8e2a` | — | GUARD (the old audit never mentions the column) |
| t25-send-offer | 1.00 | 0.75 | `3b09977` | — | GUARD (PR #8: 0.85) |
| t25c-applicant-page | 0.93 | 0.07 | `3b09977` | grouped 4/5 | GREEN (PR #8: 0.80) |
| t25g-one-name | 0.50 | 0.00 | `fc04b7c` | one-name 0/5 | **Not GREEN**: the build-time backstop with no product model. Its source fix, t27, is GREEN at 0.90. |
| t25l-review-offer | 1.00 | 0.67 | `3b09977` | — | GREEN (PR #8: 0.83; p4 now 5/5) |
| t25n-unavailable | 1.00 | 0.00 | `c0a06ed` | — | GREEN (PR #8: 0.80) |

## Opus 5.5 (1 run, with arm, `fc04b7c`)

- **1.00:** t25, t25c, t25n, t27c, t27d, t27e, t27f.
- **t25g: 0.50.**
- **t27: 0.50.** It asked for one word, but its journey still named "templates" without recording the clash. The run predates the stop fix in `3ba8e2a`.
- **Timed out at 570 s, no score:** t25l (0.00) and t27b (0.67). Reviews and designs now open more files, and Opus is slower. Neither case was re-run on Opus.

## Regression (with arm, 3 runs)

| Case | Score | Text | Earlier |
|---|---|---|---|
| t10, t17, t18, t22c, t23b, t23d, t25d, t25e, t25k, t26 | 1.00 each | `fc04b7c` | 1.00 |
| t16-model-from-code | 0.97 | `fc04b7c` | 0.97 |
| t23-book-visit | 0.87 | `fc04b7c` | 0.87 |
| t2-displaced-work | 0.83 at `fc04b7c`, 0.67 at `3ba8e2a` | | earlier records range 0.67–1.00 |
| t2b-displaced-work-paraphrase | 0.83 at `fc04b7c`, 1.00 at `3ba8e2a` | | 1.00 |
| t7-component-reuse | 0.67 at `fc04b7c` (options-named 0/3) → 0.93 (5 runs) at `8ba56f4` | | 0.89 at `74ed983` (3 runs, re-measured) |

## Not re-run after the last text change (`8ba56f4` changed only designing-interactions' G2 wording)

- Every case except t7 and t27b.
- Cases that load designing-interactions and weren't re-run: t25k, t23e, t10.

## Untested

- Build notes winning over the references, as distinct from the checklist (t27c is a GUARD).
- The nudge when there is no plan folder at all.
- modelling-products adding a missing `Seen by` column to an old model.

## Cost (API-equivalent, on the subscription)

About $113:
- RED $11;
- GREEN rounds $56;
- regression $14;
- Opus $12;
- review-fix checks $7;
- the t7 comparison and fix $12.

The spec's estimate was $60–90.
