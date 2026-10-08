---
type: llm
---
The output keeps the draft file, says the tracker tool is not available, and gives one next action that posts the draft, with no second route.

PASS when all four hold:
1. The draft stays as a file in the repo.
2. The output says the tracker tool is not available in this session.
3. The output gives one next action that posts the draft, as concrete steps: a command to run, or a named file or folder and where it goes. One ordered sequence counts as one action, for example "merge docs/plans/x/ to main, then paste tracker-draft.md into a new issue". Other questions or tasks for the owner, such as a duplicate check, do not count against this.
4. The posting action has no second route beside it, such as "or connect the tool and rerun", and no vague step, such as "connect the tracker" that does not say how.
