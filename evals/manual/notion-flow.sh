#!/usr/bin/env bash
# Live end-to-end test of the sharing-designs Notion path against a real workspace. See README.md here.
set -uo pipefail

PLUGIN="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
HERE="$PLUGIN/evals/manual"
TEST_PAGE_URL="https://app.notion.com/p/Plugin-tests-3f65378ee4c080a78916edd79d24313f"
STEP="${1:-}"
TMP="${TMPDIR:-/tmp}"
WORK="${2:-${TMP%/}/notion-flow}"
WORK="${WORK%/}"
REPO="$WORK/repo"
LOGS="$WORK/logs"
STATE="$WORK/state.json"
STEP_TIMEOUT="${NOTION_FLOW_TIMEOUT:-570}"
FAILS=0

usage() {
  echo "usage: $0 <setup|share|comment|revise|check|recheck|all|cleanup|snapshot|verify-<step>|checks-<step>> [workdir]" >&2
  exit 2
}

N="mcp__notion__notion"
NOTION_READ="${N}-fetch,${N}-search,${N}-get-comments,${N}-query-data-sources"
NOTION_SKILL="$NOTION_READ,${N}-create-database,${N}-update-data-source,${N}-create-pages,${N}-update-page,${N}-get-users,${N}-create-file-upload,${N}-create-comment"
SESSION_TOOLS="Read,Write,Edit,Bash,Glob,Grep,Skill,Agent,TodoWrite,$NOTION_SKILL,mcp__playwright,Bash(curl https://upload.notion.com/*)"

HEADLESS="You are running headless. Nobody can answer questions: do not call AskUserQuestion and do not wait for a reply. Where you would ask the owner, use the answers below, state any other assumption, and go on."
OWNER_ANSWERS="The owner's answers, given in advance:
- If a Notion database or a database property is missing, yes: create it or add it.
- No Notion user matches a person: that is fine. I confirm \"no match\" for every name. Write those people as not in Notion.
- If you are told to save the database URL in the project metadata, do it now: edit the Review space line in AGENTS.md.
- Create Notion content only under the review space page in AGENTS.md."

# ---------- state and results ----------

state_get() {
  python3 - "$STATE" "$1" <<'PY'
import json, os, sys
p, k = sys.argv[1], sys.argv[2]
d = json.load(open(p)) if os.path.exists(p) else {}
v = d.get(k, "")
print(json.dumps(v) if isinstance(v, (dict, list)) else v)
PY
}

state_set() {
  python3 - "$STATE" "$1" "$2" <<'PY'
import json, os, sys
p, k, v = sys.argv[1:4]
d = json.load(open(p)) if os.path.exists(p) else {}
try:
    d[k] = json.loads(v)
except ValueError:
    d[k] = v
json.dump(d, open(p, "w"), indent=2)
PY
}

# Reads PASS/FAIL/SKIPPED lines on stdin, echoes them, logs them, counts FAILs.
record() {
  local step="$1" line
  while IFS= read -r line; do
    echo "$line"
    case "$line" in
      PASS*|FAIL*|SKIPPED*) printf '%s\t%s\n' "$step" "$line" >> "$WORK/results.tsv" ;;
    esac
    case "$line" in FAIL*) FAILS=$((FAILS + 1)) ;; esac
  done
}

# ---------- claude runs ----------

# run_claude <name> <max turns> <allowed tools> <prompt> <cwd> <mcp config>
# Writes logs/<name>.jsonl (stream-json) and logs/<name>.summary.json. A timed-out run resumes on the next call.
run_claude() {
  local name="$1" turns="$2" allowed="$3" prompt="$4" cwd="$5" mcp="$6"
  local log="$LOGS/$name.jsonl" sid args rc
  sid="$(state_get "${name}_session")"
  if [ -n "$sid" ] && [ "$(state_get "${name}_status")" = "timeout" ]; then
    echo "resuming timed-out session $sid" >&2
    args=(--resume "$sid")
    prompt="Continue the task where you stopped. The instructions are the same as before."
    log="$LOGS/$name.resume.jsonl"
  else
    sid="$(uuidgen | tr 'A-Z' 'a-z')"
    args=(--session-id "$sid")
    state_set "${name}_session" "$sid"
  fi
  local plugin_args=(--no-session-persistence)
  [ "$cwd" = "$REPO" ] && plugin_args=(--plugin-dir "$PLUGIN")
  local t0=$SECONDS
  (cd "$cwd" && perl -e 'alarm shift; exec @ARGV' "$STEP_TIMEOUT" \
    claude -p "$prompt" "${args[@]}" "${plugin_args[@]}" \
      --mcp-config "$mcp" --strict-mcp-config \
      --allowedTools "$allowed" --max-turns "$turns" \
      --output-format stream-json --verbose \
      < /dev/null > "$log" 2> "$LOGS/$name.stderr")
  rc=$?
  state_set "${name}_seconds" "$((SECONDS - t0))"
  python3 "$HERE/notion_flow.py" trace "$log" "$LOGS/$name.summary.json"
  if [ "$rc" -eq 142 ] || [ "$rc" -eq 14 ]; then
    state_set "${name}_status" "timeout"
    echo "TIMEOUT: $name stopped after ${STEP_TIMEOUT}s; run the step again to resume session $sid" >&2
    return 124
  fi
  state_set "${name}_status" "done"
  return 0
}

