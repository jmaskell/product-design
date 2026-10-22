# Build review: GREEN record (2026-10-22)

Sonnet 5.5, judge Sonnet, on the subscription. Final text: `a2227f4`. Each batch ran from its own detached worktree, pinned to the commit named in its row. RED is in `2026-10-22-build-review-red.md`.

The without arm can't pass `skill-fired`, so its ceiling is (n−1)/n.

## Changes between GREEN rounds

1. **`6695077`:** Tasks 2–5.
   - designing-interactions writes a `Guard:` build note for each removed step, and a threshold state gives the exact comparison and what is counted.
   - The new `verifying-journeys` skill.
   - filing-issues adds a "Build matches design.md" criterion. writing-ui-copy offers the check and nudges with no plan folder.
   - The reviewer accepts only an owner ruling that issue.md or decisions.md records.
2. **`db4caf9`:**
   - Fixture: the build is wired into existing pages and routes. Without that, verifiers rightly reported an unreachable build.
   - Text: a change that adds no screen ends without the nudge.
   - Graders: t28 d3 and t22e no-nudge judge intent.
3. **`907e4ef`:**
   - Verifier: a string the copy deck doesn't list is MINOR, and the verifier's own view of the design is not drift.
   - Fixture: the copy deck lists the row strings.
   - Grader: t30 accepts the offer before the owner's questions, as its prompt asks.
4. **`0a23ff4`:** fixes from the final review.
   - writing-ui-copy offers the check for a designed change to an existing screen.
   - The States guidance in the template moved above the table.
   - New GUARD cases t30c and t22m, and a t28 `fresh-agent` grader.
5. **`a2227f4`:** verifying-journeys dispatches with the Agent tool and never checks in-session. writing-ui-copy says nothing about design on an undesigned existing screen.

## New and target cases (5 runs, both arms, unless noted)

| Case | With | Without | Text | Failing (with) | Label |
|---|---|---|---|---|---|
| t28-verify-build | 1.00 | 0.68 | `a2227f4` | — | GREEN (RED: no-generic 0/3, fresh-agent 1/5 at `0a23ff4`) |
| t28b-verify-clean | 1.00 | 0.13 | `907e4ef`; 1.00 (3, with) at `a2227f4` | — | GREEN |
| t29-guard-and-count | 0.93 | 0.27 | `6695077`; 1.00 (3, with) at `0a23ff4` | count 4/5 | GREEN (guard grader GUARD) |
| t30-build-offers-verify | 1.00 | 0.00 | `907e4ef`; 1.00 (3, with) at `a2227f4` | — | GREEN |
| t30b-issue-verify-line | 1.00 | 0.00 | `6695077` | — | GREEN |
| t30c-existing-screen-offer | 1.00 | 0.00 | `0a23ff4`; 1.00 (3, with) at `a2227f4` | — | GUARD (1.00 on the old text) |
| t31-designer-ruling | 1.00 | 0.00 | `6695077` | — | GREEN |
| t31b-nudge-no-plan | 1.00 | 0.33 | `6695077`; 1.00 (3, with) at `a2227f4` | — | GUARD |
| t22m-bugfix-no-answer | 0.90 | 0.30 | `a2227f4` | no-nudge 4/5 | GUARD (1.00 on the old text, 0.80 at `0a23ff4`) |

## Opus 5.5 (1 run, with arm, `907e4ef`)

- **1.00:** t28, t28b, t30, t30b, t31, t31b.
- **t29: 0.67.** It counted "refunds this agent has sent", not refunds the agent can open. It marked the count ASSUMED, so this is a different reading of whose refunds count. The judge flagged the long file as noisy.
- Not re-run on Opus after `0a23ff4` and `a2227f4`.

## Regression (with arm, 3 runs)

| Case | Score | Text | Earlier |
|---|---|---|---|
| t22, t22c, t25c, t25n, t13, t25k, t27f, t27e | 1.00 each | `db4caf9` / `907e4ef` | 0.93–1.00 |
| t27c, t27d, t22e | 1.00 each | `0a23ff4`, `a2227f4` | 1.00 |
| t25l-review-offer | 0.94 | `db4caf9` | 1.00 |
| t23-book-visit | 0.80 | `db4caf9` | 0.87 |
| t7-component-reuse | 0.78 | `db4caf9` | 0.67–0.93 |
| t27b-build-notes | 0.78 at `db4caf9`, 1.00 at `0a23ff4` | | 0.80–0.89 |

## Not re-run after the last text change (`a2227f4` changed only verifying-journeys step 3 and one writing-ui-copy sentence)

- t29, t30b, t31, and the designing-interactions, reviewer and filing regression cases.
- Opus, on every case.

## Untested

- verifying-journeys:
  - stops when there is no design.md;
  - writes verification.md in the stated format (the graders read the reply);
  - asks one batched question per finding;
  - falls back to a file list when git can't run (it did so in several runs, because git was blocked in the eval sandbox, but no grader checks it);
  - checks each actor's navigation;
  - sets `verified:` on a canonical journey that issue.md names.
- Running the app (out of scope).

## Cost (API-equivalent, on the subscription)

About $91:
- RED $13;
- GREEN rounds $42;
- regression $19;
- Opus $10;
- final-review cases $7.

The spec's estimate was $70–110.
