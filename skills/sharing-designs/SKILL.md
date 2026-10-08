---
name: sharing-designs
description: Use when a design is at a gate and the team must review it, when asked to share a design, publish it for feedback or get the team's comments, or when asked to check the comments on a shared design.
---

# Sharing designs

Rebuild the page from the plan folder every time. Never edit it by hand.

## 1. Choose the target

Read `Review space` in the project metadata.

| Value | Target | Detail |
|---|---|---|
| `notion <url>` | A new row in that Notion database | notion.md |
| `artifact` | A private Claude artifact | artifact.md |
| unset | An artifact if the Artifact tool exists, else `<plan folder>/review.html` | artifact.md |

The owner's request wins. If the target needs a tool this session lacks, say so, ask the owner how to go on, and stop. Write no page or draft, in any format, and publish nowhere else.

## 2. Triage first

If decisions.md has a `Review page:` line, or the owner asks you to check the comments, run section 6 first.

## 3. Compose

Read templates/review-page.md, two levels above this skill's directory. Fill it from the plan files (issue.md, journey.md, design.md, decisions.md) and mocks/. Keep its headings in order. Write for people outside design work.
- Leave out Screens when design.md does not exist.
- Keep every evidence label as written.
- Each question names who answers it and when: "before we design screens" or "before we build".
- Never write G1, G2, tier, lens, CRITICAL, SIGNIFICANT or MINOR.
- Add nothing the files do not say.

## 4. Privacy check

Before every publish, check the page and every mock it embeds. Remove each name, address, contact detail and case detail that identifies a customer or a member of the public. Keep staff names and roles. A mock that holds such detail stays out, with its screen. Tell the owner what you removed and which mock to fix.

## 5. Publish and record

Publish with the target file. Append to decisions.md: `Review page: <target> <url or path> · revision <n> · <date>`. `<target>` is `notion`, `artifact` or `file`. The first revision is 1, then the last `Review page:` revision plus 1. Tell the owner the link, who to send it to, and what you need from each person. Only the owner approves a gate, never a comment.

## 6. Triage comments

Triage every comment with triage.md, in this directory, before you publish again.
