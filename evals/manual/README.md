# Manual live tests

## notion-flow.sh

This script tests the Notion path of `sharing-designs` end to end, in a real Notion workspace. It writes to the owner-approved test page "Plugin tests" only. `notion_flow.py` holds the parsing and the checks.

Run one step per call. Each step takes less than 10 minutes:

```
evals/manual/notion-flow.sh setup   [workdir]   # scratch repo (lettings fixture + contractor-date at G2) and a run page
evals/manual/notion-flow.sh share   [workdir]   # "Share docs/plans/contractor-date/ with the team."
evals/manual/notion-flow.sh comment [workdir]   # posts 3 signed comments on the revision 1 row
evals/manual/notion-flow.sh revise  [workdir]   # "Revise the design ... Stop at the gate."
evals/manual/notion-flow.sh check   [workdir]   # "Check the comments."
evals/manual/notion-flow.sh recheck [workdir]   # "Check the comments." with no new comments
evals/manual/notion-flow.sh cleanup [workdir]   # prints the Notion URLs to archive by hand
```

`all` runs setup and the five steps in sequence. `verify-<step>` takes a new read-only snapshot and runs the checks for that step again. `checks-<step>` runs only the checks, on the snapshot that exists. The default workdir is `$TMPDIR/notion-flow`. The workdir keeps the state (`state.json`), the traces (`logs/*.jsonl`), the snapshots and `results.tsv`.

Each step prints `PASS`, `FAIL` or `SKIPPED` for each check. The script exits 1 if a check fails. If a session stops at the timeout (`NOTION_FLOW_TIMEOUT`, default 570 s), run the same step again: the script resumes that session.

Requirements:
- The `claude` CLI, signed in to Notion through the hosted MCP (`https://mcp.notion.com/mcp`).
- `npx` for `@playwright/mcp`, with Chromium installed. The script adds `--allow-unrestricted-file-access` so that the browser can open the `file://` mocks.

Warnings:
- `setup` creates a new child page under the test page for each run and puts its URL in the Review space line. Each run gets its own "Design review" database. Archive the run page by hand after the run.
- The sessions use your user settings. The sessions allow `Bash(curl https://upload.notion.com/*)`, but a `deny` rule for `Bash(curl *)` still stops the screenshot upload. The page then shows the skill's "No screenshot" text.
- The fixture people are fictional. No Notion user matches them, so nobody gets a mention or a notification.
- The comments come from your own Notion account. Each comment names its author in its text.
