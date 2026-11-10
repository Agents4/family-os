@AGENTS.md

# Hermes-specific notes

The shared rules above are the source of truth. This file only adds what is specific to [Hermes Agent](https://hermes-agent.nousresearch.com/docs/) (CLI, TUI, and Desktop).

- **Skills:** `skills/` is canonical. Hermes loads `SKILL.md` from `$HERMES_HOME/skills/` (a named profile if you use one). Run `bash scripts/link-tools.sh` with `HERMES_HOME` set, or symlink each `skills/<name>` folder into that profile's `skills/` directory.
- **Sub-agents / lenses:** the reviewers in `agents/` are short verdicts, not extra household bots. In Hermes, run them as delegated sub-tasks (or extra profiles) so each lens gets a clean context and returns only a short finding.
- **Memory:** Hermes `MEMORY.md` / `USER.md` are a **cache**. Durable household truth stays in this folder (`context/`, `harness/state/`). End working sessions with the `handoff` skill.
- **Scheduled runs:** `morning-brief` (weekday mornings), `weekly-summit` prep (Sunday), and `os-audit` (first of the month) fit Hermes cron. Unattended jobs stay at **A1** (read and draft) and write to `outputs/` only.
- **Connectors:** Calendar, Gmail, and Drive via Hermes Google Workspace (or MCP). Start read-only. Promote writes per `harness/autonomy-ladder.md`. Record what is connected in `harness/connected-tools.md`.
- **Desktop, non-technical adult:** open this folder as a Hermes project (or working directory), switch to the Family Chief profile, and say "run the weekly summit."
- **Home Assistant:** the Family OS agent may **read** household state. Locks, garage, alarm, and cameras stay human-controlled (`harness/guardrails.md`).
- **Approvals:** keep dangerous-command approval on. Scheduled jobs must not send mail, pay, or book.

Step-by-step: [`docs/hermes-implementation-guide.md`](docs/hermes-implementation-guide.md).
