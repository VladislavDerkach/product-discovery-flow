#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  RedTrack Product Discovery Flow — installer for Claude Code
#  Ставит 15 саб-агентов + скилл /rt-product-discovery в ~/.claude/
#  Ничего, кроме этих файлов, не трогает.
#
#  Author: Uladzislau Dziarkach (Vladislav Derkach)
#  https://www.linkedin.com/in/vladislavderkach/en/
# ─────────────────────────────────────────────────────────────
set -euo pipefail

BASE="https://rt-discovery-flow.vercel.app"
AGENTS_DIR="$HOME/.claude/agents"
SKILL_DIR="$HOME/.claude/skills/rt-product-discovery"

AGENTS=(
  discovery-request-agent
  context-recovery-rt-agent
  market-source-map-agent
  knowledge-base-rt-check-agent
  rt-analytics-agent
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
echo "  RedTrack Product Discovery Flow — установка"
echo "  → $AGENTS_DIR"
echo "  → $SKILL_DIR"
echo ""

mkdir -p "$AGENTS_DIR" "$SKILL_DIR"

for a in "${AGENTS[@]}"; do
  printf "  ↓ agent  %-40s" "$a.md"
  if curl -fsSL "$BASE/files/agents/$a.md" -o "$AGENTS_DIR/$a.md"; then
    echo "ok"
  else
    echo "FAILED"; exit 1
  fi
done

printf "  ↓ skill  %-40s" "SKILL.md"
if curl -fsSL "$BASE/files/skill/SKILL.md" -o "$SKILL_DIR/SKILL.md"; then
  echo "ok"
else
  echo "FAILED"; exit 1
fi

echo ""
echo "  ✓ Установлено: 15 агентов + скилл rt-product-discovery"
echo ""
echo "  Дальше:"
echo "   1) Перезапусти Claude Code (чтобы подхватить новые агенты и скилл)"
echo "   2) Проверь /agents — должно быть 15 новых"
echo "   3) Запусти:  /rt-product-discovery <твой бриф>"
echo ""
echo "  Для полного прогона подключи коннекторы (через /mcp):"
echo "   Notion · ChartMogul · HubSpot · Slack · Telegram"
echo "  А для шага 5 (Canon Validator) — канон Next Move Theory на диске."
echo ""
echo "  Author: Uladzislau Dziarkach (Vladislav Derkach)"
echo "  https://www.linkedin.com/in/vladislavderkach/en/"
echo ""
