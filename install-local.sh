#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  RedTrack Product Discovery Flow — LOCAL installer
#  Run this AFTER `git clone`. Copies the 15 sub-agents + the
#  /rt-product-discovery skill from this repo into ~/.claude/.
#  Touches nothing else on your system.
#
#  Author: Uladzislau Dziarkach (Vladislav Derkach)
#  https://www.linkedin.com/in/vladislavderkach/en/
# ─────────────────────────────────────────────────────────────
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
AGENTS_DIR="$HOME/.claude/agents"
SKILL_DIR="$HOME/.claude/skills/rt-product-discovery"

echo ""
echo "  RedTrack Product Discovery Flow — local install"
echo "  source: $DIR"
echo "  → $AGENTS_DIR"
echo "  → $SKILL_DIR"
echo ""

mkdir -p "$AGENTS_DIR" "$SKILL_DIR"

n=0
for f in "$DIR"/files/agents/*.md; do
  cp "$f" "$AGENTS_DIR/"
  echo "  ↓ agent  $(basename "$f")"
  n=$((n+1))
done

cp "$DIR/files/skill/SKILL.md" "$SKILL_DIR/SKILL.md"
echo "  ↓ skill  SKILL.md"

echo ""
echo "  ✓ Installed: $n agents + skill rt-product-discovery"
echo ""
echo "  Next:"
echo "   1) Restart Claude Code (to pick up new agents + skill)"
echo "   2) Check /agents — 15 new ones should appear"
echo "   3) Run:  /rt-product-discovery <your brief>"
echo ""
echo "  For a full run, connect the MCP connectors (via /mcp):"
echo "   Notion · ChartMogul · HubSpot · Slack · Telegram"
echo "  and for step 5 (Canon Validator) — the Next Move Theory canon on disk."
echo ""
