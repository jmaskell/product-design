"""Parsing and checks for notion-flow.sh. Each check prints PASS, FAIL or SKIPPED lines."""
import html
import json
import os
import re
import sys


def load(p, default=None):
    if not os.path.exists(p):
        return default
    with open(p) as f:
        return json.load(f)


def save(p, d):
    with open(p, "w") as f:
        json.dump(d, f, indent=2)


def text_of(content):
    if isinstance(content, str):
        return content
    out = []
    for c in content or []:
        if isinstance(c, dict) and c.get("type") == "text":
            out.append(c.get("text", ""))
        elif isinstance(c, dict):
            out.append(json.dumps(c))
    return "\n".join(out)


# ---------- trace ----------

def trace(log, out):
    calls, pending, result = [], {}, {}
    texts = []
    if os.path.exists(log):
        for line in open(log):
            try:
                ev = json.loads(line)
            except ValueError:
                continue
            t = ev.get("type")
            if t == "assistant":
                for c in ev.get("message", {}).get("content", []):
                    if c.get("type") == "tool_use":
                        call = {"name": c["name"], "input": c.get("input", {}), "output": None, "error": False}
                        pending[c["id"]] = call
                        calls.append(call)
                    elif c.get("type") == "text":
                        texts.append(c["text"])
            elif t == "user":
                content = ev.get("message", {}).get("content", [])
                if isinstance(content, list):
                    for c in content:
                        if isinstance(c, dict) and c.get("type") == "tool_result" and c.get("tool_use_id") in pending:
                            call = pending[c["tool_use_id"]]
                            call["output"] = text_of(c.get("content"))
                            call["error"] = bool(c.get("is_error"))
            elif t == "result":
                result = ev
    save(out, {
        "session_id": result.get("session_id"),
        "subtype": result.get("subtype", "no result (killed or crashed)"),
        "is_error": result.get("is_error", True),
        "num_turns": result.get("num_turns"),
        "cost_usd": result.get("total_cost_usd"),
        "duration_ms": result.get("duration_ms"),
        "result": result.get("result") or ("\n".join(texts[-3:]) if texts else ""),
        "calls": calls,
    })


def show(summary):
    s = load(summary, {})
    names = {}
    for c in s.get("calls", []):
        names[c["name"]] = names.get(c["name"], 0) + 1
    denied = [c["name"] for c in s.get("calls", []) if c["error"] and "permission" in (c["output"] or "").lower()]
    print(f"session {s.get('session_id')} · {s.get('subtype')} · turns {s.get('num_turns')} · ${s.get('cost_usd') or 0:.2f}")
    print("tools: " + ", ".join(f"{k}×{v}" for k, v in sorted(names.items())))
    if denied:
        print("denied: " + ", ".join(denied))
    print("--- result ---")
    print((s.get("result") or "")[:3000])
    print("--------------")


# ---------- snapshot ----------

def norm_id(s):
    m = re.findall(r"[0-9a-f]{32}|[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}", (s or "").lower())
    return m[-1].replace("-", "") if m else (s or "")


def tool(c):
    return c["name"].split("__")[-1]


def snapshot(summary, out):
    s = load(summary, {})
    snap = {"ok": not s.get("is_error"), "reply": s.get("result", ""), "page": None,
            "databases": {}, "data_sources": {}, "queries": [], "pages": {}, "comments": {}, "errors": []}
    for c in s.get("calls", []):
        name, inp, outp = tool(c), c["input"], c["output"] or ""
        if c["error"]:
            snap["errors"].append(f"{name} {json.dumps(inp)[:200]}: {outp[:300]}")
            continue
        if name == "notion-fetch":
            key = norm_id(inp.get("id") or inp.get("url") or "")
            if snap["page"] is None:
                snap["page"] = outp
            elif "<data-source" in outp[:400] or outp.lstrip().startswith("<data-source"):
                snap["data_sources"][key] = outp
            elif "<database" in outp[:400]:
                snap["databases"][key] = outp
            else:
                snap["pages"][key] = outp
        elif name == "notion-query-data-sources" or name == "notion-search":
            snap["queries"].append(outp)
        elif name == "notion-get-comments":
            key = norm_id(inp.get("page_id") or inp.get("id") or "")
            snap["comments"][key] = outp
    m = re.search(r"\{.*\}", snap["reply"] or "", re.S)
    try:
        snap["listing"] = json.loads(m.group(0)) if m else {}
    except ValueError:
        snap["listing"] = {}
    save(out, snap)


