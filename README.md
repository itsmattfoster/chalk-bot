# chalk-bot

**The AI agent that doesn't forget what you told it.**

## Starting prompt

Paste this into your agent's instructions:

```
Before every task, read brain/CHARTER.md, brain/RULES.md, brain/NOW.md, and brain/INDEX.md.
When I correct you, add the rule to brain/RULES.md immediately, before replying.
File anything new where brain/INDEX.md says, with a literal kebab-case name.
After each task, append a line to brain/log/YYYY-MM-DD.md: "- HH:MM ET [bot] what happened (file/link)".
Never create new notes, memory, todo, or start-here files. Use the brain files.
After any edit, run `bash brain/check.sh` and fix everything it reports.
```

5 plain files. 3 loops. Works with any agent: Grok Bot, Claude, Cursor, whatever. Nothing to install.

---

## The problem

You correct your AI. It says "got it." Next week it makes the exact same mistake.

Chat history isn't memory. Context windows reset. "Memory" features save random trivia and miss the rule you actually care about.

Fix: give the agent a brain made of files it **must** read before every task and **must** write to the moment you correct it.

## The 5 files

| File | What it holds |
|---|---|
| `brain/CHARTER.md` | Who you are, what you're building, how the agent should push back |
| `brain/RULES.md` | Every correction you've ever given, one line each, with the why |
| `brain/NOW.md` | Current priorities and open loops. Short. Rewritten often |
| `brain/LESSONS.md` | What worked, what didn't, so wins get repeated |
| `brain/INDEX.md` | Where everything lives + the filing rules |

Plus `brain/log/YYYY-MM-DD.md` (activity log) and `brain/check.sh` (the guard).

## The 3 loops

1. **Read before every task.** CHARTER, RULES, NOW, INDEX. Every time. No exceptions.
2. **Capture every correction immediately.** You say "don't do that" → it's a line in RULES.md before the next message.
3. **Prune weekly.** Merge duplicates, kill stale rules, rewrite NOW.md, move dead stuff to `archive/`. Run `brain/check.sh`.

## Folder layout

```
your-workspace/
├── README.md
├── .github/      CI: runs brain/check.sh
├── brain/        memory: the 5 files, log/, check.sh
│   ├── CHARTER.md
│   ├── RULES.md
│   ├── NOW.md
│   ├── LESSONS.md
│   ├── INDEX.md
│   ├── check.sh
│   └── log/
│       └── 2026-01-15.md
├── work/         one folder per project
├── files/        raw inputs, sorted by literal type
│   ├── uploads/    drop zone, must be empty within 24h
│   └── downloads/  drop zone, must be empty within 24h
├── tools/        scripts
└── archive/      old stuff, never deleted, never read by default
```

That's the whole top level. Nothing else goes there.

## The naming rule

Name every file and folder literally, in kebab-case. Someone who has never seen it should know what's inside.

- ✅ `apple-logo.png`, `q3-pricing-page-draft.md`, `customer-interview-notes/`
- ❌ `IMG_4821.png`, `untitled.md`, `final2.docx`, `stuff/`, `notes-copy (1).md`

`check.sh` flags cryptic names automatically.

## Quickstart

1. Copy this repo into your agent's workspace.
2. Paste the starting prompt above into its instructions.
3. Fill in CHARTER.md and NOW.md. Delete the example rules. Start correcting it.
4. Run `bash brain/check.sh` after edits. It prints `OK` or tells you what's wrong.

That's it. The more you correct it, the better it gets. It never gets worse.

---

MIT licensed.
