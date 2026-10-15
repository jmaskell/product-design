# Needed now

Copy can be true and short and still not be needed at that moment. Ask whether a line is needed before you shorten it.

## The line test
For every line on a screen, check step, result or email: "If this line were gone, would this person do something wrong, or not know what to do next?" If not, cut it.

## Rules
1. Don't describe a limit the control already enforces. If the UI stops it (a disabled day, a missing option, a capped stepper), don't explain it, and don't write an error for a choice the person can't make.
2. A check step shows the summary and the button, once. It doesn't repeat the summary, and it doesn't list what follows (emails, reminders, who gets told).
3. Explain once, at first use. A page people come back to carries no onboarding line.
4. Don't show a count that the same row, a header, a badge or the next screen already shows.
5. A result says what happened. It doesn't list the side effects (emails sent, reminders set, who was told).
6. Keep a helper line only if it stops a likely mistake. Name the mistake. If you can't, cut the line.
7. A check step's heading says the action isn't done yet: "Confirm your booking", not "Check your booking" or "Your booking", which read as if it's already booked.

## Also cut
- The same fact twice on one screen or in one email.
- An email row that repeats its heading.
- A lede that describes what the page obviously is.
- A read-only row nobody can act on.

## Not a cut
- A line that is the only place a fact shows. Before you cut it, find where else the person sees the fact. If nowhere, keep it.
- A line that stops a named mistake (rule 6).

## Before and after
| Where | Before | After | Rule |
|---|---|---|---|
| Class timetable | "Pick a day, then a time. You can book one class a day, up to 30 November." | Cut. Booked days don't open, and the arrow stops at the last week. | 1 |
| Class check step | The summary (day, time, coach), then "You're about to:" the same booking, the email, the reminder and "You'll have 3 classes left." | The summary and "Book this class" | 2, 4 |
| Class booked, fifth time | "What happens next" (invite, reminder, how to join) and "You now have 4 booked and 3 to book." | "Class booked. Wednesday 21 October, 10:20am, with Sam." "What happens next" shows on the first booking only. | 3, 4 |
| Account home, every time they open it | "Reminders by email and text, 1 hour before." | The "Change reminders" link only | 3 |
| Sign-in | "The code works for 10 minutes." on the page, in the email preview and in the email body | Only in the code-expired error | 3, same fact 3 times |
| Booking email | Row "Where: online", then "At 10:20am, open the link below" | The line only | Email row repeats |
| Staff timetable | "7 of 10 places booked" on every row, under a "Booked" header | "7 of 10" | Same words on every row |
| Staff, block removed | "Block removed. 3 bookings cancelled. Ana, Ben and Cal have been emailed. Ana and Ben have been texted. 'Phone Cal' and 3 'Rebook' tasks are on your Tasks." | "Block removed. 3 bookings cancelled. 4 new tasks are on your Tasks." | 5 |
| Refund result | "£120 refunded to the card ending 4242. We emailed the reason. The return label is on Tasks." | "£120 refunded." | 5 |
| Payment failed email | Heading "Your £120 payment didn't go through", then the row "Amount · £120" | Heading only | Email row repeats |
| My tasks | "11 tasks" in the header (the menu badge says 11), and an Owner column that says you on every row | Both removed | 4, read-only column |
| Question flow intro | "Up to 8 questions about you and your setup. It takes about 2 minutes." The next screen shows "Step 1 of 8". | "It takes about 2 minutes." | 4 |
| Class check step heading | "Check your class" | "Confirm your class" | 7 |

## Kept on purpose
| Line | The mistake it stops |
|---|---|
| "Calendar events don't change your availability." | Staff block time in their calendar, and customers still book it. |
| "(not checked)" after an email address staff typed | The caller reads it back, so the offer doesn't go to a mistyped address. |
| "If you don't reach them, the lead closes." on the last try | A close nobody expected. |
| "You pay nothing today." on the card step | Someone leaves when the card form appears. |
| "Works on a Mac or a Windows PC." before a device question | A tablet user answers wrongly. |
| The phone number in a "we couldn't reach you" email | It's the only place the number shows, and "Call us" can't dial from a computer. |
