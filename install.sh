#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Product Discovery Flow — installer for Claude Code
#  Installs 15 sub-agents + the /product-discovery skill (English) and
#  /product-discovery-ru (Russian) into ~/.claude/, plus a company profile
#  template you fill in once.
#  Touches nothing else on your system.
#
#  Author: Uladzislau Dziarkach (Vladislav Derkach)
#  https://www.linkedin.com/in/vladislavderkach/en/
# ─────────────────────────────────────────────────────────────
set -euo pipefail

BASE="${PDF_BASE:-https://product-discovery.dervlad.com}"
CLAUDE_DIR="$HOME/.claude"
AGENTS_DIR="$CLAUDE_DIR/agents"
SKILL_DIR="$CLAUDE_DIR/skills/product-discovery"
SKILL_RU_DIR="$CLAUDE_DIR/skills/product-discovery-ru"
PROFILE="$CLAUDE_DIR/discovery-profile.md"

AGENTS=(
  discovery-request-agent
  context-recovery-agent
  market-source-map-agent
  product-knowledge-agent
  internal-data-agent
  feature-intelligence-agent
  community-signal-intelligence-agent
  trend-analyst
  ajtbd-canon-validator
  ajtbd-segmentation-agent
  discovery-qa-agent
  market-opportunity-roi-agent
  discovery-final-report-agent
  slop-logic-qa-agent
  report-translation-agent
)

echo ""
echo "  Product Discovery Flow — install"
echo "  → $AGENTS_DIR"
echo "  → $SKILL_DIR"
echo "  → $SKILL_RU_DIR"
echo "  → $CLAUDE_DIR/discovery-profile.template.md"
echo ""

mkdir -p "$AGENTS_DIR" "$SKILL_DIR" "$SKILL_RU_DIR"

for a in "${AGENTS[@]}"; do
  printf "  ↓ agent    %-42s" "$a.md"
  if curl -fsSL "$BASE/files/agents/$a.md" -o "$AGENTS_DIR/$a.md"; then
    echo "ok"
  else
    echo "FAILED"; exit 1
  fi
done

printf "  ↓ skill    %-42s" "SKILL.md (en)"
if curl -fsSL "$BASE/files/skill/SKILL.md" -o "$SKILL_DIR/SKILL.md"; then
  echo "ok"
else
  echo "FAILED"; exit 1
fi

printf "  ↓ skill    %-42s" "SKILL.md (ru)"
if curl -fsSL "$BASE/files/skill-ru/SKILL.md" -o "$SKILL_RU_DIR/SKILL.md"; then
  echo "ok"
else
  echo "FAILED"; exit 1
fi

for f in discovery-profile.template.md discovery-profile.example.md; do
  printf "  ↓ profile  %-42s" "$f"
  if curl -fsSL "$BASE/files/profile/$f" -o "$CLAUDE_DIR/$f"; then
    echo "ok"
  else
    echo "FAILED"; exit 1
  fi
done

# Never overwrite a profile the user already filled in.
if [ -f "$PROFILE" ]; then
  echo "  = profile  discovery-profile.md                        kept (already exists)"
  PROFILE_STATE="kept"
else
  PROFILE_STATE="new"
fi

echo ""
echo "  ✓ Installed: 15 agents + /product-discovery (en) + /product-discovery-ru (ru)"
echo ""
echo "  Next:"
echo "   1) Restart Claude Code (to pick up the new agents and skill)"
echo "   2) Check /agents — 15 new ones should appear"
if [ "$PROFILE_STATE" = "new" ]; then
echo "   3) Run:  /product-discovery <your brief>   (or /product-discovery-ru for Russian)"
echo "      On the first run it will offer to build your company profile"
echo "      (~/.claude/discovery-profile.md) by asking you six questions."
echo "      Prefer to write it yourself? Copy discovery-profile.template.md"
echo "      to discovery-profile.md and fill it in — see the .example.md."
else
echo "   3) Run:  /product-discovery <your brief>   (or /product-discovery-ru for Russian)"
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
echo "  Author: Uladzislau Dziarkach (Vladislav Derkach)"
echo "  https://www.linkedin.com/in/vladislavderkach/en/"
echo ""
