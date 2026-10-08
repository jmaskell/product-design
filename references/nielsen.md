# Nielsen's usability heuristics

## Source
- Nielsen, J. "10 Usability Heuristics for User Interface Design". Nielsen Norman Group, 24 April 1994; last reviewed 30 January 2024. Confirmed by fetching https://www.nngroup.com/articles/ten-usability-heuristics/ (2026-10-07).
- Nielsen, J. "Severity Ratings for Usability Problems". Nielsen Norman Group, 1 November 1994. Confirmed by fetching https://www.nngroup.com/articles/how-to-rate-the-severity-of-usability-problems/ (2026-10-07).

## Original
The ten heuristics, word for word (US spelling as in the source):
1. **Visibility of System Status.** "The design should always keep users informed about what is going on, through appropriate feedback within a reasonable amount of time."
2. **Match Between the System and the Real World.** "The design should speak the users' language. Use words, phrases, and concepts familiar to the user, rather than internal jargon."
3. **User Control and Freedom.** "Users often perform actions by mistake. They need a clearly marked 'emergency exit' to leave the unwanted action without having to go through an extended process."
4. **Consistency and Standards.** "Users should not have to wonder whether different words, situations, or actions mean the same thing. Follow platform and industry conventions."
5. **Error Prevention.** "Good error messages are important, but the best designs carefully prevent problems from occurring in the first place."
6. **Recognition Rather than Recall.** "Minimize the user's memory load by making elements, actions, and options visible. The user should not have to remember information from one part of the interface to another."
7. **Flexibility and Efficiency of Use.** "Shortcuts — hidden from novice users — may speed up the interaction for the expert user so that the design can cater to both inexperienced and experienced users."
8. **Aesthetic and Minimalist Design.** "Interfaces should not contain information that is irrelevant or rarely needed. Every extra unit of information in an interface competes with the relevant units of information."
9. **Help Users Recognize, Diagnose, and Recover from Errors.** "Error messages should be expressed in plain language (no error codes), precisely indicate the problem, and constructively suggest a solution."
10. **Help and Documentation.** "It's best if the system doesn't need any additional explanation. However, it may be necessary to provide documentation to help users understand how to complete their tasks."

Severity factors, word for word:
- "The **frequency** with which the problem occurs: Is it common or rare?"
- "The **impact** of the problem if it occurs: Will it be easy or difficult for the users to overcome?"
- "The **persistence** of the problem: Is it a one-time problem that users can overcome once they know about it or will users repeatedly be bothered by the problem?"
- Also: "One needs to assess the **market impact** of the problem…"

Severity scale, word for word:
| NN/g | Nielsen's words |
|---|---|
| 0 | "I don't agree that this is a usability problem at all" |
| 1 | "Cosmetic problem only: need not be fixed unless extra time is available on project" |
| 2 | "Minor usability problem: fixing this should be given low priority" |
| 3 | "Major usability problem: important to fix, so should be given high priority" |
| 4 | "Usability catastrophe: imperative to fix this before product can be released" |

## For and not for
The article: "They are called 'heuristics' because they are broad rules of thumb and not specific usability guidelines."
Our summary: for finding likely problems in a design without users present.
Our summary: not for proof. A heuristic names a risk. Two heuristics can point in opposite directions (8 against 7 is the common case).

## Our operationalisation
- Use the heuristics at flow level: across the steps of a task, not pixel by pixel.
- Rate each finding on frequency, impact and persistence. Then map it. This mapping is ours, not Nielsen's:

| NN/g | Our severity |
|---|---|
| 4 | CRITICAL |
| 3 | SIGNIFICANT |
| 1–2 | MINOR |
| 0 | not a finding |

- When one heuristic's fix breaks another (for example minimalism against shortcuts for experts), report both findings. Synthesis names the tension.
- Dimensions this lens covers: information clarity, user control, consistency, error prevention, error recovery, task efficiency, cognitive load.

Cite the principle by name and number. State the evidence in the artifact. A principle with no bearing on a named decision is not cited.
