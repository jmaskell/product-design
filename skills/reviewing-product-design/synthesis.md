# Synthesis

1. Collect all findings. Group duplicates; keep the highest severity.
2. Dismiss a finding only with a one-line reason. A CRITICAL finding needs evidence to dismiss. List every dismissal for G2.
3. Find tensions: two findings that recommend opposite changes, or a fix for one that worsens another lens. Name the trade-off: novice vs expert, visibility vs overload, control vs prevention, flexibility vs consistency, disclosure vs discoverability, speed vs accuracy.
4. For each tension, write a Tension entry in decisions.md (templates/decisions.md). State each option as a moment in a named person's task. Recommend one.
5. Rule only when one side has stronger evidence: `Ruling: <what> — <why> — <cost if wrong>`. A product-judgement tension goes to the owner at G2. Never average two recommendations.
6. Build the dimension table: outcome alignment, journey completeness, task efficiency, mental-model fit, information clarity, user control, error prevention, error recovery, cognitive load, accessibility, consistency, service continuity, evidence confidence. Each cell: holds / at risk / fails / cannot assess, with its worst finding. No total.
7. Revise once. Re-run only the lenses whose findings changed.
8. Append the review-record line to decisions.md.

Write no review file. Findings, dismissals and the dimension table go in the G2 reply. From the review, decisions.md gets only the Tension entries and the review-record line.
