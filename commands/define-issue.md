---
name: define-issue
description: Define a new tracker issue (or project with multiple issues) through a conversation. Explores the codebase, interviews the product owner, writes a draft, and posts to the configured tracker on approval.
tools: Read, Grep, Glob, Bash, Write, Edit, mcp__linear
model: opus
disable-model-invocation: true
---

Deprecated: use the product-design:filing-issues skill, or product-design:designing-products for new work.

Define a well-scoped tracker issue (or multi-issue project) through a conversation. Explores the codebase, interviews the product owner, writes a draft, and posts to the tracker on approval.

## Usage

```
/define-issue
/define-issue <brief description>
```

## Step 0: Read project metadata

CLAUDE.md is already in context. Look for the `## Project metadata` section to determine:
- **Tracker**: `linear`, `github`, or `none`
- **Tracker team** (linear only)
- **Plan directory**: where draft files live

If missing, ask for the values needed and offer to append the section.

## Step 1: Understand what you're working with

If an argument was passed, use it as the starting point. If not, ask the product owner what they want to build or fix.

Before asking any questions, explore the codebase to orient yourself:

- If the project has an issue template (commonly `docs/templates/feature-issue.md`), read it — that's the output format. Follow it exactly.
- Explore relevant source files based on the topic — use your judgement about what's relevant. Don't read everything; read what helps you ask better questions and write a more accurate issue.

You are looking for:
- Whether similar functionality already exists
- Which parts of the codebase are likely to be affected
- Anything that suggests the feature is more or less complex than it sounds

Only read project architecture docs if the topic touches a known architectural boundary (auth, data access, core engine, encryption, etc.). Don't read them by default.

Do this exploration silently. Don't narrate it. Surface findings in your questions and in the issue itself.

## Step 2: Check for duplicates

Search existing issues for overlapping work, using the configured tracker:

- **linear** — `mcp__linear` `list_issues` with relevant keywords
- **github** — `gh issue list --search "<keywords>"`
- **none** — skim `<plan-dir>/*/issue.md` (folders are named `<n>-<slug>`) for existing plans covering the same work

If you find potential duplicates or related issues, surface them: "JAM-XX looks related — is this the same work, or separate?"

Do this before the interview so you don't waste time defining something that already exists.

## Step 3: Interview the product owner

Ask focused questions to fill gaps. Prioritise:

1. **Problem clarity** — what's the actual user problem? What happens today that shouldn't, or what's missing?
2. **User** — who exactly? Use the project's domain language from CLAUDE.md.
3. **Scope** — what's definitely in, what's definitely out?
4. **UX direction** — layout preferences, interaction patterns, mobile requirements, tone/feel. These feed directly into `/ux-designer`.
5. **Success** — how will we know it's done?

Keep questions tight. 3-5 at a time maximum. Don't ask about things you can infer from the codebase. Don't ask about implementation — that's for the architect.

Iterate until you have enough to write a complete, accurate issue. Push back if the scope is vague or the problem statement is weak — a poorly defined issue wastes build time.

## Step 4: Assess scope

Before writing, assess whether this is a single issue or a multi-issue project.

**Signals that it's a project:**
- Multiple distinct user-facing capabilities that could ship independently
- Work that would need multiple PRs (e.g. data model changes, then UI, then integrations)
- Acceptance criteria that naturally group into separate deliverables
- The product owner describes it as "a few things" or lists several related features

**If it looks like a project**, flag it explicitly:

> "This breaks down into N separate pieces of work. I'd recommend creating a tracker project with individual issues for each — they'll each go through the full workflow independently. Sound good?"

If the product owner agrees, follow the **Project path** in Step 5. If they want to keep it as one issue, follow the **Single issue path** — but note the risk if scope is genuinely too large.

## Step 5: Write the draft

### Single issue path

Write the issue to `<plan-dir>/ISSUE-DRAFT.md` using the project's issue template if present, otherwise this minimal structure:

```markdown
# [Title]

## Problem
[What's the user problem? Why does this matter?]

## Desired outcome
[What does the user experience after this is done?]

## UX direction
[Constraints, preferences, references for /ux-designer to work with]

## Acceptance criteria
- [ ] [Independently verifiable criterion]
- [ ] ...

## Out of scope
- [Specific things this issue does NOT cover]

## Context
[Any architecture decisions, related issues, or background that informs the work]
```

Show a summary in the terminal (title + acceptance criteria only) and ask the product owner to review the file.

