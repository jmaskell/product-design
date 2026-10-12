---
name: framing-problems
description: Use when an issue, request or idea arrives as a solution ("add a button", "make a page"), when the user outcome is unstated, or before any journey or screen work starts.
---

# Framing problems

`templates/` and `references/` sit two levels up; open them with Read.

## Recipe — fill every slot in templates/issue.md, in order

Write `docs/plans/<slug>/issue.md`, or the project's plan directory.

Keep issue.md to 60 lines, one sentence per prose slot. Every line in the file and reply that says what people do, need, know or feel ends with its tag.

1. **Outcome.** What is true for the person when this works, in their words?
2. **Trigger.** What happens just before the need?
3. **Job.** Cite the job ID from docs/product/actors.md. If none fits, propose a candidate; do not stretch one. Formulations: references/jobs-to-be-done.md.
4. **Current workaround.** What they do today.
5. **Previous and next step.** What the person does just before and after.
6. **Evidence ledger.** Tag every claim about people (references/evidence-ledger.md).
7. **Alternatives to the request.** At least one other way to reach the outcome or remove the trigger. Keep the request if it wins, and say why.
8. **Questions for the expert.** Each ASSUMED or UNKNOWN claim a decision needs, as a question, with the decision it blocks.
9. **Launch.** Propose the tier, audience and goal (references/lenses.md `## Launch tiers`), provisional. In `## Launch`, one bullet per tier question; no higher tier's.
10. **Rules for the owner.** For each PRODUCT.md constraint touched with no recorded interpretation (`Interpretation: UNKNOWN` or no line), add its readings (references/lenses.md `## Readings of a rule`) as one question. No verdict. No approval from anyone else. Write no decisions.md before G1. After the owner picks, update that row and point decisions.md to it. An open reading goes to the next gate.

## The reply, in this order

1. **File.** The path.
2. **Outcome.** The outcome, the trigger, and the step before and after, each tagged. Then the alternatives.
3. **Ledger.** Seven or fewer decision-relevant rows. Each row: a claim, then its tag: `KNOWN (source)`, `INFERRED (from what)`, `ASSUMED` or `UNKNOWN`.
4. **Launch.** The tier line, then each tier question as `<question>: <answer>`.
5. **Readings.** Per open rule: the readings, each as `<reading> — because <argument> — lets the product <what> — risk: <risk>`, per references/lenses.md. Give each its strongest case, the assertive one too. Then the blocked decision.
6. **Questions for <expert>.** Numbered, each with the decision it blocks. Ask whether a behaviour happens before you ask about it.

## Red flags — go back to step 1

| Thought | Reality |
|---|---|
| "The issue already says what to build" | The outcome decides what to build. |
| "Most likely cause …", "People feel X", "Nobody knows why they X" | Each states a feeling or behaviour as fact. A hedge is not a tag. Tag it ASSUMED or UNKNOWN. |
| "The expert should confirm this" | Write it as a question, with the decision it blocks. |
| "I'll sketch the screen to think" | Draw no screen until the journey. |
| "The code shows how users behave" | Code shows the system. Tag behaviour INFERRED. |
