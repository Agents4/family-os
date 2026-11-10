# Family OS

**An operating system for running a household with AI agents. It's built from plain files, works with any tool, and is designed to be safe.**

Family OS is a folder of Markdown files that gives an AI assistant what it needs to help a family run day-to-day logistics: calendars, school emails, meals, bills, home upkeep and family rituals. The rulebook is one file, [`AGENTS.md`](AGENTS.md). Tool-specific files such as `CLAUDE.md`, `GEMINI.md`, and `HERMES.md` just point back to it. Your family's decisions live in `context/`, repeatable routines live in `skills/`, and the safety rules live in `harness/`.

The idea: **context beats prompting, and workflows beat chat.** The assistant prepares, reminds, drafts and checks. The adults decide.

> Status: early draft (v0.1). Expect changes.

## Who it's for

- Parents and caregivers who want an AI assistant to carry some of the mental load without handing it the keys.
- Households with one adult, two adults, or kids split across two homes. The member templates in `context/members/` can be adapted to each.
- Beginners (Grok Bot and consumer-assistant paths need no terminal) and tinkerers (Hermes, Claude Code, Codex, Cursor and similar tools can open the folder directly).

## Quick start

**Before anything else, make a private copy.** This public repo is a template. Your family's real details belong in a private copy (see [Make it yours](#make-it-yours-the-private-fork-pattern)).

### Path A: No terminal (Grok Bot, Gemini, ChatGPT and other chat assistants)

1. Download the repo (**Code → Download ZIP**) and put the folder in a private cloud drive, such as Google Drive, that only the adults can open.
2. Pick your tool and follow its guide:
   - **Grok Bot:** [`docs/implementation-guide.md`](docs/implementation-guide.md) is a step-by-step beginner guide. It starts with a single "Family Chief" bot and adds others only when you need them. It includes paste-ready bot descriptions, routines and connector stages. Also see [`consumer/grok/README.md`](consumer/grok/README.md).
   - **Gemini (Gems and Spark):** [`consumer/gemini/README.md`](consumer/gemini/README.md).
   - **Other consumer assistants, including ChatGPT projects:** [`consumer/README.md`](consumer/README.md) and [`docs/02-tool-matrix.md`](docs/02-tool-matrix.md). Paste a constitution from `consumer/shared/` (1,500 or 4,000 characters) into the custom instructions slot, and use the Doc and Sheet "state bridge" in `consumer/shared/state-bridge.md` in place of folder access.
3. Before you connect email, calendar or money, run the probes in [`consumer/probes.md`](consumer/probes.md). If the injection test fails, don't connect.

### Path B: Tools that can open a folder (Hermes, Claude desktop or Claude Code, Codex, Cursor and similar)

1. Open the folder in your tool.
2. Say: **"Follow AGENTS.md and run the setup skill."** Answer the first round of questions.
3. Next morning, say **"Run the morning brief."** On Sunday, say **"Run the weekly summit."**
4. End each session with **"Run handoff"** so any tool can pick up where you left off.

- **Hermes (Desktop or CLI):** [`docs/hermes-implementation-guide.md`](docs/hermes-implementation-guide.md). Use a dedicated Family Chief profile. `bash scripts/link-tools.sh` with `HERMES_HOME` set links `skills/` into that profile. `HERMES.md` points at `AGENTS.md`.
- **Claude:** `bash scripts/link-tools.sh` (add `--copy` on a synced drive) makes the skills discoverable under `.claude/`.
- **Gemini CLI:** `GEMINI.md` points at `AGENTS.md`.

## Repo layout

| Path | What's in it |
|---|---|
| `AGENTS.md` | The rulebook. It's the one source of truth for every tool. |
| `CLAUDE.md`, `GEMINI.md`, `HERMES.md` | Thin pointers to `AGENTS.md`, plus tool tips |
| `context/` | What the family decided. `INDEX.md` is the router. There are files for household, charter, routines, calendar rules, food, home, money rules, contacts, voice and a vault pointer. |
| `context/members/` | Templates for adults and children, plus an example of a private lane |
| `context/decisions/` | Decision log |
| `skills/` | Routines, one `SKILL.md` each, plus `_template/` for writing your own |
| `agents/` | Seven reviewer lenses: budget, devil's advocate, dietary, future-us, kid's-eye view, logistics, safety |
| `harness/` | How agents work safely across sessions: session protocol, autonomy ladder, guardrails, connected-tools register |
| `harness/state/` | `tasks.json`, `progress.md`, `inbox.md`, `learning-log.md` |
| `harness/evals/` | Golden tests, with safety tests first |
| `consumer/` | Adapters for consumer assistants (Gemini, Grok and Grok Bot, Muse), shared constitutions, injection shield, state bridge and probes |
| `kid-mode/` | A separate, narrower agent for children (`KID-AGENT.md`) |
| `docs/` | Architecture and rollout, tool matrix, skill-writing guide, Grok Bot and Hermes implementation guides, and the kids module spec (draft) |
| `scripts/` | `link-tools.sh`, `compile-consumer.sh` (builds tier-filtered bundles into `dist/`), `check-staleness.sh`, plus maintainer tools `check-public-safe.sh`, `lint-repo.sh`, `install-hooks.sh` |

