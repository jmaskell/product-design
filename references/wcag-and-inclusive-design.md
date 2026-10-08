# WCAG 2.2 and inclusive design

## Source
- W3C. *Web Content Accessibility Guidelines (WCAG) 2.2*. W3C Recommendation, this version 12 December 2024 (first published 2023). Confirmed by fetching https://www.w3.org/TR/WCAG22/, https://www.w3.org/WAI/WCAG22/Understanding/intro and https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/ (2026-10-07).
- Microsoft. Inclusive Design. Confirmed by fetching https://inclusive.microsoft.design/ (2026-10-07).

Unverified: the persona spectrum. The pages I opened do not show it. Secondary sources credit it to the Microsoft Inclusive Design toolkit (Kat Holmes). I did not open the toolkit manual.

## Original
WCAG 2.2 principles, word for word:
- Perceivable: "Information and user interface components must be presentable to users in ways they can perceive."
- Operable: "User interface components and navigation must be operable."
- Understandable: "Information and the operation of user interface must be understandable."
- Robust: "Content must be robust enough that it can be interpreted reliably by a wide variety of user agents, including assistive technologies."

New in WCAG 2.2 at levels A and AA (number, name, level as W3C lists them):
| Criterion | Level |
|---|---|
| 2.4.11 Focus Not Obscured (Minimum) | AA |
| 2.5.7 Dragging Movements | AA |
| 2.5.8 Target Size (Minimum) | AA |
| 3.2.6 Consistent Help | A |
| 3.3.7 Redundant Entry | A |
| 3.3.8 Accessible Authentication (Minimum) | AA |

W3C also lists 2.4.12, 2.4.13 and 3.3.9 at AAA, and: "4.1.1 Parsing is obsolete and removed from WCAG 2.2."

Microsoft's three principles, word for word:
1. Recognize exclusion: "We acknowledge bias and recognize exclusions that happen because of mismatches between people and experience."
2. Learn from diversity: "Inclusive Design puts people in the center throughout the process because their fresh, diverse perspectives are the key to true insight."
3. Solve for one, extend to many: "Everyone has abilities and limits. Creating products for people with permanent disabilities creates results that benefit everyone."

Microsoft: "Exclusion happens when we solve problems using our own biases."

Persona spectrum (Unverified, from secondary sources): one limit at three durations. Example: permanent (one arm), temporary (an arm injury), situational (a person who holds a child).

## For and not for
Our summary: WCAG is for testable success criteria on web content.
Our summary: WCAG is not for whether the design suits the person's task. A page can conform and still exclude.
Our summary: inclusive design is for finding who a design excludes, and why. It is not a conformance test.

## Our operationalisation
- Check each new control and interaction against WCAG 2.2 AA. Name the success criterion by number.
- Check the 2.2 additions by name: focus hidden under sticky parts, drag-only actions, small targets, help that moves, data asked twice, memory tests at sign-in.
- For each new control, name the focus destination after it acts, what a screen reader announces, and the meaning that colour alone carries.
- Walk the persona spectrum for the main actor: permanent, temporary, situational. Name the moment where each one is excluded.
- A failure of an A or AA criterion on the main task is CRITICAL or SIGNIFICANT. It is never MINOR.
- Dimensions this lens covers: accessibility.

Cite the principle by name and number. State the evidence in the artifact. A principle with no bearing on a named decision is not cited.
