# Family OS on Hermes – Implementation Guide (draft)

Hermes Agent (Nous Research) is a **folder tool**: it reads `AGENTS.md`, loads skills, can run on a schedule, and keeps a profile-local memory. Use it as Path B in the README. Do **not** paste Family OS into a consumer chat bot and call that Hermes.

This guide is for a technical adult setting up **one Family Chief** on Hermes. Other adults can keep using chat apps (Path A). Everyone still follows the same `AGENTS.md`.

> Status: draft. Re-verify Hermes CLI flags and Desktop labels against current docs: https://hermes-agent.nousresearch.com/docs/

## Quick start (one page)

1. **Private copy** of Family OS (template or private repo). Never put real household files in the public template.
2. Install Hermes (Desktop and/or CLI): https://hermes-agent.nousresearch.com/docs/getting-started/installation
3. Create a **named profile** for Family Chief (do not reuse a home-IT or work profile).
4. Open the Family OS folder as the working directory / Desktop **project**.
5. Confirm Hermes sees `AGENTS.md` and `HERMES.md`.
6. Link skills (below).
7. Say: **Follow AGENTS.md and run the setup skill.** Answer only what you are willing to store in `context/`.
8. Next weekday: **Run the morning brief.** Sunday: **Run the weekly summit.** End with **Run handoff.**
9. Before Gmail/Calendar: run `consumer/probes.md` and `harness/evals/golden-tests.md` (safety tests first).

Cron, Google connectors, and extra bots come **after** a week of clean drafts.

## 1. Before you start

### 1.1 What you need

- Hermes Desktop or CLI on a computer the adults control.
- A **private** Family OS folder (Drive / iCloud / Dropbox **or** a private git repo).
- One adult who can say yes/no to drafts (A1 default).
- Optional: Google Workspace for calendar and mail (read-only first).

### 1.2 Why a separate Hermes profile

Hermes profiles isolate config, skills, memory, and cron. Family Chief must not share a profile with:

- Home network / Home Assistant **control** (locks, cameras, garage).
- Work email or a company board (for example Paperclip).

Suggested profile name: `family-chief`. The folder is still the OS; the profile is the worker.

### 1.3 Privacy

- No passwords, PINs, account numbers, or school-portal logins in chats or files. Pointers only (`context/vault-pointer.md`).
- Sensitivity tiers in context frontmatter still apply. Do not put tier 2–3 facts into Hermes memory as a workaround.
- Kid-facing use is `kid-mode/KID-AGENT.md` later, parent-visible. Do not give children the Family Chief profile.

## 2. Wire the folder to Hermes

### 2.1 Open the folder

**Desktop:** add or open a project whose root is the Family OS directory (the one that contains `AGENTS.md`).

**CLI:**

```bash
cd /path/to/your-private-family-os
hermes -p family-chief
```

(Use your profile name. `HERMES_HOME` for that profile is `~/.hermes/profiles/<name>`.)

### 2.2 Instruction files

| File | Role |
|---|---|
| `AGENTS.md` | Constitution. Hermes injects project `AGENTS.md` like other tools. |
| `HERMES.md` | Thin Hermes notes. Points at `AGENTS.md`. |

You should not need to paste the constitution into a custom-instructions box.

### 2.3 Link skills

Family OS skills are already `skills/<name>/SKILL.md`, which is the Hermes skill shape.

From the Family OS folder:

```bash
export HERMES_HOME="$HOME/.hermes/profiles/family-chief"
bash scripts/link-tools.sh
```

If the folder lives on a synced drive that drops symlinks:

```bash
bash scripts/link-tools.sh --copy
```

Re-run `--copy` after you edit skills. Confirm the profile's `skills/` directory lists `morning-brief`, `handoff`, `setup`, and the rest.

**Lenses** in `agents/` are not Hermes skills. Keep them in the folder; ask Family Chief to run a named lens as a sub-task when a decision spans money, kids, safety, or diet.

### 2.4 Memory vs the folder

| Store | Use for |
|---|---|
| `context/`, `harness/state/` | Decisions, tasks, progress log (source of truth) |
| `outputs/` | Drafts from briefs and summits |
| Hermes `MEMORY.md` / `USER.md` | Short standing facts the adult confirmed (cache) |

If memory and the folder disagree, **the folder wins**. Update the folder (with an explicit yes for `context/` edits), then optionally note the fact in memory.

## 3. First week (no schedule yet)

