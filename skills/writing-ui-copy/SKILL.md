---
name: writing-ui-copy
description: Use when writing code that shows anything to a person (a screen, form, dialog, list or table column, message, email or notification), including build and bug-fix work, not only copy or design tasks, and even when the wording seems obvious. Nearly every such change writes text: labels, headers, buttons, errors, placeholders, empty states. Load it before the first such edit.
---

# Writing UI copy

Load this before the first edit to anything a person sees, whatever the task is called. Copy written in passing during a build or a fix counts.

## Before writing

Read the project's copy rules in its instructions files (CLAUDE.md or similar), and the file the project metadata names as `Copy examples:`, if there is one. A project rule wins over a rule here. When a rule names the term to use, every string that refers to that thing uses it. Avoiding the banned word, or naming the thing some other way, does not follow the rule.
   Rule 'say order, never purchase': "Your purchase shipped" → "Your order shipped", not "It shipped" or "Your parcel shipped"

## Rules

1. **Name the thing, give the action, stop.** Cut clauses that explain why a state exists.
   "Synced so everything stays up to date" → "Synced"
2. **Every line must be needed now.** Before shortening, read `references/needed-now.md` (two levels up) and apply its line test and rules to each line and email row. Write no text or error for a limit the control already enforces. Cut by default: a status pill nobody asked for, a subtitle that restates the heading, helper text a field's label already says. Keep a line that stops a named mistake or is the only place a fact shows.
   Heading "Invoices" with subtitle "View and manage your invoices" → heading only
3. **No provenance or audience captions** ("Auto-generated", "Admin only", "Set by your manager", "Imported from…"), unless a project rule requires one on that surface.
4. **No hedging or disclaimers.** No stacked softeners, no boilerplate deferrals.
   "This may possibly take a few minutes" → "Takes about 2 minutes"
5. **Buttons say what happens: verb + object**, and so does a button's in-progress label. A check step's heading says the action isn't done yet: "Confirm your order", not "Your order". Icon-only buttons and links get an accessible name that does the same.
   "OK" → "Send invoice"; "Sending…" → "Sending invoice…"; "Click here" → "Read the refund policy"
6. **Errors say what happened, then what to do**, in the person's words. No codes, no blame, never "Something went wrong" on its own.
   "Invalid date" → "Choose a date after today"
7. **Empty states give the reason and the one next action.** No pep talk.
   "Nothing here yet! 🎉" → "No invoices yet" + "Create invoice"
8. **Destructive confirms name the specific thing (its name or title, not just its type) and the consequence.** The confirm button repeats the verb. The dismiss button says what it keeps, never a bare "Cancel".
   "Are you sure?" OK / Cancel → "Delete invoice {number}? You can't undo this." Delete invoice / Keep invoice
9. **Conventions:** sentence case, one term per concept (references/plain-prose.md; project terms win), the project's locale. Notes around strings in a copy deck follow plain-prose.md.

## After writing

Check every string and element you added against these rules, and fix violations in place. Don't report the check unless asked.
