# Controls and dialogs

Which control to use, and where it goes. People look for a control next to the thing it acts on, and they expect a control to behave like others of its kind.

## Source
- Cooper, A., Reimann, R., Cronin, D. and Noessel, C. *About Face*. 4th ed. Wiley, 2014. Ch. 10 (pp. 240–243), ch. 18 (pp. 444–446), ch. 21 (pp. 593, 627, 659).
- Johnson, J. *Designing with the Mind in Mind*. 3rd ed. Morgan Kaufmann, 2020. Ch. 1 (pp. 3–4), ch. 5 (pp. 68–69), ch. 13 (pp. 227–229).
- Silver, A. *Form Design Patterns*. Smashing Media, 2018. Ch. 1 ("Button Styles"), ch. 2 ("Back Links"), ch. 4 ("Forgotten Password Link Placement").
- GOV.UK Design System, "Back link" component, https://design-system.service.gov.uk/components/back-link/. Confirmed by fetching (2026-10-21): the back link goes at the top of the page, before the main content, and is never used together with breadcrumbs.

## Authors' positions (our words)
- Cooper: a link moves through content and a button does something. A dialog is titled by its verb, or by the object it shows. A function that is part of the main task belongs next to the content it changes, not in a separate dialog. Place each function by how often it's used, how much it disrupts, and how risky it is.
- Johnson: people learn where repeated controls sit and press there without looking, so moving Back and Next between steps causes errors. A blocking dialog is hard to miss but costly; keep it for the risk of losing data.
- Silver: style actions as buttons and navigation as links. A back link sits at the top left. A secondary action must not get between the person and the main action.

## For and not for
For: choosing between link, button and dialog; where page, item and form controls sit. In build work and in design.
Not for: when to confirm or offer Undo (references/product-behaviour.md); wording (product-design:writing-ui-copy); visual styling (the project's visual-design tooling).

## Link or button
- A link goes somewhere. A button does something. Don't style one as the other.
- A secondary action can be a small button. It is still a button if it acts.
- Give both choices of a decision comparable weight. A faint link beside a bold button can push people into the costly one.

## Dialogs
- Title a dialog with its verb and object ("Delete saved search?"), or with the name of the thing it shows. Never "Are you sure?" or "Confirm".
- Keep the confirm and dismiss labels fixed while the dialog is open.
- A function people use as part of the main task goes beside the content it changes, not in a dialog.
- Keep a blocking dialog for the risk of losing data or an action that can't be undone. Routine errors show inline.

## Placement
Place a control by its scope:
- An action on the whole page goes in the page header, next to the heading.
- An action on one item goes on that item. In a list row, use icon buttons, each with an accessible name.
- A control that uses an input (an Add button) sits on the same line as that input.
- An action that comes before the main action sits above it, so the main action is last in reading and tab order.
- Back is a link at the top left, before the main content, apart from forward. It never sits beside breadcrumbs. Back and Next stay in the same place on every step.
- Frequent controls stay in reach. Rare, disruptive or risky ones sit further away, harder to hit by accident.
- Make the whole visible control clickable, including the label of a checkbox, radio button or toggle.

## One pattern per kind of thing
The same kind of thing looks and works the same across the product: one list style, one way to delete, one empty-state style. Reuse the component source before making a new pattern, and flag any new pattern (references/mocks.md).
