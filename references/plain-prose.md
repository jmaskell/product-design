# Plain prose

For plan files (issue.md, journey.md, design.md, decisions.md, copy decks) and the review page. UI strings follow product-design:writing-ui-copy.

A builder, a reviewer or the owner reads these files. Each scans for what they must act on.

## Rules
1. Open each section with what the reader needs at that moment: the decision, the ask or the change.
2. Use a list for anything a reader scans: changes, rules, questions, states, notes. Notes under a heading or a string are a list, even when older entries are not.
3. One fact per sentence. 20 words or fewer.
4. Active voice. Name who does it.
5. One word per meaning. Role words come from docs/product/actors.md. Keep a term once chosen.
6. State what is true now. The reason goes in decisions.md. Old wording stays in git. Never write a log of edits.
7. Cite a decision, mock or frame once per item, at its end.
8. Apply the line test in references/needed-now.md to each sentence. Read it for the builder or reviewer.

When you change a section, bring the whole section to these rules.
When copy in a plan file changes, change each mock that shows it in the same commit.

## Before and after
| Where | Before | After |
|---|---|---|
| Changes since the last share | "Changed since revision 2 (decisions 12 to 15): members book several classes in one step, up to 6 weeks ahead; the coach lead role is gone; 'Held' now reads 'Waiting for payment'." | - Members book several classes in one step.<br>- Booking opens 6 weeks ahead.<br>- "Coach lead" is gone. Coaches do that work.<br>- "Held" reads "Waiting for payment". |
| Summary | "This change: coaches set open hours, starts are staggered, members sign in with a code and book several classes, up to 6 weeks ahead, and move or cancel one." | - Coaches set open hours.<br>- Members book several classes at once, up to 6 weeks ahead.<br>- Members move or cancel a class. |
| Email note | "Every staff cancel sends this email whatever the settings (decision 9), and within 24 hours the text also goes when we hold a mobile (decision 4)." | - Sent on every staff cancel. (decision 9)<br>- Within 24 hours, a text also goes if we hold a mobile. (decision 4) |
| Pattern entry | One paragraph of 140 words: the layout, the controls, the disabled rules and the accessible names. | - One week, as 7 day rows.<br>- Arrows move a week. The last one stops at week 6.<br>- A full day is greyed and named ", no classes free". |
| Copy section | "'Up to 4 weeks' → 'Up to 6 weeks' (decision 14)" in a running log. | "You can book up to 6 weeks ahead." The reason is decision 14 in decisions.md. |
| Mock note | "Button size lg is 40px, so the mock uses 44px; aria-disabled gets opacity 50; design-system issue: a 44px icon button." | - Arrow buttons are 44px. The library's largest is 40px: design-system issue. |