### Project path

Write to `<plan-dir>/PROJECT-DRAFT.md` with this structure:

```markdown
## Project: [Name]

[2-3 sentence vision. What this project delivers overall and why.]

### Breakdown

| # | Issue title | User | Summary |
|---|-------------|------|---------|
| 1 | ... | [user role] | One-line summary |
| 2 | ... | [user role] | One-line summary |

---

### Issue 1: [Title]

[Full issue using the template above or the project's issue template]

---

### Issue 2: [Title]

[Full issue]
```

Each issue follows the same template. Keep the interview lighter for subsequent issues — the project context carries.

Show the breakdown table in the terminal and ask the product owner to review the file.

**Quality bar for every issue:**

- Problem section explains the *why*, not just the *what*
- Desired outcome is from the user's perspective, not the engineer's
- UX direction gives enough constraints for `/ux-designer` to work without guessing
- Acceptance criteria are independently verifiable — each one can be checked without ambiguity
- Out of scope is specific enough to prevent scope creep in the build
- Context references any architecture decisions that apply
- The issue is complete enough that `/ux-designer` and `/architect` can run without needing to ask the product owner basic questions

## Step 6: Iterate

Ask the product owner to review the draft file. Incorporate any changes. Repeat until they confirm they're happy.

Do not post to the tracker until explicitly told to.

## Step 7: Post to the tracker

When the product owner approves, post based on the configured tracker:

### linear — single issue
- Use `save_issue` to create the issue
- Team: from metadata
- Title: the feature name
- Description: the full content of the issue from the draft (as markdown — pass real newlines, not escape sequences)
- Set priority based on context (ask if unclear)
- Do not set assignee unless asked
- Output the Linear issue ID and URL

### linear — project
1. Create the project with `save_project` — name, summary (max 255 chars), team from metadata
2. Create each issue with `save_issue` — set `project` to the new project name
3. If issues have a natural order, note dependencies in each issue's Context section (don't use `blocks`/`blockedBy` unless there's a hard dependency)
4. Output the project URL and all issue IDs

### github — single issue
- `gh issue create --title "..." --body-file <plan-dir>/ISSUE-DRAFT.md`
- Apply labels if the project workflow uses them
- Output the issue URL

### github — project
- Create a milestone (or use Projects v2 if the repo uses that): `gh api repos/:owner/:repo/milestones -f title="..."`
- Create each issue with `gh issue create --milestone <number> --title ... --body-file <draft-file>`
- Output the milestone URL and all issue numbers

### none

Mint a new plan folder per issue (one for a single issue; all of them for a project):

1. **Pick the id.** Glob `<plan-dir>/*/` to find existing folders — they are named `<n>-<slug>` with a numeric prefix. Set `<n>` to one above the highest existing numeric prefix. The canonical id is `<id>` = `PLAN-<n>` (the `PLAN-` prefix lives in frontmatter and chat only, never in the folder name).
2. **Derive the slug** from the title: lowercase ASCII letters, digits and hyphens only; strip non-ASCII; collapse whitespace to single hyphens; drop punctuation; truncate at 60 chars on a word boundary. The slug is durable once chosen.
3. **Create the folder** `<plan-dir>/<n>-<slug>/` (numeric prefix, no `PLAN-`) and write `issue.md` inside it. Start with a frontmatter block delimited by `---`, fields in this canonical order, then the issue body below it:
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
   legacy_linear_id: null
   linear_url: null
   ---

   # <id> — <issue title>

   [Issue body from the draft]
   ```
   For a project, set each sub-issue's `parent` to the parent `<id>` and list child ids in the parent's `sub_issues` (e.g. `[PLAN-149, PLAN-150]`). Values are plain strings, ISO dates, `null`, or single-line lists — no quoting, no nesting.
4. Commit the new folder(s). These `issue.md` files are the source of truth for the rest of the workflow — `/ux-designer` and `/architect` read from `<plan-dir>/<n>-*/issue.md`.

After posting, stop. Do not run `/ux-designer` or any other agent.

## Rules

- Explore the codebase before asking questions — don't ask things you can find out yourself
- Never ask about implementation details — that's the architect's job
- Push back on vague scope or weak problem statements
- Use the project's issue template if present, exactly as written
- Draft files go in `<plan-dir>/` — overwrite them freely during iteration
- Match the project's locale and language conventions (CLAUDE.md usually states this)
- Issue descriptions should be concise — no corporate padding
