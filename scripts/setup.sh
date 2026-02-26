#!/bin/bash
# setup.sh — One-time local bootstrap: init git, create GitHub repo, push initial commit
# Run this ONCE on your local machine before spinning up the DigitalOcean droplets.
#
# Usage: bash scripts/setup.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "🦞 OpenClaw Dev Team — Project Bootstrap"
echo "   Casa del Sol Restaurant Website"
echo ""

cd "$REPO_ROOT"

# ── Git init ──────────────────────────────────────────────────────────────────
if [ ! -d ".git" ]; then
  git init
  git branch -M main
  echo "✅ Git initialized"
else
  echo "✅ Git already initialized"
fi

# ── Git user (for initial commit) ─────────────────────────────────────────────
if [ -z "$(git config user.email)" ]; then
  git config user.email "openclaw-setup@localhost"
  git config user.name "OpenClaw Setup"
fi

# ── Initial commit ────────────────────────────────────────────────────────────
git add .
git commit -m "[setup] Initialize OpenClaw dev team project

- AGENTS.md: OpenClaw operational playbook
- .openclaw/: SOUL.md persona files for Alex, Sam, Jordan
- droplets/: Per-droplet setup + standup/watch scripts
- tasks/backlog.md: 15 seeded tasks for Casa del Sol
- restaurant-app/: React + Express scaffold
- standup-log/: Ready for agent reports"

echo "✅ Initial commit created"

# ── Create GitHub repo ────────────────────────────────────────────────────────
echo ""
echo "🐙 Creating GitHub repository..."
if command -v gh &>/dev/null; then
  gh repo create ClawDevTeam --public --source=. --push
  REMOTE_URL=$(git remote get-url origin)
  echo "✅ GitHub repo created and pushed!"
  echo "   Remote: $REMOTE_URL"
else
  echo "⚠️  gh CLI not found. Create the repo manually, then:"
  echo "   git remote add origin git@github.com:YOUR_USER/ClawDevTeam.git"
  echo "   git push -u origin main"
  REMOTE_URL="git@github.com:YOUR_USER/ClawDevTeam.git"
fi

# ── Print droplet instructions ─────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║  Bootstrap complete! Now provision 3 DigitalOcean droplets:      ║"
echo "╠══════════════════════════════════════════════════════════════════╣"
echo "║                                                                  ║"
echo "║  DROPLET 1 — Team Lead (Alex)                                    ║"
echo "║  Ubuntu 22.04, 1GB+                                              ║"
echo "║                                                                  ║"
echo "║    ssh root@<DROPLET_1_IP>                                       ║"
echo "║    OPENCLAW_REPO_URL=${REMOTE_URL} \\"
echo "║    STANDUP_INTERVAL=600 \\"
echo "║    bash <(curl -fsSL <RAW_URL>/droplets/team-lead/setup.sh)      ║"
echo "║    systemctl start openclaw-team-lead                            ║"
echo "║                                                                  ║"
echo "║  DROPLET 2 — Frontend Dev (Sam)                                  ║"
echo "║  Ubuntu 22.04, 1GB+                                              ║"
echo "║                                                                  ║"
echo "║    ssh root@<DROPLET_2_IP>                                       ║"
echo "║    OPENCLAW_REPO_URL=${REMOTE_URL} \\"
echo "║    POLL_INTERVAL=30 \\"
echo "║    bash <(curl -fsSL <RAW_URL>/droplets/frontend-dev/setup.sh)   ║"
echo "║    systemctl start openclaw-frontend-dev                         ║"
echo "║                                                                  ║"
echo "║  DROPLET 3 — Backend Dev (Jordan)                                ║"
echo "║  Ubuntu 22.04, 1GB+                                              ║"
echo "║                                                                  ║"
echo "║    ssh root@<DROPLET_3_IP>                                       ║"
echo "║    OPENCLAW_REPO_URL=${REMOTE_URL} \\"
echo "║    POLL_INTERVAL=30 \\"
echo "║    bash <(curl -fsSL <RAW_URL>/droplets/backend-dev/setup.sh)    ║"
echo "║    systemctl start openclaw-backend-dev                          ║"
echo "║                                                                  ║"
echo "╠══════════════════════════════════════════════════════════════════╣"
echo "║  Once all 3 droplets are running, watch progress with:           ║"
echo "║    watch -n5 'git pull -q && git log --oneline -20'              ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