def cmd_row_url(snap_path, revision):
    for r in rows(load(snap_path, {})):
        if r["revision"] == int(revision):
            print(r["url"])
            return


def cmd_created_url(summary):
    for c in load(summary, {}).get("calls", []):
        if tool(c) == "notion-create-pages" and not c["error"]:
            m = re.search(r"https://[^\s\"]*notion[^\s\"]*", c["output"] or "")
            if m:
                print(m.group(0).split("?")[0])
                return


def cleanup(work):
    st = load(os.path.join(work, "state.json"), {})
    print("Archive these by hand in Notion (the script deletes nothing):")
    for k in ("run_page_url", "database_url", "row1_url", "row2_url"):
        if st.get(k):
            print(f"  {k}: {st[k]}")
    print(f"Scratch repo: {st.get('repo')}")


# ---------- parsing ----------

def fetch_text(raw):
    try:
        return json.loads(raw).get("text", raw)
    except (ValueError, AttributeError):
        return raw or ""


def between(text, a, b):
    i = text.find(a)
    if i < 0:
        return ""
    j = text.find(b, i + len(a))
    return text[i + len(a): j if j >= 0 else len(text)]


def rows(snap):
    """Rows of the Design review database, from the last query that returned results."""
    found = []
    for q in snap.get("queries", []):
        try:
            d = json.loads(q)
        except ValueError:
            continue
        if isinstance(d, dict) and isinstance(d.get("results"), list):
            found = d["results"]
    out = []
    for r in found:
        rid = norm_id(r.get("url") or r.get("id"))
        try:
            rev = int(r.get("Revision")) if r.get("Revision") is not None else None
        except (TypeError, ValueError):
            rev = None
        out.append({"id": rid, "url": f"https://app.notion.com/p/{rid}", "revision": rev,
                    "status": r.get("Status"), "name": r.get("Name"), "raw": r})
    return out


def page_content(snap, rid):
    return between(fetch_text(snap.get("pages", {}).get(rid, "")), "<content>", "</content>")


def comments(snap, rid):
    """(count, texts) of every comment on the page, block-level and resolved included."""
    raw = snap.get("comments", {}).get(rid)
    if raw is None:
        return None, []
    text = fetch_text(raw)
    m = re.search(r'<discussions total-count="(\d+)" shown-count="(\d+)"', text)
    if m and m.group(1) != m.group(2):
        print(f"note: comments on {rid}: shown {m.group(2)} of {m.group(1)}")
    texts = [html.unescape(t).strip() for t in re.findall(r"<comment\b[^>]*>(.*?)</comment>", text, re.S)]
    return len(texts), texts


def tables(content):
    """Each <table> as a list of rows, each row a list of cell texts."""
    out = []
    for t in re.findall(r"<table[^>]*>(.*?)</table>", content, re.S):
        out.append([[c.strip() for c in re.findall(r"<td[^>]*>(.*?)</td>", tr, re.S)]
                    for tr in re.findall(r"<tr[^>]*>(.*?)</tr>", t, re.S)])
    return out


def listed_mocks(design_md):
    """Distinct mock files in the ## Mocks section, rejected options left out."""
    section = between(design_md, "## Mocks", "\n## ")
    found = set()
    for line in section.splitlines():
        if "rejected" not in line.lower():
            found.update(re.findall(r"mocks/[\w.-]+\.html", line))
    return len(found)


def repo_file(work, rel):
    p = os.path.join(work, "repo", rel)
    return open(p).read() if os.path.exists(p) else ""


PLAN = "docs/plans/contractor-date/"
ORIGINAL_COMMENTS = [
    ("Priya Shah", "one visit in five moves"),
    ("Tom Reed", "text the agent's mobile"),
    ("Tom Reed", "old date stays on the list"),
]


class Out:
    def __init__(self, step):
        self.step = step

    def r(self, ok, name, why):
        print(f"{'PASS' if ok else 'FAIL'} {name}: {why}")

    def skip(self, name, why):
        print(f"SKIPPED {name}: {why}")


