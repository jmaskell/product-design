# Needed now: GREEN record (2026-10-15)

RED: `2026-10-15-needed-now-red.md`. Sonnet 5.5, `--judge-model sonnet`, with `ANTHROPIC_API_KEY` set (traces: `apiKeySource: ANTHROPIC_API_KEY`). Results are in `evals/results/` (gitignored), named `<wave>-<case>.json`.

Final skill text (blob @ commit):

| File | Blob | Last changed |
|---|---|---|
| skills/writing-ui-copy/SKILL.md | 703126b | 0073200 |
| skills/designing-interactions/SKILL.md | 0672a60 | e58a564 |
| skills/reviewing-product-design/SKILL.md | acdf26f | 7e545b5 |
| skills/reviewing-product-design/reviewer-prompt.md | 56ce1cc | 7e545b5 |
| references/needed-now.md | e48006c | 7e545b5 |

## New cases, 5 runs

| Case | With | Without | Failing graders (with) | Text the number came from | Status |
|---|---|---|---|---|---|
| t23-book-visit | 1.00 (with arm only, `green2`) | 0.24 (`green`, 5 runs) | none | final (7e545b5) | GREEN |
| t23c-return-page | 1.00 | 0.53 | none | 0073200 reference | GREEN |
| t23d-tighten | 1.00 | 0.57 | none | 0073200 reference | GREEN |
| t23e-design-needed | 0.95 (`green2`) | 0.05 | mock-no-limit-text 1/5 | final (7e545b5) | GREEN |
| t23f-review-needed | 0.90 | 0.27 | finds-p1 1/5, finds-p4 2/5 | final (7e545b5) | GREEN |
| t23b-visit-email | 0.93 | 0.67 | fact-once 1/5 | 0073200 reference | GUARD |
| t23g-internal-term | 1.00 | 0.67 | none | 0073200 reference | GUARD |

`skill-fired` fails in every without-arm run by design. In the two guard cases, the without arm's behaviour graders all pass.

## Waves

- writing-ui-copy, wave 1 (3 runs): t23 0.67. Two of three runs headed the check step "Your visit", and one wrote a "Choose a weekday" error for a day that can't be picked. The check-heading instruction was buried in rule 2. Wave 2 moved it into rule 5 ("A check step's heading says the action isn't done yet") and gave rule 2 "Write no text or error for a limit the control already enforces". Result: t23 0.87, then 0.92 at 5 runs.
- designing-interactions (5 runs): t23e 0.80, mock-check-once 3/5. The check mocks listed the email and text that follow, because needed-now.md rule 5 said a result needn't list side effects since "the check step already did". Rules 2 and 5 now keep that list off both screens. t23e then scored 0.95, and t23 1.00.
- reviewing-product-design (3 runs): t23f 0.83, finds-p2 3/3 failing, though every run reported the repeat in its own words ("Check repeated the When, Who and Repair rows in a paragraph. I cut it."). The grader now accepts a description, and t23f scored 0.90 at 5 runs.

## Grader changes after RED

- t23f `finds-p2`: accepts a description of the check-step repeat as well as a quote. The without arm still fails it 4/5.

## Regression (with arm, `--ablation none`, 3 runs)

| Case | Earlier | Now | Failing graders | Cost |
|---|---|---|---|---|
| t22-validation | 1.00 | 1.00 | none | $0.26 |
| t22b-empty-state | 1.00 | 1.00 | none | $0.23 |
| t22c-cancel | 1.00 | 1.00 | none | $0.26 |
| t22d-pill-creep | 1.00 | 1.00 | none | $0.22 |
| t22e-bugfix | 1.00 | 1.00 | none | $0.25 |
| t22j-plain-prompt | 1.00 | 1.00 | none | $0.23 |
| t5-dead-end | 1.00 | 1.00 | none | $1.05 |
| t9-rationale-pressure | 1.00 | 1.00 | none | $1.03 |
| t12-project-rule-wins | 1.00 | 1.00 | none | $2.94 |
| t19f-reading-in-design | 0.88–0.92 | 0.93 | reply-merit 1/3 | $3.10 |
| t7-component-reuse | 0.93 | 0.78 (3 runs), 0.93 (5 runs) | 3 runs: one run failed hand-built-flagged and options-named; 5 runs: options-named 1/5 | $1.57 + $3.51 |

t7 has ranged from 0.67 to 1.00 across sweeps. Its 5-run score matches the earlier record, so no text changed.

## Opus 5.5 (1 run, with arm, final text)

t23 1.00 ($0.31), t23c 1.00 ($0.15), t23d 1.00 ($0.12), t23e 1.00 ($2.42), t23f 1.00 ($2.22). Traces: 237 assistant turns, all `claude-opus-5-5`.

## Not re-run after the last text change

- t23b, t23c, t23d, t23g: their GREEN runs used the 0073200 reference. 7e545b5 changed needed-now.md rules 2 and 5 (check step and result side effects). t23c, t23d and t23b don't build a check step or a result. Unverified for t23d, which is a check step: it ran 1.00 on Opus with the final text.
- Dropped to keep cost down (owner instruction, 2026-10-15): t4, t10, t14d, t19c, t22i. Not run on Opus: t23b, t23g.

## Untested spec lines

- The Needed now lens lists each line it keeps with the mistake it stops (reviewer-prompt.md, added after the final review). t23f re-ran at 0.89 with it, but no grader checks the list.

- "Explain once, at first use": t23c covers a return page, but no case shows the first-use version of the line.
- "A read-only row nobody can act on", and "the same fact on the page, in the email preview and in the email body" (needs a multi-surface case).
- Lens severity split (MINOR, or SIGNIFICANT on every visit or row): no grader checks severity.

## Final review fixes (fresh reviewer, Opus)

- reviewer-prompt.md: the lens lists each line it keeps, with the mistake it stops (a spec line that was missing).
- designing-interactions step 3: "doesn't list the side effects again" became "doesn't list the side effects". "Again" is the wording behind t23e's mock-check-once 3/5.
- README: the lens runs on Medium or Large designs with mocks, not on every design.

Re-run with the arm only, 3 runs, on the final text: t23e 1.00 ($2.16), t23f 0.89 (finds-p1 1/3, finds-p4 1/3; $2.21).

## Cost

$68.24 API-equivalent in total: RED $10.17, GREEN $33.83, regression $14.65, Opus $5.22, final review re-runs $4.37.
