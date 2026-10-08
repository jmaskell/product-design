---
name: framing-problems
description: Use when an issue, request or idea arrives as a solution ("add a button", "make a page"), when the user outcome is unstated, or before any journey or screen work starts.
---

# Framing problems

A request names a solution. Your job is to find the outcome it serves, then decide whether the solution is the right one.

`templates/` and `references/` sit two levels above this skill's directory.

## Recipe — fill every slot in templates/issue.md, in order

Write `docs/plans/<slug>/issue.md`, or use the plan directory the project names.

Keep issue.md to 60 lines or less. One sentence per prose slot; the ledger and alternatives are short tables or lists. Every line that says what people do, need, know or feel ends with its tag.

1. **Outcome.** What is true for the person when this works? Write it in their words.
2. **Trigger.** What happens just before they need this?
3. **Job.** Cite the job ID from docs/product/actors.md. If none fits, propose a candidate job; do not stretch one. Formulations: references/jobs-to-be-done.md.
4. **Current workaround.** What do they do today? Tag it.
5. **Previous and next step.** Name what the person did just before and does just after.
6. **Evidence ledger.** Tag every claim about people (references/evidence-ledger.md). Untagged behaviour is a defect.
7. **Alternatives to the request.** Name at least one way to reach the outcome that is not the requested solution. Keep the request if it still wins, and say why.
8. **Questions for the expert.** Each ASSUMED or UNKNOWN claim a decision needs, as a question to the expert the project names, with the decision it blocks.

## The reply

Write the reply in this order:

1. **File.** The path.
2. **Outcome.** The outcome, the step before and the step after, each with its tag.
3. **Ledger.** The decision-relevant rows only, seven or fewer. Each row is a claim, then its tag in capitals: `KNOWN (source)`, `INFERRED (from what)`, `ASSUMED` or `UNKNOWN`. "This is an assumption" is not a tag.
4. **Questions for <expert>.** Numbered, each with the decision it blocks. Ask whether a behaviour happens before you ask about it.

Every other sentence about what people do or feel carries its tag too.

## Red flags — stop and go back to step 1

| Thought | Reality |
|---|---|
| "The issue already says what to build" | It names what someone asked for. The outcome decides what to build. |
| "Most likely cause …", "People feel X", "Nobody knows why they X" | Each states a feeling or behaviour as fact. A hedge is not a tag. Tag it ASSUMED or UNKNOWN. |
| "The expert should confirm this" | That is a statement. Write the question and the decision it blocks. |
| "I'll sketch the screen to think" | Screens come after the journey. Draw none here. |
| "The code shows how users behave" | Code shows the system. Tag behaviour INFERRED. |
