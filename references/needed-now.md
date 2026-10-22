# Needed now

A true element may not be needed now. Ask before you shorten it.

## The element test
An element is a line, pill, field, column, panel, control, state or step. For every element on a screen, check step, result or email, ask: "If this were gone, would this person do something wrong, or not know what to do next?" If not, cut it.

## Rules
Every rule below yields to `## Not a cut`.
1. Don't describe a limit the control already enforces. If the UI stops it (a disabled day, a missing option, a capped stepper), don't explain it, and don't write an error for a choice the person can't make. An action that can't run yet still keeps its reason (references/product-behaviour.md).
2. A check step shows the summary and the button, once. It doesn't repeat the summary, and it doesn't list what follows (emails, reminders). It names who receives a message the action sends; the result doesn't.
3. Explain once, at first use. A page people come back to carries no onboarding line.
4. Don't show a count that the same row, a header, a badge or the next screen already shows.
5. A result says what happened. It doesn't list the side effects (emails sent, reminders set, who was told).
   Exception: when a person finishes a commitment (they pay, sign up or apply), the result ends their journey and is what they remember (peak-end, references/cognitive-principles.md). Say it's done, thank them, show the reference, number the next steps, give a help route and one next action.
6. Keep a helper line only if it stops a likely mistake you can name.
7. A check step's heading says the action isn't done yet: "Confirm your booking", not "Your booking", which reads as booked.
8. An empty part of a page is one short muted line, with no button. An empty page gives the reason and one action.
9. A step stays only if it stops a mistake you can name that a line beside the action can't stop. Merge the rest into the step before. How many steps a flow has is otherwise the project's call.
10. Don't ask for a value the system already has or can work out. Fill it in, or leave the field out.

## Also cut
- The same fact twice on one screen or in one email: a status pill and a sentence with the same status; a version list the summary already holds.
- An email row that repeats its heading.
- A read-only row nobody can act on.
- A list column people don't sort, scan or choose by. Secondary facts and flags belong on the item's own page.

## Not a cut
- A line that is the only place a fact shows. Before you cut it, find where else the person sees the fact. If nowhere, keep it.
- A line that stops a named mistake (rule 6).
- A status on each row of a list people work from all day. They pick the next item by it, and opening each item to find it costs them every time (Cooper et al., *About Face*, 4th ed., ch. 9, pp. 210–211; ch. 15, pp. 358–360).

## Before and after
| Where | Before | After | Rule |
|---|---|---|---|
| Class timetable | "Pick a day, then a time. You can book one class a day, up to 30 November." | Cut. Booked days don't open, and the arrow stops at the last week. | 1 |
| Class check step | The summary (day, time, coach), then "You're about to:" the same booking, the email, the reminder and "You'll have 3 classes left." | The summary and "Book this class" | 2, 4 |
| Class booked, fifth time | "What happens next" (invite, reminder, how to join) and "You now have 4 booked and 3 to book." | "Class booked. Wednesday 21 October, 10:20am, with Sam." | 3, 4 |
| Staff, block removed | "Block removed. 3 bookings cancelled. Ana, Ben and Cal have been emailed and texted. 'Phone Cal' and 3 'Rebook' tasks are on your Tasks." | "Block removed. 3 bookings cancelled. 4 new tasks are on your Tasks." | 5 |
| Membership paid | "Payment received." | "Membership paid. Thank you." Reference, 3 numbered next steps, a help email, one button | 5 exception |
| My tasks | "11 tasks" in the header (the menu badge says 11), and an Owner column that says you on every row | Both removed | 4, read-only column |
| Order page | A "Shipped" pill, then "Shipped on 3 March" | "Shipped 3 March", once | Same fact twice |
| Support tickets list | Pills under each subject: "Refund requested before", "VIP" | No pills. The ticket page shows them as one alert. | List column |
| Empty Activity panel | A large panel with an illustration and "Nothing here yet" | "No activity yet", one muted line | 8 |
| Refund | A "Review refund" step that repeats the amount and the card | One screen: the fields, "Refunds £40 to the card ending 4242.", the button | 9 |
| Order form | A Total field the person types, when the line items already add up to it | The total, shown | 10 |

## Kept on purpose
| Line | The mistake it stops |
|---|---|
| "(not checked)" after an email address staff typed | The caller reads it back, so the email doesn't go to a mistyped address. |
| "You pay nothing today." on the card step | Someone leaves when the card form appears. |
| The recipient's name before a send | A message goes to the wrong person. |
| The phone number in a "we couldn't reach you" email | It's the only place the number shows, and "Call us" can't dial from a computer. |