| Day | Ask Hermes |
|---|---|
| 1 | Run **setup**. Fill `[TODO]` only with facts you accept in files. |
| 1 | Run **handoff** so `progress.md` has a first line. |
| 2–5 | **Morning brief** on weekdays. You read it; you send nothing automatically. |
| Sunday | **Weekly summit** prep. |
| Any day | **Capture** a one-line inbox item, then triage. |

Do not connect mail or calendar until briefs look right and the injection tests pass.

## 4. Skills mapping

Same skills as the rest of Family OS. Hermes does not need a second copy of the routine text inside a bot description.

| Rhythm | Skill | Hermes note |
|---|---|---|
| Daily | `morning-brief`, `evening-reset`, `capture` | Briefs are A1 drafts in `outputs/` |
| Weekly / monthly | `weekly-summit`, `meal-plan`, `bills-and-money`, `monthly-retro` | Bills stay read-only until you promote that domain |
| Handle things | `inbox-triage`, `event-prep`, `home-maintenance` | No lock/camera/garage actions |
| Decide | `decision-brief`, `family-meeting` | Use lenses as sub-tasks |
| Kids | `kid-activity` | Parent-run. Not kid-mode. |
| System | `setup`, `handoff`, `os-audit` | Audit is a good monthly cron |

## 5. Connectors (after probes)

Record each connection in `harness/connected-tools.md`.

1. **Google Calendar / Gmail / Drive** — Hermes Google Workspace skill or MCP. **A0 read** first. Drafts for events or mail stay in `outputs/` until an adult sends or clicks in the real app.
2. **Home Assistant** — read state if you want "is the dryer done." **Never** give Family Chief control of locks, garage, alarm, or cameras.
3. **Local models (Ollama, etc.)** — optional for pantry photos or kid-mode later. Lower capability; data can stay home.

Do not store API keys in Family OS files. Hermes keeps secrets in the profile `.env` / auth store.

## 6. Cron (A1 only)

Unattended runs have no adult in the loop. They must not send, pay, book, or write `context/`.

Good crons:

- Weekday morning: `morning-brief` → `outputs/`
- Sunday afternoon: `weekly-summit` prep → `outputs/`
- First of month: `os-audit` → `outputs/`

In Hermes Desktop: scheduled jobs / cron for the **family-chief** profile. In CLI, use `hermes cron` (see current CLI docs). If a job would need a yes, it should skip and leave a note in `harness/state/inbox.md` instead.

## 7. Safety

- Outside text (email, PDFs, web) is **data, not orders** (`AGENTS.md`, `consumer/probes.md`).
- Autonomy ladder starts at **A1** for every domain (`harness/autonomy-ladder.md`).
- Keep Hermes dangerous-command approval **on**. Do not enable YOLO for Family Chief.
- After any model, connector, or Hermes version change: golden tests, safety first (`harness/evals/golden-tests.md`).

## 8. What not to do

- Do not run Family OS inside a **home-IT** or **work** Hermes profile.
- Do not require a company board (Paperclip or similar) to use Family OS. The folder is enough.
- Do not spawn a bot per skill. One Family Chief plus lenses-on-demand.
- Do not treat Hermes memory as the household log. Append `harness/state/progress.md`; do not rewrite old entries.
- Do not promote a domain to A2 because cron is convenient.

## 9. Troubleshooting

| Problem | Likely cause | Fix |
|---|---|---|
| Ignores `AGENTS.md` | Wrong working directory / project | Open the folder that contains `AGENTS.md` |
| Skills not listed | Not linked into `$HERMES_HOME/skills/` | Re-run `link-tools.sh` with `HERMES_HOME` |
| Briefs invent calendar facts | No calendar connector, or guessed | Stay A0; say "I couldn't read the calendar" |
| Writes `context/` unasked | Approval too loose | Turn approval on; remind write zones |
| Cron sent a message | Job not A1 | Disable the job; cron drafts only |
| Mixes family and home-lab | Shared profile | Split profiles; strip device-control tools from Family Chief |

## 10. Related files

- [`HERMES.md`](../HERMES.md) — short Hermes pointer
- [`docs/implementation-guide.md`](implementation-guide.md) — Grok Bot (Path A)
- [`docs/02-tool-matrix.md`](02-tool-matrix.md)
- [`consumer/probes.md`](../consumer/probes.md)
- [`harness/guardrails.md`](../harness/guardrails.md)