def load_snap(work, step):
    snap = load(os.path.join(work, f"snap-{step}.json"), {})
    o = Out(step)
    if not snap.get("ok"):
        o.r(False, "snapshot", "the read-only Notion fetch did not finish: " + (snap.get("reply") or "no reply")[:300])
    for e in snap.get("errors", []):
        print(f"note: tool error in snapshot: {e}")
    return snap, o


def review_lines(work):
    return re.findall(r"^Review page: notion (\S+) · revision (\d+).*$", repo_file(work, PLAN + "decisions.md"), re.M)


def comment_lines(work):
    d = repo_file(work, PLAN + "decisions.md")
    return [l.strip() for l in d.splitlines() if re.search(r"(KNOWN|Finding) \([^)]*comment", l)]


def check_rows(o, rs, want):
    o.r(len(rs) == want, "row count", f"{len(rs)} row(s) in Design review, want {want}: " +
        "; ".join(f"rev {r['revision']} {r['status']}" for r in rs))


# ---------- checks ----------

def check_share(work):
    snap, o = load_snap(work, "share")
    st = load(os.path.join(work, "state.json"), {})
    page = fetch_text(snap.get("page") or "")
    dbs = re.findall(r'<database url="([^"]+)"[^>]*>Design review</database>', page)
    o.r(len(dbs) == 1, "database exists", f"{len(dbs)} child database(s) titled Design review under the test page")
    if dbs:
        st["database_url"] = dbs[0]
    schema = {}
    for raw in list(snap.get("databases", {}).values()) + list(snap.get("data_sources", {}).values()):
        m = re.search(r"<data-source-state>\s*(\{.*?\})\s*</data-source-state>", fetch_text(raw), re.S)
        if m:
            schema = json.loads(m.group(1)).get("schema", {})
    want = {"Name": ("title", None), "Status": ("select", {"Problem review", "Design review", "Superseded"}),
            "Size": ("select", {"Small", "Medium", "Large"}), "Reviewers": ("person", None),
            "Revision": ("number", None), "Plan folder": ("text", None)}
    bad = []
    for k, (typ, opts) in want.items():
        p = schema.get(k)
        if not p:
            bad.append(f"{k} missing")
        elif p.get("type") != typ:
            bad.append(f"{k} is {p.get('type')}")
        elif opts and {x["name"] for x in p.get("options", [])} != opts:
            bad.append(f"{k} options {[x['name'] for x in p.get('options', [])]}")
    o.r(bool(schema) and not bad, "database properties", "; ".join(bad) or "Name, Status (3 options), Size, Reviewers, Revision, Plan folder")

    rs = rows(snap)
    check_rows(o, rs, 1)
    r1 = next((r for r in rs if r["revision"] == 1), None)
    o.r(bool(r1) and r1["status"] == "Design review", "row 1 status and revision",
        f"revision {r1['revision']}, status {r1['status']}" if r1 else "no row with Revision 1")
    if not r1:
        save(os.path.join(work, "state.json"), st)
        return
    st["row1_url"] = r1["url"]
    save(os.path.join(work, "state.json"), st)
    c = page_content(snap, r1["id"])
    if not c:
        o.r(False, "row page fetched", "no fetch output for the row page")
        return

    heads = re.findall(r"^## (.+)$", c, re.M)
    want_heads = ["Summary", "Who's involved", "The journey, today and proposed", "Screens", "Questions"]
    o.r(heads == want_heads, "five sections in order", " | ".join(heads))

    journey = between(c, "## The journey", "\n## ")
    ts = tables(journey)
    today = next((t for t in ts if t and t[0] and t[0][0] == "Today"), None)
    prop = next((t for t in ts if t and t[0] and t[0][0] == "Proposed"), None)
    actors = {"Tenant", "Letting agent", "Contractor"}
    why = []
    if not today or not prop:
        why.append("Today or Proposed table missing")
    else:
        tl, pl = [r[0] for r in today[1:]], [r[0] for r in prop[1:]]
        if tl != pl:
            why.append(f"row labels differ: {tl} vs {pl}")
        if set(tl) != actors or len(tl) != len(set(tl)):
            why.append(f"rows {tl}, want one each for {sorted(actors)}")
        if today[0][1:] != prop[0][1:]:
            why.append("stage headers differ")
        for tr, pr in zip(today[1:], prop[1:]):
            for col, (a, b) in enumerate(zip(tr[1:], pr[1:]), 1):
                changed = a.strip() != b.lstrip("◆").strip()
                if b.startswith("◆") != changed:
                    why.append(f"{pr[0]} / {prop[0][col]}: Today '{a[:40]}', Proposed '{b[:40]}'")
    o.r(not why, "journey grids", "; ".join(why) or f"Today and Proposed, rows {[r[0] for r in prop[1:]]}, ◆ only on changed cells")

    full = fetch_text(snap["pages"][r1["id"]])
    leaks = [w for w in ("Joan Peters", "Elm Road") if w.lower() in full.lower()]
    o.r(not leaks, "privacy", "found " + ", ".join(leaks) if leaks else "no Joan Peters, no Elm Road")

    screens = re.split(r"^### ", between(c, "## Screens", "\n## Questions"), flags=re.M)[1:]
    kinds, imgs = [], []
    for sc in screens:
        name = sc.splitlines()[0]
        img = re.findall(r'<image[^>]*source="([^"]+)"|!\[[^\]]*\]\(([^)]+)\)', sc)
        if img:
            kinds.append(f"{name}: image")
            imgs += [a or b for a, b in img]
        elif "no screenshot" in sc.lower():
            kinds.append(f"{name}: no-screenshot text ({sc.splitlines()[1][:90]})")
        elif "no mock" in sc.lower():
            kinds.append(f"{name}: no mock in the plan")
        else:
            kinds.append(f"{name}: neither")
    # "No mock" is valid only for screens beyond the mocks that design.md lists.
    mocks = listed_mocks(repo_file(work, PLAN + "design.md"))
    no_mock = sum(k.endswith("no mock in the plan") for k in kinds)
    shown = sum(k.endswith(": image") or ": no-screenshot text" in k for k in kinds)
    ok = bool(screens) and not any(k.endswith("neither") for k in kinds) and shown >= 1 and no_mock <= len(screens) - mocks
    o.r(ok, "screen image or no-screenshot text", "; ".join(kinds) + f"; design.md lists {mocks} mock(s)" if kinds else "no screens")
    if imgs:
        widths = re.findall(r'width="?(\d+)', between(full, "## Screens", "## Questions"))
        if widths:
            o.r(all(int(w) <= 1000 for w in widths), "image width", f"widths {widths}")
        else:
            o.skip("image width", "the fetch output gives the image URL but no dimensions")
    else:
        o.skip("image width", "no image on the page")

    lines = review_lines(work)
    o.r(len(lines) == 1 and lines[0][1] == "1", "decisions.md Review page line", f"{lines}")


