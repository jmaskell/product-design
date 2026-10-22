# Upstream decisions: RED baseline (2026-10-22)

Sonnet 5.5, judge Sonnet, 3 runs per arm, on the subscription. Text: `9a69610`, the build-principles skill text plus the new cases, run from a pinned worktree. Cost: $11.00 API-equivalent.

The without arm can't pass `skill-fired`, so its ceiling is (n−1)/n.

| Case | With | Without | Failing graders (with arm) | Label |
|---|---|---|---|---|
| t27-terms-clash | 0.00 | 0.17 | asks-one-word 0/3: mapping names the thing "templates" and never asks; no-templates-stage 0/3 | RED |
| t27b-build-notes | 0.00 | 0.00 | notes-send, notes-applicant, like-line 0/3: design.md has no build notes | RED |
| t27c-follows-notes | 1.00 | 0.75 (ceiling) | — Both arms follow notes that are already in the files, including the owner ruling against the checklist | GUARD |
| t27d-no-design-nudge | 0.67 | 0.33 | flags-gap 0/3: the screen is built, and no reply mentions the missing design | RED |
| t27e-review-notes | 0.67 | 0.50 | header-mismatch 2/3; route-mismatch 2/3 | RED |
| t27f-like-screen | 0.33 | 0.33 | reports-drift 1/3: reviewers don't compare the list mock with the existing list | RED |

Targets carried from PR #8's GREEN record (not re-run here): t25g 0.50, t25c 0.80, t25n 0.80, t25 0.85, t25l 0.83.
