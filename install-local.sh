#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Product Discovery Flow — LOCAL installer
#  Run this AFTER `git clone`. Copies the 15 sub-agents, both skill
#  variants (/product-discovery in English, /product-discovery-ru in
#  Russian) and the company profile template from this repo into
#  ~/.claude/. Touches nothing else.
#
#  Author: Uladzislau Dziarkach (Vladislav Derkach)
#  https://www.linkedin.com/in/vladislavderkach/en/
# ─────────────────────────────────────────────────────────────
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
AGENTS_DIR="$CLAUDE_DIR/agents"
SKILL_DIR="$CLAUDE_DIR/skills/product-discovery"
SKILL_RU_DIR="$CLAUDE_DIR/skills/product-discovery-ru"
PROFILE="$CLAUDE_DIR/discovery-profile.md"

echo ""
echo "  Product Discovery Flow — local install"
echo "  source: $DIR"
echo "  → $AGENTS_DIR"
echo "  → $SKILL_DIR"
echo "  → $SKILL_RU_DIR"
echo "  → $CLAUDE_DIR/discovery-profile.template.md"
echo ""

mkdir -p "$AGENTS_DIR" "$SKILL_DIR" "$SKILL_RU_DIR"

n=0
for f in "$DIR"/files/agents/*.md; do
  cp "$f" "$AGENTS_DIR/"
  echo "  ↓ agent    $(basename "$f")"
  n=$((n+1))
done

cp "$DIR/files/skill/SKILL.md"    "$SKILL_DIR/SKILL.md"
cp "$DIR/files/skill-ru/SKILL.md" "$SKILL_RU_DIR/SKILL.md"
echo "  ↓ skill    SKILL.md (en) → /product-discovery"
echo "  ↓ skill    SKILL.md (ru) → /product-discovery-ru"

cp "$DIR/files/profile/discovery-profile.template.md" "$CLAUDE_DIR/"
cp "$DIR/files/profile/discovery-profile.example.md"  "$CLAUDE_DIR/"
echo "  ↓ profile  discovery-profile.template.md"
echo "  ↓ profile  discovery-profile.example.md"

# Never overwrite a profile the user already filled in.
if [ -f "$PROFILE" ]; then
  echo "  = profile  discovery-profile.md — kept (already exists)"
  PROFILE_STATE="kept"
else
  PROFILE_STATE="new"
fi

echo ""
echo "  ✓ Installed: $n agents + /product-discovery (en) + /product-discovery-ru (ru)"
echo ""
echo "  Next:"
echo "   1) Restart Claude Code (to pick up the new agents and skill)"
echo "   2) Check /agents — 15 new ones should appear"
echo "   3) Run:  /product-discovery <your brief>   (or /product-discovery-ru for Russian)"
if [ "$PROFILE_STATE" = "new" ]; then
echo "      On the first run it will offer to build your company profile"
echo "      (~/.claude/discovery-profile.md) by asking you six questions."
echo "      Prefer to write it yourself? Copy discovery-profile.template.md"
echo "      to discovery-profile.md and fill it in — see the .example.md."
else
echo "      Your existing ~/.claude/discovery-profile.md was left untouched."
fi
echo ""
echo "  The profile is the ONLY place your company lives. Every agent reads it."
echo "  Fill in only what you have — anything left as '—' is skipped honestly"
echo "  and reported as a data gap, never guessed."
echo ""
echo "  Optional, for the fullest run:"
echo "   · connect the MCP servers for the internal systems you named in the"
echo "     profile (wiki, CRM, revenue metrics, team chat, product analytics)"
echo "   · put the Next Move Theory canon on disk — step 5 (Canon Validator)"
echo "     needs it: https://github.com/zamesin/Next-Move-Theory-Canon-and-Skills"
echo ""