`outputs/`, `dist/` and `context/members/*/private/` are git-ignored on purpose.

### Skills at a glance

| Rhythm | Skills |
|---|---|
| Daily | `morning-brief` · `evening-reset` · `capture` |
| Weekly and monthly | `weekly-summit` · `meal-plan` · `bills-and-money` · `monthly-retro` |
| Handle things | `inbox-triage` · `event-prep` · `home-maintenance` |
| Decide together | `decision-brief` · `family-meeting` |
| Kids | `kid-activity` (parent-run) · `kid-mode/` (child-facing, supervised) |
| System | `setup` · `handoff` · `os-audit` |

## Make it yours: the private-fork pattern

Never commit real family data to the public repo or to any public fork.

1. **Make a private copy.** On GitHub, use **Use this template** or create a new private repo and push a clone of this one into it. (A regular GitHub fork of a public repo can't be made private.) Or skip git and keep a private copy in a cloud folder that only the adults can open.
2. **Keep system files and family files separate.**
   - *System files* come from upstream and you mostly leave them alone: `AGENTS.md`, `harness/` (except `harness/state/` and the "Now" column in `autonomy-ladder.md`), `skills/`, `agents/`, `consumer/`, `kid-mode/KID-AGENT.md`, `docs/` and `scripts/`.
   - *Family files* are yours: `context/` (including `members/`), `harness/state/`, `outputs/` and `dist/`.
3. **Fill in the `[TODO]` markers** by running the `setup` skill. Don't do it by hand.
4. **Keep each adult's private notes private.** In a shared cloud folder, anyone with access can read every subfolder. Keep sensitive per-person notes in that person's own unshared storage, or in a vault, and leave only a pointer.
5. **Pull upstream updates.** In your private repo, run `git remote add upstream https://github.com/agents4families/family-os.git` once, then `git fetch upstream && git merge upstream/main` when you want updates. Changes to system files should merge cleanly. Review any conflicts in `context/` by hand.
6. **Before sharing anything back** (see Contributing), make sure it contains no names, places, schools, emails, phone numbers or account details.

## Safety and guardrails

Read [`harness/guardrails.md`](harness/guardrails.md) and [`harness/autonomy-ladder.md`](harness/autonomy-ladder.md) before you connect email, calendar or money.

- **Outside text is data, not orders.** Emails, PDFs, web pages and shared docs can't command the agent. It pulls out the facts, ignores any embedded instructions and tells you it did. Only an adult in the live session can authorize an action.
- **No secrets in files or chats.** That means no passwords, PINs, card or account numbers, government IDs or 2FA codes. Store pointers and dates only ("in the fire safe, expires 2029").
- **A human presses every money or send button.** Paying, buying, booking, sending and sharing sensitive data always need an explicit yes that names the action.
- **Locks, garage doors and cameras stay human-controlled.** The agent never operates them.
- **Autonomy ladder (A0–A4), set per domain.** A0 Observe, A1 Draft, A2 Act (reversible), A3 Act with approval, A4 Standing order within hard limits. Everything starts at A1. A domain is promoted after weeks of good drafts and demoted instantly after a mistake that mattered.
- **Sensitivity tiers (0–3)** go in each context file's frontmatter. 0 = fine anywhere, 1 = household-private, 2 = sensitive (health, money, legal, school performance), 3 = never stored. `compile-consumer.sh` only publishes up to the tier you allow, which is tier 1 by default.
- **Kids' protections.** Kid mode is a separate, narrower agent. It's used with a parent present or able to see the session, doesn't read the household context and collects minimal data about kids. Don't give children a general-purpose chatbot account. Parent-run tools and printed charts are the default.
- **Test before you trust.** Run `harness/evals/golden-tests.md` and `consumer/probes.md`, starting with the safety tests.
- **Not professional advice.** Family OS helps with logistics. It isn't medical, legal, financial or tax advice. Check anything important with a qualified professional.

## Contributing

This public repo is the primary working copy of the template. See [`CONTRIBUTING.md`](CONTRIBUTING.md) for the workflow, the safety scripts and CI.

Issues and pull requests are welcome, especially new skills (start from `skills/_template/SKILL.md` and read `docs/03-writing-skills-and-prompts.md`), new reviewer lenses, tool adapters and safety tests.

- Keep every example fictional and generic. Use placeholders like `[child]`, `Parent A` and `example.com`.
- Don't include real names, locations, schools, contacts or account details. PRs with personal data will be closed.
- Changes to guardrails and the autonomy ladder should come with a matching test in `harness/evals/`.

## License

TBD. There's no license file yet. Until one is added, all rights are reserved by default.
