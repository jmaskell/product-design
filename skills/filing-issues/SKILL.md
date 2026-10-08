---
name: filing-issues
description: Use when a designed or defined piece of work is approved and must go to the tracker or a plan folder, when work must split into several issues, or for bugs and tooling that skip design.
---

# Filing issues

Read `Tracker` (`none`, `linear` or `github`) and `Plan directory` from the project metadata. Work that skipped design gets an issue.md from templates/issue.md first. `templates/` sits two levels above this skill's directory.

## 1. Check for duplicates

Search:

- `linear`: the tracker tool's issue search.
- `github`: `gh issue list --search "<keywords>"`.
- `none`: skim `<plan-dir>/*/issue.md`.

Name each possible duplicate and ask if it is the same work.

## 2. Split scope

The work is a project when it has capabilities that ship independently, needs more than one PR, or has acceptance criteria in separate deliverables. Recommend one issue per piece and a breakdown table: number, title, actor, one-line summary. When the owner keeps one issue, state the risk.

Give each issue of a project a `## Sequence boundary` section: its place in the order, the issues it depends on, and the work a later issue owns. End it with: "Do not design, plan or build that work here."

## 3. Number the plan folder (`none` only)

Before the merge, for each issue:

1. **Pick the id.** Set `<n>` to one above the highest numeric prefix in `<plan-dir>/*/`. The id is `PLAN-<n>`. The folder name has no `PLAN-` prefix.
2. **Derive the slug** from the title: lowercase ASCII letters, digits and single hyphens, cut at 60 characters on a word boundary.
3. **Move or create the folder** `<plan-dir>/<n>-<slug>/`. Start `issue.md` with this frontmatter, in this order:
   ```markdown
   ---
   id: <id>
   title: <issue title>
   status: backlog
   created: <today, YYYY-MM-DD>
   updated: <today, YYYY-MM-DD>
   tier: null
   parent: null
   sub_issues: []
   ---
   ```
   For a project: each child's `parent` is the parent id, and the parent's `sub_issues` lists the child ids.

## 4. Merge the plan folder to the main branch

At G2 approval the plan folder merges to the main branch as a docs-only commit. For `none`, the merge carries the numbered folders.

## 5. Post

Post only after the owner says to.

- `none`: the merged plan folder is the tracker. Post nothing more.
- `linear` / `github`: write the post body to `tracker-draft.md` in the plan folder. Post outcome, acceptance criteria, one line per decision, the PNGs of the chosen mock's key states when they exist, and permalinks at the merge commit to design.md, decisions.md and mocks/. Add any private mock link for outside reviewers. For a project, add each issue's sequence boundary. Work that skipped design posts only the issue.md content. For `github`, run `gh issue create --title "<title>" --body-file <draft path>`. For `linear`, use the tracker tool's save-issue action. For a project, create the milestone or project first.
- If the tracker tool is not available: keep the draft and say which tool is missing. Give one next action the owner can take now: the exact command, or the file to paste and where. With no merge yet, the action is: merge first, then post with permalinks at the merge commit. Offer no second route, such as "connect the tool". Do not report success.

After posting, stop.
