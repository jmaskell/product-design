---
name: verifying-journeys
description: Use when a build of a designed screen or flow is done and must be checked against its design.md, when asked to verify a build or check it matches the design, or when an issue's acceptance criteria ask for it.
---

# Verifying journeys

`templates/` and `references/` sit two levels up; open them with Read. verifier-prompt.md sits in this skill's directory.

The builder never verifies its own build. A fresh agent checks the code against design.md. This skill reports drift and never edits product code.

## 1. Find the design

Find the plan folder (the project's plan directory, default `docs/plans/<slug>/`) from the issue id, the branch name or the owner's words. Read design.md, journey.md, issue.md and decisions.md. With no design.md, stop: say no design ran, and offer product-design:designing-interactions for the screens that have none.

## 2. Find the build

`git diff <main branch>...HEAD --name-only`, or the files the owner names. If git can't run, list the files under the paths design.md and the issue name.

## 3. Check

Dispatch one fresh agent with verifier-prompt.md, the plan folder and the changed files. Use the project's reviewer agent type if it defines one. It checks, against design.md:
- each `## Build notes` bullet, including each `Guard:` and `Like:`;
- each `## States` row: its condition and what it counts;
- each `## Copy` string;
- each actor's navigation on the built routes.

## 4. Report

Overwrite `<plan folder>/verification.md`:

```
# Verification — <date> at <short commit>
Verdict: passes | fails — <one line>
| CRITICAL | SIGNIFICANT | MINOR |

<SEVERITY> · design.md <section> · <file:line>
Design says: <quote>
Build does: <what the code does>
Consequence: <who is doing what, and what goes wrong for them>

Generic bugs: not checked (code review)
```

Severity:
- CRITICAL: a `Guard:` isn't kept, or a person sees or counts data they can't open.
- SIGNIFICANT: a Build note, a States condition or a Copy string is broken in a way that changes what the person sees or does.
- MINOR: `Like:` drift in looks only; a shown string the deck doesn't list; punctuation or case in copy.

Report only drift from design.md. A bug that design.md says nothing about is code review's job: it gets no finding, no severity and no question, only the one "Generic bugs" line.

## 5. Set verified

With no CRITICAL or SIGNIFICANT finding, set journey.md's `verified:` line to `<YYYY-MM-DD> (<short commit>)`, and the same line on the canonical journey under docs/product/ when issue.md names one. Otherwise leave it as it is.

## 6. Reply

The verdict, the counts, then one batched question: for each finding, fix the code (the default) or change the design. A design change goes back to product-design:designing-interactions.
