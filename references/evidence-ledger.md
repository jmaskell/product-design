# Evidence ledger

## Source
Bland, D. and Osterwalder, A. *Testing Business Ideas*. Wiley, 2019. Assumptions map: importance × evidence; desirability, viability, feasibility.
Confirmed by fetching the Strategyzer article by David J. Bland: https://www.strategyzer.com/library/how-assumptions-mapping-can-focus-your-teams-on-running-experiments-that-matter
Unverified: I did not read the book. The article is the source for the quotes below.

## Original
Bland defines it as "a team exercise where desirability, viability, and feasibility hypotheses are made explicit and prioritized in terms of importance and evidence."
The map puts evidence on the x-axis and importance on the y-axis. The top right quadrant holds "beliefs that are critical for success and yet have the least amount of evidence", so teams test there first.

## For and not for
Our summary: for deciding which claims to check before a decision depends on them.
Our summary: not for scoring claims on a numeric scale, or testing every claim.

## Our operationalisation
Every claim about what a person does, needs, knows or feels carries one tag:

| Tag | Use when | Write |
|---|---|---|
| KNOWN (source) | A named source shows it | `KNOWN (agent interviews, 2026-08)` |
| INFERRED (from what) | It follows from a KNOWN fact | `INFERRED (from triage friction)` |
| ASSUMED | You chose it to continue | `ASSUMED` |
| UNKNOWN | Nobody knows it and a decision needs it | `UNKNOWN` |

Rules:
1. A claim with no tag is a defect.
2. An ASSUMED or UNKNOWN claim that a decision depends on goes on "Questions for <expert>", with the decision it blocks.
3. Code shows what the system does. It never shows what people do. Tag behaviour inferred from code INFERRED.
4. The owner's statement is KNOWN (owner) for intent and constraints, and ASSUMED for user behaviour unless they name a source.
5. List only decision-relevant claims in the ledger. Tag the rest inline.
