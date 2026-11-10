#!/usr/bin/env bash
# Wires the canonical folders (skills/, agents/) into each tool's expected location.
# Run from the Family-OS folder:  bash scripts/link-tools.sh
# Default is symlinks. Use --copy if your folder is in a synced drive that doesn't preserve symlinks.
# Re-run with --copy after you edit skills or agents (copies don't update themselves).

set -euo pipefail
MODE="link"
[[ "${1:-}" == "--copy" ]] && MODE="copy"

link_or_copy () {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  rm -rf "$dest"
  if [[ "$MODE" == "link" ]]; then
    ln -s "$(cd "$(dirname "$src")" && pwd)/$(basename "$src")" "$dest"
  else
    cp -R "$src" "$dest"
  fi
  echo "  $dest  ($MODE)"
}

echo "Claude Code / Claude desktop:"
link_or_copy skills .claude/skills
link_or_copy agents .claude/agents

echo "Other agent tools that read an .agents/ convention:"
link_or_copy skills .agents/skills

echo
if [[ -n "${HERMES_HOME:-}" ]]; then
  echo "Hermes profile skills (HERMES_HOME=$HERMES_HOME):"
  mkdir -p "$HERMES_HOME/skills"
  shopt -s nullglob
  for src in skills/*/; do
    name="$(basename "$src")"
    [[ "$name" == _template ]] && continue
    link_or_copy "$src" "$HERMES_HOME/skills/$name"
  done
  shopt -u nullglob
else
  echo "Hermes: set HERMES_HOME to a profile directory (e.g. ~/.hermes/profiles/family-chief) and re-run to link skills."
fi

echo
echo "Instruction files already in place:"
for f in AGENTS.md CLAUDE.md GEMINI.md HERMES.md; do [[ -f "$f" ]] && echo "  $f"; done

echo
echo "Done. Cursor, Codex, Copilot, and Hermes read AGENTS.md from this folder."
echo "Gemini CLI: set its context file name to AGENTS.md, or keep GEMINI.md."
echo "Hermes: see HERMES.md and docs/hermes-implementation-guide.md."
