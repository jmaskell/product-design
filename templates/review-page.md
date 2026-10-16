# <title>
Write every section by references/plain-prose.md (two levels above the skills).
<date> · revision <n> · Size: <Small | Medium | Large>

## Changed since revision <n-1>
Leave this section out on revision 1. Take the changes from decisions.md and the plan files since the last `Review page:` line.
- <one change, in the reader's words; no decision numbers>

## Summary
- <the outcome, in the person's words> <label>
- Starts when: <trigger> <label>
- Today: <the current workaround> <label>
- This change: <one item per change in scope>
- Not in this change: <what is out>

**What we need from you**
- <name> (<role>): question <n>: <the question, in a few words>

## Who's involved
| Who | What they do | What changes for them | Check with |
|---|---|---|---|

## The journey, today and proposed
What changes for each person:
- <person>: <the change, in one line>

<details><summary>See the whole journey, step by step</summary>

| Today | <person> | <person> |
|---|---|---|
| <stage> | <what they do at this stage> | — |
| <stage> (this change) | <what they do at this stage> | <what they do at this stage> |

| Proposed | <person> | <person> |
|---|---|---|
| <stage> | <what they do at this stage> | — |
| <stage> (this change) | ◆ <what they do now> | <what they do at this stage> |

◆ marks a step that is different from today.
</details>

The two grids have the same rows and columns. One row per stage, in journey order. One column per person in the actors of issue.md and journey.md, named as in docs/product/actors.md. Add "(this change)" to each stage this change touches. In each cell, write what that person does at that stage. Write "—" when they do nothing, never "nothing" or a blank cell. Copy each unchanged cell into Proposed word for word. Start each Proposed cell that differs from Today with "◆ ". Write a step that stops as "◆ —". Keep the evidence labels in the cells where the plan files have them.

## Screens
Leave this section out until screens are designed.
Lay out every screen. Above them, add a **Play** control: it shows the chosen mocks one at a time, large, in the design.md Interface flow order, with Back and Next. Add a **Show design notes** control, off by default, that shows the notes in every mock.
### <screen name>
<the mock>
- Why: <rationale>. (decision <n>)
- Not chosen: <option> — <why>.

## Questions
| # | Question | Who answers | Needed |
|---|---|---|---|
| 1 | <question> | <name> | before we design screens / before we build / before release |

Keep every evidence label (KNOWN, INFERRED, ASSUMED, UNKNOWN) as the plan files write it, in plain text, for example `KNOWN (user interviews, 2026-08)`. Put no markup between the tag and its source.
