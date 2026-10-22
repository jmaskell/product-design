# Build review: RED baseline (2026-10-22)

Sonnet 5.5, judge Sonnet, 3 runs per arm, on the subscription. Text: the upstream-decisions skill text plus the new cases, run from pinned worktrees: `1046d5c`, and `c1e3b60` for t28 and t28b after the fixture fix. Cost: $12.72 API-equivalent.

The without arm can't pass `skill-fired`, so its ceiling is (n−1)/n. No `verifying-journeys` skill exists yet, so `skill-fired` fails in both arms of t28 and t28b.

| Case | With | Without | Failing graders (with arm) | Label |
|---|---|---|---|---|
| t28-verify-build | 0.82 | 0.79 | `no-generic` 0/3: every reply lists the float pence bug among its findings and asks the owner about it; `skill-fired` 0/3 | RED on `no-generic` and `skill-fired`. D1–D5 are guard evidence: both arms find all five when design.md states them in checkable form (without arm: D3 2/3, D4 2/3). |
| t28b-verify-clean | 0.11 | 0.22 | `verified-set` 0/3: no run sets `verified:`; `no-invented` 1/3: generic bugs are reported as gaps that fail the build | RED |
| t29-guard-and-count | 0.67 | 0.33 | `count` 0/3: no design.md gives a condition for See all, or what it counts | RED on `count`. `guard` passes in both arms (GUARD). |
| t30-build-offers-verify | 0.50 | 0.00 | `offers-verify` 0/3: builds end without offering a check against design.md | RED |
| t30b-issue-verify-line | 0.50 | 0.00 | `verify-line` 0/3: the acceptance criteria have no "build matches design" line | RED |
| t31-designer-ruling | 0.50 | 0.00 | `ruling-not-recorded` 0/3: the reviewer accepts "(owner ruling)" written only in the Build notes | RED |
| t31b-nudge-no-plan | 1.00 | 0.33 | — The current nudge text already fires with no plan folder. | GUARD |

## Fixture fix between the two batches

At `1046d5c` the clean build lacked three states that design.md and the journey named: the over-total error, the provider error, and the check step for £20 or more. Both arms rightly failed it (t28b 0.00 / 0.00). At `c1e3b60`, drift and clean differ only in D1–D5, and design.md lists every state the build has.
