# Product behaviour

How a screen behaves after the person acts. The screen should give a true picture of the system: every control keeps the promise its form makes, and every result shows where the person can see it.

## Source
- Cooper, A., Reimann, R., Cronin, D. and Noessel, C. *About Face: The Essentials of Interaction Design*. 4th ed. Wiley, 2014. Ch. 5 (p. 124), ch. 8 (pp. 181–188), ch. 9 (pp. 205–206), ch. 11 (pp. 257–262), ch. 12 (pp. 272–273, 297), ch. 15 (pp. 375–376), ch. 17 (p. 422), ch. 21 (pp. 651–653).
- Johnson, J. *Designing with the Mind in Mind*. 3rd ed. Morgan Kaufmann, 2020. Ch. 1 (pp. 4–5), ch. 14 (pp. 244–247), ch. 15 (pp. 269–273).
- Silver, A. *Form Design Patterns*. Smashing Media, 2018. Ch. 1 ("A Registration Form"), ch. 5 ("An Inbox").
- Norman's feedback and conceptual model: references/norman-and-walkthrough.md.

## Authors' positions (our words)
- Cooper: a routine "Are you sure?" trains people to press yes without reading, so it fails when it matters. Act, and make the action reversible. Work the person does only to serve the tool ("excise") should be removed first. A product should remember what it was told.
- Johnson: people stop reading a message they see every time. A control must show it registered a press almost at once, or people press again.
- Silver: a frequent action runs at once with Undo; a confirm suits rare, high-stakes actions. A disabled button hides what is wrong and can't be reached by keyboard.

## For and not for
For: actions, results, confirms, Undo, defaults, values shown from elsewhere, and controls that can't be used yet. In build work and in design.
Not for: wording (product-design:writing-ui-copy), layout (references/visual-structure.md), or controls and dialogs as components (references/controls-and-dialogs.md).

## Feedback
- After an action, show the thing it made or changed, in its new state: open the new record, or update the row in place. Don't move the person somewhere unrelated with a banner.
- Size the feedback to the wait. A pressed state at once. A busy state if the result takes more than a moment. Progress, with a percentage or a count, if it takes several seconds. A note on what's happening and a way to cancel if it takes longer.
- A change that lands away from where the person is looking (a total, a price) gets a brief highlight.

## Undo and confirm
- A routine action that can be reversed runs at once, with Undo in its result.
- Offer Undo only where it truly reverses the action. An effect that has left the app (a message sent, money moved, a call to another system) can't be reversed.
- An action that notifies someone or starts another process does one of two things:
  - holds the effect for a short window, with Undo, and says so: "Closing #812. Ana Silva is emailed in 10 s. Undo";
  - or confirms first and names who is told.
- Keep a confirm for an action that can't be undone or has high impact. Make the safe choice the default, and name the thing and the consequence.
- After the effect has left the app, recovery is a named follow-up action: "Withdraw invitation", "Refund", "Send correction". Never label it Undo.

## Values from elsewhere
- A value that refers to something owned elsewhere (a price list, a policy, terms that apply to every item) shows read-only where it's used, with a way to reach where it's owned. An editable field says "this varies here", and the two copies drift apart.
- A value copied to be changed (a document template, a draft, a default) stays editable.
- When the issue or the project doesn't say which, ask.

## Defaults and remembered answers
- Start with a likely default: the person's last choice, the most common one, or the obvious one. Don't open with a questionnaire.
- Don't ask again for what the person already told the product, or for what the system can work out.
- Keep settings few, with good defaults.

## Work that serves the tool
List each step as goal work or tool work. Tool work serves the system, not the person: re-entering known data, confirming routine actions, filing things for the database. Remove or automate tool work first.

## Posture
- A tool people use all day can be dense, and can show status on every row, because they learn it.
- A screen people use once must be plain, with its main action unmistakable.
- Name which one a screen is before choosing its density.

## Removing a step
When you remove or merge a step, list what it was quietly guarding (Enter submitting the form, a double submit, a send to the wrong person), and keep each guard in the new design.

## Unavailable actions
When an action can't happen yet:
- keep it visible and reachable by keyboard;
- mark it `aria-disabled="true"`, not with the `disabled` attribute;
- give the reason as its accessible description, so a screen reader announces it, and show the same reason on hover and focus.

Don't add a helper line that explains the system.
