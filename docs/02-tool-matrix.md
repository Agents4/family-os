# Tool Matrix: Staying Agnostic, Knowing the Advantages

**Principle:** the Family OS is the folder, not the app. Any capable agent that can read files and follow instructions can run it. Pick tools by the job, per adult, and expect to change them.

*Capabilities in this area change quickly. The comparisons below describe general strengths as of October 2026. Re-verify before buying or connecting anything, and revisit every quarter at the retro.*

## What every tool needs to run the OS

1. Read a folder of files (or a project with uploaded files).
2. Follow written instructions (`AGENTS.md`, or pasted at session start).
3. Write files back (or let you paste results into the folder).
4. Optional but valuable: scheduled runs, connectors to calendar/email, sub-agents, voice.

If a tool can't write to the folder, use it as a *planner*: upload `AGENTS.md`, `context/INDEX.md`, and the relevant files, then paste its output into `outputs/` yourself.

## Matrix

| Need | Strong fit | Why / caveat |
|---|---|---|
| Full harness: skills, sub-agents, hooks, scheduled runs, connectors, file edits | **Hermes Agent** (Desktop or CLI), **Claude Code**, or **Claude desktop** with a connected folder | Hermes reads `AGENTS.md` / `HERMES.md`, loads `skills/` into a profile, cron, Google Workspace, persistent memory (cache only). Claude reads `CLAUDE.md`, native skills and sub-agents, MCP, scheduled tasks. Desktop apps let a non-technical adult run "weekly summit" with no terminal. See `docs/hermes-implementation-guide.md`. |
| Another adult who prefers a chat app | **Whatever they already use** (Claude, ChatGPT, Gemini) with a Project or Gem that holds `AGENTS.md` + `context/` files | Adoption beats purity. Give them the same `AGENTS.md`; they paste outputs into `outputs/` or a shared note the agent ingests. |
| Agent-style coding tools for maintaining the OS (editing skills, scripts, evals) | **Codex CLI, Cursor, Copilot agents, Gemini CLI** | These read `AGENTS.md` natively (or via a setting). Good for the "OS admin" role, less so for daily family use. |
| Calendar/email/Docs-native work in a Google household | **Gemini in Workspace** | Deepest access to Calendar, Gmail, Drive, Keep, Docs; Android and Google Home reach. Check what it can write vs. only read. |
| Voice and hands-free capture | **Phone assistant + a Shortcut/automation** that appends a line to `harness/state/inbox.md` | Capture beats perfect classification. An iOS Shortcut or Android routine that dictates a line to the inbox file is a half-hour build. |
| Smart-home control | **Home Assistant** (with its own assistant/conversation agent), plus the main agent reading state | Local, private, device-level control. Keep locks, garage, alarm, and cameras human-controlled. |
| Strict privacy for sensitive tasks | **Local models** (via Ollama/LM Studio, or HA local assistant) | Lower capability but data stays home; good for meal planning from pantry photos, kid-mode, or summarizing private notes. |
| Deep research (trips, schools, big purchases) | **Any tool with strong web research mode** | Use for `trip-plan` and `decision-brief`. Always require sources and dates. |
| Shared household lists and tasks | **The family's existing app** (shared grocery list, reminders) | Don't replace what the other adult already uses. Connect or mirror via `capture`. |
| Kids talking to AI | **A parent-supervised session under `KID-AGENT.md`**, or a purpose-built kids' product the family has vetted | General-purpose consumer chatbots are not designed for young children. Parent present, logs visible. |

## Consumer assistants (Gemini Gems/Spark, Grok, Muse)

These can't open a folder, so they run on compiled bundles instead of the raw files. See `consumer/README.md` for per-tool setup, `scripts/compile-consumer.sh` to generate the bundles (filtered by data sensitivity tier), and `consumer/probes.md` to test any new tool before trusting it. Rule of thumb: Tier 2 data stays in the folder tool and in private Gems; Grok and Muse never see it.

## Storage options

| Option | Good for | Watch for |
|---|---|---|
| **Synced folder (Google Drive, iCloud, Dropbox)** | Easiest. Works with desktop apps. Both adults can reach it. | Sync conflicts if two tools write at once. Symlinks may not sync (use `scripts/link-tools.sh` copy mode). Drive version history is your undo. |
| **Private Git repo** (GitHub/GitLab, private) | Real history, diffs, branches for context changes, rollback. Best harness hygiene. | Needs one technical adult. Never commit Tier 2-3 data. |
| **Hybrid:** synced folder for daily use, Git for `AGENTS.md`, `skills/`, `agents/`, `harness/` | Gets history for the system and convenience for the family | Add `.gitignore` for `context/members/*/private/` and `outputs/`. |

## Per-tool setup (5 minutes each)

- **Hermes Desktop / CLI:** dedicated Family Chief profile. Open the folder as the project. `HERMES_HOME=... bash scripts/link-tools.sh`. Guide: `docs/hermes-implementation-guide.md`.
- **Claude Code / Claude desktop:** open the folder. Run `scripts/link-tools.sh` once to create `.claude/skills` and `.claude/agents`. Say "run setup."
- **ChatGPT / Gemini (project-style):** upload `AGENTS.md`, `context/INDEX.md`, `context/household.md`, and the skills you use. Paste: "Follow AGENTS.md. Read INDEX.md first." Re-upload after context changes (or connect Drive).
- **Codex / Cursor / Gemini CLI:** open the folder; `AGENTS.md` is picked up automatically (Gemini CLI: set the context file name to `AGENTS.md`).
- **Voice assistant:** create the capture shortcut; point it at `harness/state/inbox.md`.

## Rules for multi-tool households

1. Everyone follows the same `AGENTS.md`.
2. All durable state goes in the folder. Treat each tool's built-in memory as a cache.
3. Every session ends with `handoff`, so the next tool starts warm.
4. When a tool changes (new model, new connector), run the safety golden tests before trusting it.
5. Log the tool and its data settings in `harness/connected-tools.md`.