def check_comment(work):
    snap, o = load_snap(work, "comment")
    st = load(os.path.join(work, "state.json"), {})
    rid = norm_id(st.get("row1_url", ""))
    n, texts = comments(snap, rid)
    found = [who for who, frag in ORIGINAL_COMMENTS if any(frag in t for t in texts)]
    o.r(n == 3 and len(found) == 3, "three comments on row 1", f"{n} comment(s); matched {len(found)} of 3 texts")
    s = load(os.path.join(work, "logs", "comment.summary.json"), {})
    print("note: comment poster reply: " + (s.get("result") or "")[:400].replace("\n", " "))


def check_revise(work):
    snap, o = load_snap(work, "revise")
    lines = comment_lines(work)
    known = [l for l in lines if l.startswith("KNOWN") or "KNOWN (" in l]
    finding = [l for l in lines if "Finding (" in l]
    o.r(bool(known), "decisions.md KNOWN comment entry", known[0][:160] if known else "none")
    o.r(bool(finding), "decisions.md Finding comment line", finding[0][:160] if finding else "none")
    for l in known + finding:
        if "Priya Shah" not in l and "Tom Reed" not in l:
            print(f"note: comment entry does not name the commenter from the comment text: {l[:160]}")
    j = repo_file(work, PLAN + "journey.md")
    row = next((l for l in j.splitlines() if l.startswith("| Agree date")), "")
    o.r(bool(re.search(r"\btext|mobile", row, re.I)), "journey.md Agree date row", row[:200] or "no Agree date row")
    rl = review_lines(work)
    o.r(len(rl) == 1, "no new Review page line", f"{len(rl)} Review page line(s)")
    check_rows(o, rows(snap), 1)
    s = load(os.path.join(work, "logs", "revise.summary.json"), {})
    skills = [c["input"].get("skill", "") for c in s.get("calls", []) if c["name"] == "Skill"]
    o.r(any(k.endswith("designing-products") for k in skills), "router loaded", f"Skill calls: {skills}")


