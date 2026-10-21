# Forms

How a form asks, when it checks the answers, and how it ends. A form serves the person filling it in first, and the database second.

## Source
- Silver, A. *Form Design Patterns*. Smashing Media, 2018. Ch. 1 ("A Registration Form": the question protocol, validation, error summary, live inline validation), ch. 2 ("A Checkout Form": hints, optional fields, check answers, confirmation).
- Cooper, A., Reimann, R., Cronin, D. and Noessel, C. *About Face*. 4th ed. Wiley, 2014. Ch. 8 (pp. 187–188), ch. 14 (pp. 326–329).
- Johnson, J. *Designing with the Mind in Mind*. 3rd ed. Morgan Kaufmann, 2020. Ch. 3 (p. 38), ch. 5 (pp. 63–65), ch. 10 (p. 174).
- GOV.UK Design System, "Check answers" and "Confirmation pages" patterns, https://design-system.service.gov.uk/patterns/. Confirmed by fetching (2026-10-21).

## Authors' positions (our words)
- Silver: every question must earn its place. Check answers on submit, not as people type. On a failed submit, show one summary of the errors and move focus to it. Forgive trivial differences in format. A hint may say why a question is asked.
- Cooper: rejecting input to protect the database works against the person. Accept partial or untidy input, flag what's missing without stopping the work, and never throw away the valid answers.
- Johnson: let the computer work out what it can. Show an error where the person is looking.
- GOV.UK: a check answers page comes just before submitting, with a change link per answer. A confirmation page gives the reference, what happens next and when, and how to get help.

## For and not for
For: any form, and any record people fill in. In build work and in design.
Not for: wording of labels and errors (product-design:writing-ui-copy); whether to confirm an action (references/product-behaviour.md).

## Asking
- Ask only what is needed now. Drop or defer a question nothing depends on yet.
- Don't ask for what the system knows or can work out (a county from a postcode, a total from its parts). Fill it in and show it.
- Mark the optional fields "(optional)". Leave required fields unmarked.
- Put a hint above the field, never as placeholder text.

## Why-hints
A hint that says why a personal detail is asked ("So we can text you when it's ready") stays when, without it, people refuse or leave. Otherwise cut it.

## When a form checks
The kind of form decides when it checks:
- **A form finished in one sitting** checks on submit. It doesn't check on each keystroke or on leaving a field.
- **A record built over time** (filled in over several calls or visits) saves with gaps. It marks what's missing in place ("Not given yet") and never blocks the save.

Both keep every valid answer after a failed check.

## Error summary
On a failed submit:
- show one summary at the top, listing each error as a link to its field;
- move keyboard focus to the summary;
- show each message again next to its field, above the input;
- clear the old errors before checking again.

## Untidy input
Accept the forms people type: spaces and dashes in numbers ("07700 900 123"), stray spaces, upper or lower case. Normalise in code before checking. Reject only what the system can't read.

## Check answers and confirmation
- A check answers page comes just before submitting a long or important form. It has a change link per answer, and a button that names the action ("Send application").
- The confirmation page:
  - says it's done and thanks the person;
  - shows the reference;
  - lists what happens next, and when, as numbered steps;
  - gives a way to get help;
  - has one main action.

## Back link
A multi-page form has a back link at the top left of each page, before the main content (references/controls-and-dialogs.md). The browser's Back button must also work and keep the answers.
