#!/bin/bash
# Droplet 3 — Backend Dev (Jordan) task watcher
# Polls the GitHub repo for new task assignments. When tasks/assigned/backend.md
# changes, invokes OpenClaw to execute the work.
#
# Usage:   POLL_INTERVAL=60 bash droplets/backend-dev/watch-tasks.sh

set -e

POLL_INTERVAL=${POLL_INTERVAL:-60}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
TASK_FILE="${REPO_ROOT}/tasks/assigned/backend.md"
STATE_FILE="/tmp/openclaw-backend-last-hash"
AGENT_DIR="${OPENCLAW_AGENT_DIR:-$HOME/.openclaw/agents/backend-dev}"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [backend] $*"; }

log "🚀 Backend Dev (Jordan) task watcher started"
log "   Repo: $REPO_ROOT"
log "   Polling every: ${POLL_INTERVAL}s"
log "   Watching: tasks/assigned/backend.md"

# Initialize state
LAST_HASH=$(cat "$STATE_FILE" 2>/dev/null || echo "none")

while true; do
  # ── Pull latest from GitHub ─────────────────────────────────────────────
  cd "$REPO_ROOT"
  git pull --rebase --autostash --quiet 2>/dev/null || log "⚠️  git pull failed"

  # ── Check for new assignments ────────────────────────────────────────────
  if [ -f "$TASK_FILE" ]; then
    CURRENT_HASH=$(md5sum "$TASK_FILE" | cut -d' ' -f1)

    if [ "$CURRENT_HASH" != "$LAST_HASH" ] && [ "$(wc -c < "$TASK_FILE")" -gt 10 ]; then
      log "📋 New assignment detected! Executing tasks..."
      LAST_HASH="$CURRENT_HASH"
      echo "$LAST_HASH" > "$STATE_FILE"

      # Re-sync Jordan's SOUL.md in case it was updated
      cp "${REPO_ROOT}/.openclaw/backend-dev/SOUL.md" "${AGENT_DIR}/SOUL.md" 2>/dev/null || true
      cp "${REPO_ROOT}/AGENTS.md" "${AGENT_DIR}/AGENTS.md" 2>/dev/null || true

      # Determine current round from number of backend reports written
      ROUND=$(( $(ls "${REPO_ROOT}/standup-log/standup-"*"-backend.md" 2>/dev/null | wc -l) + 1 ))
      log "Executing as round ${ROUND}..."

      openclaw agent \
        --message "You are Jordan, the Backend Developer. Your persona is in your SOUL.md. The project playbook is in AGENTS.md (also at ${REPO_ROOT}/AGENTS.md).

You have a new task assignment. Execute it now.

Your steps:
1. Run: cd ${REPO_ROOT} && git pull
2. Read tasks/assigned/backend.md for your current assignment
3. Read existing code in restaurant-app/backend/ to understand what's already there
4. Execute the task completely — write production-quality Express + SQLite code to restaurant-app/backend/
5. Write your standup report to standup-log/standup-${ROUND}-backend.md following the format in AGENTS.md
6. Run: cd ${REPO_ROOT} && git add restaurant-app/backend/ standup-log/ && git commit -m '[backend] <describe what you built>' && git push

Do not stop until the task is complete and pushed. Use the API response contract: { success: true/false, data/error: ... } for all endpoints. Handle all error cases, not just happy path." \
        --thinking high

      log "✅ Task execution complete for round ${ROUND}"
    fi
  else
    log "⏳ No assignment file yet — waiting for Team Lead..."
  fi

  log "💤 Sleeping ${POLL_INTERVAL}s..."
  sleep "$POLL_INTERVAL"
done
