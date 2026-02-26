#!/bin/bash
# Droplet 1 — Team Lead standup timer
# Runs continuously; wakes every STANDUP_INTERVAL seconds and runs a standup round
#
# Usage (direct):   STANDUP_INTERVAL=600 bash droplets/team-lead/standup-timer.sh
# Usage (once):     bash droplets/team-lead/standup-timer.sh once
# Managed by:       systemctl start openclaw-team-lead

set -e

INTERVAL=${STANDUP_INTERVAL:-600}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
ONCE_MODE="${1:-}"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }

cd "$REPO_ROOT"

# Determine starting round from existing summaries
count_summaries() {
  ls standup-log/standup-*-summary.md 2>/dev/null | wc -l
}

run_round() {
  local round=$1
  log "🔔 Running standup round ${round}..."

  # Sync latest from GitHub first
  git pull --rebase --autostash || log "⚠️  git pull failed — continuing anyway"

  # Re-sync Alex's SOUL.md in case it was updated
  AGENT_DIR="${OPENCLAW_AGENT_DIR:-$HOME/.openclaw/agents/team-lead}"
  cp "${REPO_ROOT}/.openclaw/team-lead/SOUL.md" "${AGENT_DIR}/SOUL.md" 2>/dev/null || true
  cp "${REPO_ROOT}/AGENTS.md" "${AGENT_DIR}/AGENTS.md" 2>/dev/null || true

  openclaw agent \
    --message "You are Alex, the Team Lead. Your persona is in your SOUL.md. The project playbook is in AGENTS.md (also in your workspace and in the repo at ${REPO_ROOT}/AGENTS.md).

You are running standup round ${round} for the OpenClaw dev team building Casa del Sol.

Your full instructions:
1. Run: cd ${REPO_ROOT} && git pull
2. If round 1: read tasks/backlog.md and understand all tasks.
3. Check standup-log/ for any existing dev reports for round ${round}.
4. Write standup-log/standup-${round}-summary.md following the format in AGENTS.md.
5. Write tasks/assigned/frontend.md with Sam's assignment for round ${round} (include full task details).
6. Write tasks/assigned/backend.md with Jordan's assignment for round ${round} (include full task details).
7. Run: cd ${REPO_ROOT} && git add standup-log/ tasks/assigned/ && git commit -m '[lead] standup-${round} summary and task assignments' && git push

Be decisive. Use the escalation policy if any dev is blocked. Make sure every assignment has enough detail for the dev to execute without asking questions." \
    --thinking high

  log "✅ Standup round ${round} complete"
}

# ── Main loop ──────────────────────────────────────────────────────────────────
if [ "$ONCE_MODE" = "once" ]; then
  ROUND=$(( $(count_summaries) + 1 ))
  run_round "$ROUND"
  exit 0
fi

ROUND=$(( $(count_summaries) + 1 ))
log "🚀 Team Lead standup timer started (interval: ${INTERVAL}s, starting at round ${ROUND})"

while true; do
  log "⏰ Sleeping ${INTERVAL}s before round ${ROUND}..."
  sleep "$INTERVAL"
  run_round "$ROUND"
  ROUND=$(( ROUND + 1 ))
done
