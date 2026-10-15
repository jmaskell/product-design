# Needed now: RED baseline (2026-10-15)

Spec: "needed now" rules from a real project review (75 cuts accepted), plus two stakeholder copy rules: a check step's heading says the action isn't finished, and copy uses no internal terms. Skill text at 550c60a (before any change).

Command per case: `claude plugin eval . --trust-plugin --no-publish --scaffold --allow-tools Bash Write Edit --model claude-sonnet-5-5 --judge-model sonnet --case <case> --runs 3 -j 6 --keep-temp --json evals/results/red-<case>.json`, with `ANTHROPIC_API_KEY` set. The traces show `apiKeySource: ANTHROPIC_API_KEY`. Sonnet 5.5, 3 runs per arm.

Scores are case means. `skill-fired` fails in every without-arm run by design (weight 1), so a without score of 0.67 can mean every behaviour grader passed.

| Case | With | Without | Failing graders (with) | Failing graders (without) | Status |
|---|---|---|---|---|---|
| t23-book-visit | 0.60 | 0.20 | check-heading 3/3, no-limit-text 3/3 | check-heading 3/3, no-limit-text 3/3, result-only 3/3 | RED |
| t23b-visit-email (reworked, red2) | 1.00 | 0.67 | none | none (skill-fired only) | GUARD |
| t23c-return-page | 1.00 | 0.44 | none | no-onboarding 2/3 | RED for without; with passes on current text (rule 2) |
| t23d-tighten (red2) | 0.86 | 0.57 | check-heading 3/3 | check-heading 3/3, cuts-side-effect 3/3 | RED |
| t23e-design-needed | 0.42 | 0.08 | needed-listed 3/3, mock-result-only 3/3, mock-no-limit-text 1/3 | needed-listed 3/3, mock-result-only 3/3, mock-no-limit-text 3/3, mock-check-once 2/3 | RED |
| t23f-review-needed | 0.22 | 0.22 | finds-p1 to p4 3/3 each, lens-ran 2/3 | the same | RED |
| t23g-internal-term | 1.00 | 0.67 | none | none (skill-fired only) | GUARD |

## Why each fails (from the files the graders judged)

- t23: the pick step validates weekdays and shows "Choose a weekday" as an error, while weekend days are already left out of the list (rule 1). The check step is headed "Check your booking" (rule 4). Without the plugin, the result screen lists the email and the text as well.
- t23d: every run keeps the "Check your visit" heading. Without the plugin, "This visit will also show on your repairs list" stays (rule 5 of the brief, a side effect).
- t23e: no design.md says per screen what the tenant needs to know. The after-booking mock lists the email, the text reminder and more. Without the plugin, the check mock also repeats the booking and states the weekday limit.
- t23f: the review runs Task walkthrough and Service. No lens reads the copy, so none of the four planted lines is quoted. The keeper is never flagged (keeper-not-cut passes in both arms).

## GUARD cases (not RED evidence)

- t23b: once the heading carries the day, time and contractor, no run repeats them in a row, with or without the plugin. Kept as a guard for emails.
- t23g: both arms turn `triage` and `awaiting_approval` into plain labels that name the landlord. Kept as a guard for internal terms. No skill text is added for that rule.

## Grader fixes during RED

- t23d `cuts-repeat` (red → red2): it failed a run that had deleted the "You're about to book" line, because the judge counted the phone-number keeper as repeating Who. The grader now names the sentence and exempts the keeper.
- t23b (red → red2): the judge passed one email and failed a near-identical one. The model's headings carried no facts, so no row could repeat them. The prompt now puts the facts in the heading, and the graders ignore the subject.

Cost: $10.17 API-equivalent, including the superseded first runs of t23b and t23d.
