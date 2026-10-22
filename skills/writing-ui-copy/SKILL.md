---
name: writing-ui-copy
description: Use when writing code that shows anything to a person (a screen, form, dialog, list or table column, message, email or notification), including build and bug-fix work, not only copy or design tasks, and even when the wording seems obvious. Nearly every such change writes text: labels, headers, buttons, errors, placeholders, empty states. Load it before the first such edit.
---

# Writing UI copy

Load this before the first edit to anything a person sees, whatever the task is called, including copy written in passing during a build or fix.

## Before writing

Read the project's copy rules in its instructions files (CLAUDE.md or similar), and the file the project metadata names as `Copy examples:`, if there is one. A project rule wins over a rule here. When a rule names a term, every string about that thing uses it. Avoiding the banned word, or naming the thing another way, does not follow the rule.
   Rule 'say order, never purchase': "Your purchase shipped" → "Your order shipped", not "It shipped" or "Your parcel shipped"

When the plan folder (docs/plans/<slug>/, or the project's plan directory) has a design.md with `## Build notes` for the screen, follow them: they record decisions made for this screen and win over the checklist below. When the change adds a screen and no design.md covers it (no plan folder, or one without design.md), build it, then end the reply: "No design ran for <screen>. Run product-design:designing-interactions for it?" When a design.md covers the screen, end the build reply: "Check the build against design.md? (product-design:verifying-journeys)" A change that adds no screen ends with neither line.

Then read what the change needs (two levels up):

| The change adds or changes… | Read |
|---|---|
| Any element a person sees | `references/needed-now.md` |
| An action, result, confirm or Undo | `references/product-behaviour.md` |
| A button, link, dialog or control placement | `references/controls-and-dialogs.md` |
| A form or record people fill in | `references/forms.md` |
| A layout, detail page or list | `references/visual-structure.md` |

## Rules

1. **Name the thing, give the action, stop.** Cut clauses that explain why a state exists. When the person pays, waits or gets something, give the number.
   "Synced so everything stays up to date" → "Synced"; "plus delivery" → "plus £4.99 delivery"
2. **Every element must be needed now.** Apply `references/needed-now.md` to every element; each cut yields to its `## Not a cut`. Cut by default: a status pill nobody asked for, a subtitle that restates the heading. No text or error for a limit the control enforces. A result says what happened, not its side effects.
   Heading "Invoices" with subtitle "View and manage your invoices" → heading only
3. **No provenance or audience captions** ("Auto-generated", "Admin only", "Imported from…"), unless a project rule requires one.
4. **No hedging or disclaimers.**
   "This may possibly take a few minutes" → "Takes about 2 minutes"
5. **Buttons say what happens: verb + object**, with no "the", "a" or "your", and so does a button's in-progress label. A check step's heading says the action isn't done yet: "Confirm your order", not "Your order". Icon-only buttons and links get an accessible name that does the same.
   "OK" → "Send invoice"; "Sending…" → "Sending invoice…"
6. **Errors say what happened, then what to do.** No codes, no blame, never "Something went wrong" on its own.
   "Invalid date" → "Choose a date after today"
7. **Empty states are sized to their place.** An empty part of a page is one muted line. An empty page gives the reason and the one next action. No pep talk.
   "Nothing here yet! 🎉" → "No invoices yet" + "Create invoice"
8. **Destructive confirms name the specific thing (by name, not just type) and the consequence.** The confirm button repeats the verb. The dismiss button says what it keeps. A plain "Cancel" is fine for closing an inline confirm of a reversible action, unless its verb is "cancel".
   "Are you sure?" OK / Cancel → "Delete invoice {number}? You can't undo this." Delete invoice / Keep invoice
9. **The person's words.** Use the product model's Terms. A thing several actors see has one name on all their screens: before naming it, read PRODUCT.md `## Terms` (`Seen by`) and search the code for the same data (its fields, not its name) on the screens other actors see. When the request's word differs from theirs, ask which to use. Use the reader's word, not the system's.
10. **Conventions:** sentence case, the project's locale. Copy-deck notes follow references/plain-prose.md.

## After writing

Check your work against these rules, the references you read and this list:
- Over 8 facts sit under three or more sub-headings in working order (reordering isn't grouping); page actions sit in the header.
- After a create or send, the person sees the changed thing. The line beside a send button names the recipient.
- No Undo once an email, payment or other outside effect has gone.
- List rows hold no flags.
- After a payment, sign-up or application, the page thanks them and numbers next steps.
- A one-sitting form checks on submit, focusing one error summary; a record filled over time saves with gaps marked.
- No field the system can work out. Links navigate; buttons act. Unavailable actions stay visible and use `aria-disabled`, never the `disabled` attribute, with the reason in their accessible description.

Fix each in place; don't report the check unless asked.