session_step() {
  local name="$1" turns="$2" prompt="$3"
  run_claude "$name" "$turns" "$SESSION_TOOLS" "$prompt" "$REPO" "$WORK/mcp.json"
  local rc=$?
  python3 "$HERE/notion_flow.py" show "$LOGS/$name.summary.json"
  return $rc
}

# Known Notion URLs: the Review space line in AGENTS.md and every Review page: line in decisions.md.
known_urls() {
  grep -ho 'https://[^ ]*notion[^ ]*' "$REPO/AGENTS.md" "$REPO/docs/plans/contractor-date/decisions.md" 2>/dev/null | sort -u | tr '\n' ' '
}

# The run page: a child of the test page that setup creates, so each run gets its own Design review database.
run_page() {
  local u
  u="$(state_get run_page_url)"
  echo "${u:-$TEST_PAGE_URL}"
}

# Read-only fetch of the run page, the Design review database, each row and each row's comments.
snapshot() {
  local name="snap-$1"
  rm -f "$LOGS/$name.jsonl"
  state_set "${name}_status" ""
  run_claude "$name" 6 "$NOTION_READ" "Read-only task. Do not create, change or comment on anything in Notion. You have few turns: make independent calls in parallel, in one turn.
Turn 1, all in parallel: notion-fetch on $(run_page), and notion-fetch on each of these URLs: $(known_urls). For each URL that is a page in a database (not the run page), also call notion-get-comments on it, with block-level discussions and resolved discussions included.
Turn 2: find the database titled \"Design review\" that is a child of $(run_page). List all its rows with notion-query-data-sources (SELECT * from its data source). In parallel, for each row you have not fetched yet, call notion-fetch and notion-get-comments on it.
Then reply with only one JSON object and no other text:
{\"databases\":[{\"title\":\"\",\"url\":\"\",\"data_source_url\":\"\"}],\"rows\":[{\"title\":\"\",\"url\":\"\"}]}" "$WORK/checks" "$WORK/mcp-notion.json" >/dev/null
  python3 "$HERE/notion_flow.py" snapshot "$LOGS/$name.summary.json" "$WORK/$name.json"
}

checks() {
  record "$1" < <(python3 "$HERE/notion_flow.py" "check-$1" "$WORK")
}

# ---------- steps ----------

step_setup() {
  rm -rf "$WORK"
  mkdir -p "$REPO" "$LOGS" "$WORK/checks" "$REPO/.shots"
  : > "$WORK/results.tsv"
  cat > "$WORK/mcp-notion.json" <<'EOF'
{"mcpServers":{"notion":{"type":"http","url":"https://mcp.notion.com/mcp"}}}
EOF
  cat > "$WORK/mcp.json" <<EOF
{"mcpServers":{
  "notion":{"type":"http","url":"https://mcp.notion.com/mcp"},
  "playwright":{"command":"npx","args":["-y","@playwright/mcp@latest","--headless","--isolated","--browser","chromium","--allow-unrestricted-file-access","--output-dir","$REPO/.shots"]}
}}
EOF
  (
    cd "$REPO" || exit 1
    git init -q
    git config user.name "Notion flow test"
    git config user.email "notion-flow@example.invalid"
    git config commit.gpgsign false
    cp -R "$PLUGIN/evals/fixtures/lettings/." .
    bash "$PLUGIN/evals/fixtures/plan-contractor-date.sh" g2
    printf '.shots/\n' >> .git/info/exclude
  ) || { echo "FAIL setup: scratch repo"; exit 1; }
  state_set repo "$REPO"
  run_claude newpage 4 "${N}-create-pages" "Create one page with notion-create-pages. Parent: the page $TEST_PAGE_URL. Title: Notion flow $(date '+%Y-%m-%d %H:%M'). Content: Test run of evals/manual/notion-flow.sh. Do nothing else. Reply with only the new page URL." "$WORK/checks" "$WORK/mcp-notion.json"
  local page
  page="$(python3 "$HERE/notion_flow.py" created-url "$LOGS/newpage.summary.json")"
  [ -n "$page" ] || { echo "FAIL setup: no run page created under the test page"; exit 1; }
  state_set run_page_url "$page"
  (
    cd "$REPO" || exit 1
    python3 - "$page" <<'PY'
import sys
p = "AGENTS.md"
s = open(p).read().rstrip("\n") + f"\n- Review space: notion {sys.argv[1]}\n"
open(p, "w").write(s)
PY
    git add -A && git commit -qm "fixture: lettings + contractor-date at G2"
  ) || { echo "FAIL setup: scratch repo"; exit 1; }
  state_set started "$(date +%s)"
  echo "setup: scratch repo at $REPO; run page $page"
}

step_share() {
  session_step share 80 "$HEADLESS
$OWNER_ANSWERS

Share docs/plans/contractor-date/ with the team."
  snapshot share
  checks share
}

step_comment() {
  local row
  row="$(python3 "$HERE/notion_flow.py" row-url "$WORK/snap-share.json" 1)"
  [ -n "$row" ] || { record comment <<< "FAIL comment: no revision 1 row in the share snapshot"; return; }
  state_set row1_url "$row"
  run_claude comment 20 "${N}-fetch,${N}-create-comment" "Post three comments on the Notion page $row. Read the page first with notion-fetch. Create exactly three new discussions with notion-create-comment, one call each, in markdown. Anchor each one to the block named below with selection_with_ellipsis. If an anchor fails, post that comment on the page itself, with no anchor. Do nothing else.
1. On question 1 in the Questions section: \"Yes, about one visit in five moves, usually the day before. — Priya Shah\"
2. On the \"Agree date\" row of the journey table, quoting the stage and the person as the page asks: \"Agree date, Contractor: contractors text the agent's mobile. — Tom Reed\"
3. On the repair-list screen: \"If the date changes, the old date stays on the list. — Tom Reed\"
Reply with only this JSON: {\"comments\":[{\"n\":1,\"anchored\":true,\"selection\":\"\",\"discussion_id\":\"\"}]}" "$WORK/checks" "$WORK/mcp-notion.json"
  python3 "$HERE/notion_flow.py" show "$LOGS/comment.summary.json"
  snapshot comment
  checks comment
}

step_revise() {
  session_step revise 150 "$HEADLESS When you reach a gate, present it and stop.

Revise the design in docs/plans/contractor-date/ for the next gate. Stop at the gate."
  snapshot revise
  checks revise
}

step_check() {
  session_step check 100 "$HEADLESS
$OWNER_ANSWERS

Check the comments."
  snapshot check
  checks check
}

step_recheck() {
  session_step recheck 80 "$HEADLESS
$OWNER_ANSWERS

Check the comments."
  snapshot recheck
  checks recheck
}

step_cleanup() {
  python3 "$HERE/notion_flow.py" cleanup "$WORK"
}

# ---------- main ----------

[ -n "$STEP" ] || usage
command -v claude >/dev/null || { echo "claude CLI not found" >&2; exit 2; }
if [ "$STEP" != "setup" ] && [ "$STEP" != "all" ] && [ ! -d "$REPO" ]; then
  echo "no scratch repo at $REPO: run setup first" >&2
  exit 2
fi

case "$STEP" in
  setup) step_setup ;;
  share|comment|revise|check|recheck|cleanup) "step_$STEP" ;;
  snapshot) snapshot manual ;;
  verify-*) snapshot "${STEP#verify-}"; checks "${STEP#verify-}" ;;
  checks-*) checks "${STEP#checks-}" ;;
  all)
    step_setup
    for s in share comment revise check recheck; do "step_$s"; done
    ;;
  *) usage ;;
esac

[ "$FAILS" -eq 0 ] || { echo "$FAILS check(s) failed" >&2; exit 1; }