def check_check(work):
    snap, o = load_snap(work, "check")
    st = load(os.path.join(work, "state.json"), {})
    rs = rows(snap)
    check_rows(o, rs, 2)
    r1 = next((r for r in rs if r["revision"] == 1), None)
    r2 = next((r for r in rs if r["revision"] == 2), None)
    o.r(bool(r2) and r2["status"] == "Design review", "row 2 status", f"{r2['status']}" if r2 else "no row with Revision 2")
    o.r(bool(r1) and r1["status"] == "Superseded", "row 1 superseded", f"{r1['status']}" if r1 else "no row with Revision 1")
    if r1 and r2:
        st["row2_url"] = r2["url"]
        c1, c2 = fetch_text(snap["pages"].get(r1["id"], "")), fetch_text(snap["pages"].get(r2["id"], ""))
        c1b, c2b = between(c1, "<content>", "</content>"), between(c2, "<content>", "</content>")
        to2 = r2["id"] in c1b.replace("-", "")
        to1 = r1["id"] in c2b.replace("-", "")
        o.r(to2 and to1, "rows link each other", f"row 1 → row 2: {to2}; row 2 → row 1: {to1}")
        n, texts = comments(snap, r1["id"])
        found = sum(1 for _, frag in ORIGINAL_COMMENTS if any(frag in t for t in texts))
        o.r(found == 3, "original comments still on row 1", f"{found} of 3 found among {n} comment(s)")
        n2, _ = comments(snap, r2["id"])
        st["after_check"] = {"row1_comments": n, "row2_comments": n2, "comment_lines": len(comment_lines(work))}
    rl = review_lines(work)
    o.r(any(r[1] == "2" for r in rl), "decisions.md revision 2", f"{rl}")
    save(os.path.join(work, "state.json"), st)


def check_recheck(work):
    snap, o = load_snap(work, "recheck")
    st = load(os.path.join(work, "state.json"), {})
    base = st.get("after_check", {})
    rs = rows(snap)
    check_rows(o, rs, 2)
    for key, rev in (("row1_comments", 1), ("row2_comments", 2)):
        r = next((x for x in rs if x["revision"] == rev), None)
        n = comments(snap, r["id"])[0] if r else None
        if key not in base:
            o.skip(f"row {rev} comment count", "no count recorded after the check step")
        else:
            o.r(n == base[key], f"row {rev} comment count unchanged", f"{n} now, {base[key]} after check")
    rl = review_lines(work)
    o.r(len(rl) == 2, "no third Review page line", f"{len(rl)} Review page line(s)")
    lines = comment_lines(work)
    dup = len(lines) != len(set(lines))
    same = base.get("comment_lines") is None or len(lines) == base["comment_lines"]
    o.r(not dup and same, "no duplicate KNOWN/Finding entries",
        f"{len(lines)} entries, {base.get('comment_lines')} after check, duplicates: {dup}")


CHECKS = {"share": check_share, "comment": check_comment, "revise": check_revise,
          "check": check_check, "recheck": check_recheck}

if __name__ == "__main__":
    cmd, args = sys.argv[1], sys.argv[2:]
    if cmd == "trace":
        trace(*args)
    elif cmd == "show":
        show(*args)
    elif cmd == "snapshot":
        snapshot(*args)
    elif cmd == "row-url":
        cmd_row_url(*args)
    elif cmd == "created-url":
        cmd_created_url(*args)
    elif cmd == "cleanup":
        cleanup(*args)
    elif cmd.startswith("check-"):
        CHECKS[cmd[6:]](*args)
    else:
        sys.exit(f"unknown command {cmd}")
