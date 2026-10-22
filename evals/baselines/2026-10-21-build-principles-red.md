# Build principles: RED baseline (2026-10-21)

Sonnet 5.5, judge Sonnet, 3 runs per arm. Text under test:
- t25–t25n: the branch at `1bf333a` plus the new cases, run from the working tree before any rule text changed.
- All other cases: commit `36377da`, run from a pinned checkout.
- t25d: re-run at `d658976` after a grader fix.

Cost: $17.62 API-equivalent, including the t25d re-run.

The without arm can't pass `skill-fired`, so its ceiling is (n−1)/n. A without score at its ceiling means every content grader passed.

## Labels

- **RED:** the with arm fails a content grader.
- **RED (skill-caused):** the with arm fails where the without arm passes, so the current skill text causes the failure.
- **GUARD:** the with arm already passes, so the case guards against a regression. It is not RED evidence.

| Case | With | Without | Failing graders (with arm) | Label |
|---|---|---|---|---|
| t25-send-offer | 0.67 | 0.25 | lands-on-object 0/3 (both arms keep a "sent" state inside the form); says-recipient 2/3 | RED |
| t25b-undo-email | 0.92 | 0.75 (ceiling) | undo-real 2/3: one run showed Undo after the email had gone | GUARD; one false Undo in the with arm |
| t25c-applicant-page | 0.33 | 0.00 | grouped 0/3 (one flat list); header-actions 0/3 (actions at the foot) | RED |
| t25d-applicant-flags | 0.67 | 0.22 | no-list-flags 0/3 in both arms: a Flags column on the list (flags-on-page 3/3) | RED |
| t25e-holding-deposit-done | 0.67 | 0.33 | done-moment 0/3: no thanks on the done page | RED |
| t25f-amounts | 1.00 | 0.50 (ceiling) | — | GUARD |
| t25g-one-name | 0.50 | 0.00 | one-name 0/3: "templates" used and the clash not raised | RED |
| t25h-inline-cancel | 0.50 | 0.50 (ceiling) | cancel-ok 0/3: "Keep applicant", from current rule 8 | RED (skill-caused) |
| t25i-empty-panel | 1.00 | 0.50 (ceiling) | — | GUARD |
| t25j-template-editable | 1.00 | 0.50 (ceiling) | — | GUARD |
| t25m-list-status | 1.00 | 0.50 (ceiling) | — | GUARD |
| t25n-unavailable | 0.50 | 0.00 | focusable-unavailable 0/3: the `disabled` attribute, no announced reason | RED |
| t25k-design-offer | 1.00 | 1.00 | — | GUARD |
| t25l-review-offer | 0.72 | 0.67 | p4 0/3 (mid-page actions never reported); p3 2/3; p5 2/3 | RED |
| t26-form-check | 0.60 | 0.33 | on-submit 0/3 and summary-focus 0/3: errors only beside fields, no focused summary | RED |
| t26b-record-gaps | 0.50 | 0.33 | saves-gaps 0/3: saves, but nothing marks what's missing (without arm 2/3) | RED (skill-caused) |
| t26c-routine-undo | 0.89 | 0.56 | undo 2/3 in both arms | GUARD (near ceiling) |
| t26d-derived-field | 0.67 | 0.33 | no-county 1/3: an empty County field (without arm 2/3) | RED (skill-caused) |
| t26e-audience-word | 1.00 | 0.50 (ceiling) | — | GUARD |
| t26f-wait-feedback | 1.00 | 0.50 (ceiling) | — | GUARD |
| t26g-labels-dialog | 0.75 | 0.50 | link-vs-button 0/3: "View" is a button | RED |
| t26h-split-actor | 1.00 | 0.00 | — (without arm wrote no actors.md) | GUARD |

## Grader fixes during RED

- t25d `flags-on-page` judged only the page file, while runs render flags through an imported component. It was briefly changed to `focus: files`, which gives the judge only the file paths. It now judges `ApplicantPage.tsx` and accepts an imported component.
- t25d `no-list-flags` widened to "shared email" and "flag".
- t26f's prompt claimed `uploadPhoto` takes a progress callback. It doesn't, so the answer now reads "You may change uploadPhoto".

## Run hygiene

Wave 1 edits landed while the Task 2 cases were running from the same working tree. The batch was stopped and re-run in full from a pinned detached checkout. From then on, every eval runs from a checkout pinned to a commit.
