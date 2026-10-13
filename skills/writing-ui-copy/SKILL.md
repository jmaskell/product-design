---
name: writing-ui-copy
description: Use when writing code that shows anything to a person (a screen, form, dialog, list or table column, message, email or notification), including plain build or bug-fix work with no design step, and even when the wording seems obvious. Nearly every such change writes text: labels, buttons, errors, placeholders, empty states.
---

# Writing UI copy

Load this before the first edit to anything a person sees, whatever the task is called. Copy written in passing during a build or a fix counts.

## Before writing

Read the project's copy rules in its instructions files (CLAUDE.md or any equivalent at the repo root), and the file the project metadata names as `Copy examples:`, if there is one. A project rule wins over a rule here. When a rule names the term to use, the copy uses it; avoiding the banned word is not enough.
Rule 'say order, never purchase': "Your purchase shipped" → "Your order shipped", not "It shipped"

## Rules

1. **Name the thing, give the action, stop.** Cut clauses that explain why a state exists.
   "Synced so everything stays up to date" → "Synced"
2. **Add no element the screen doesn't need.** For each new pill, badge, subtitle, helper line, tooltip or caption, ask: if it were gone, would the person lose something they need to act? If not, cut it. Cut by default: a status pill nobody asked for, a subtitle that restates the heading, helper text under a field whose label already says it, an explainer line under a button.
   Heading "Invoices" with subtitle "View and manage your invoices" → heading only
3. **No provenance or audience captions** ("Auto-generated", "Admin only", "Set by your manager", "Imported from…"), unless a project rule requires one on that surface.
4. **No hedging or disclaimers.** No stacked softeners, no boilerplate deferrals.
   "This may possibly take a few minutes" → "Takes about 2 minutes"
5. **Buttons say what happens: verb + object.** Icon-only buttons and links get an accessible name that does the same.
   "OK" → "Send invoice"; "Click here" → "Read the refund policy"
6. **Errors say what happened, then what to do**, in the person's words. No codes, no blame, never "Something went wrong" on its own.
   "Invalid date" → "Choose a date after today"
7. **Empty states give the reason and the one next action.** No pep talk.
   "Nothing here yet! 🎉" → "No invoices yet" + "Create invoice"
8. **Destructive confirms name the specific thing (its name or title, not just its type) and the consequence.** The confirm button repeats the verb. The dismiss button says what it keeps, never a bare "Cancel".
   "Are you sure?" OK / Cancel → "Delete invoice INV-042? You can't undo this." Delete invoice / Keep invoice
9. **Conventions:** sentence case, one term per concept (project terms win), the project's locale.

## After writing

Check every string and element you added against these rules, and fix violations in place. Don't report the check unless asked.
