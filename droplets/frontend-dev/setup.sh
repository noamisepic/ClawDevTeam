#!/bin/bash
# Droplet 2 (Frontend Dev / Sam) — One-time setup script
# Run this on a fresh DigitalOcean Ubuntu droplet to configure Sam's OpenClaw instance
#
# Usage:
#   ssh root@<DROPLET_2_IP>
#   curl -fsSL https://raw.githubusercontent.com/<user>/ClawDevTeam/main/droplets/frontend-dev/setup.sh | bash

set -e

REPO_URL="${OPENCLAW_REPO_URL:-git@github.com:REPLACE_ME/ClawDevTeam.git}"
REPO_DIR="/opt/openclaw/repo"
AGENT_ID="frontend-dev"
OPENCLAW_WORKSPACE="$HOME/.openclaw/agents/${AGENT_ID}"

echo "🦞 Setting up OpenClaw Droplet 2 — Frontend Dev (Sam)"
echo ""

# ── System deps ───────────────────────────────────────────────────────────────
apt-get update -qq
apt-get install -y -qq git curl build-essential

# ── Node.js 22 ────────────────────────────────────────────────────────────────
if ! command -v node &>/dev/null || [[ "$(node -v)" < "v22" ]]; then
  curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
  apt-get install -y nodejs
fi
echo "✅ Node $(node -v)"

# ── OpenClaw ──────────────────────────────────────────────────────────────────
npm install -g openclaw@latest
echo "✅ OpenClaw $(openclaw --version)"

# ── Clone repo ────────────────────────────────────────────────────────────────
mkdir -p "$(dirname "$REPO_DIR")"
if [ -d "$REPO_DIR/.git" ]; then
  cd "$REPO_DIR" && git pull
else
  git clone "$REPO_URL" "$REPO_DIR"
fi
cd "$REPO_DIR"
git config user.email "sam-frontend@openclaw.local"
git config user.name "Sam (Frontend Dev)"
echo "✅ Repo at $REPO_DIR"

# ── Configure OpenClaw workspace for Sam ──────────────────────────────────────
mkdir -p "$OPENCLAW_WORKSPACE"
cp "$REPO_DIR/.openclaw/frontend-dev/SOUL.md" "$OPENCLAW_WORKSPACE/SOUL.md"
cp "$REPO_DIR/AGENTS.md" "$OPENCLAW_WORKSPACE/AGENTS.md"
echo "✅ Workspace configured at $OPENCLAW_WORKSPACE"

# ── Create systemd service ────────────────────────────────────────────────────
cat > /etc/systemd/system/openclaw-frontend-dev.service << EOF
[Unit]
Description=OpenClaw Frontend Dev Task Watcher
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=${REPO_DIR}
Environment=POLL_INTERVAL=${POLL_INTERVAL:-60}
Environment=OPENCLAW_AGENT_DIR=${OPENCLAW_WORKSPACE}
ExecStart=/bin/bash ${REPO_DIR}/droplets/frontend-dev/watch-tasks.sh
Restart=on-failure
RestartSec=30
StandardOutput=append:/var/log/openclaw-frontend-dev.log
StandardError=append:/var/log/openclaw-frontend-dev.log

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable openclaw-frontend-dev

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Droplet 2 (Frontend Dev) setup complete!                ║"
echo "║                                                          ║"
echo "║  To start the task watcher:                              ║"
echo "║    systemctl start openclaw-frontend-dev                 ║"
echo "║                                                          ║"
echo "║  To watch the logs:                                      ║"
echo "║    tail -f /var/log/openclaw-frontend-dev.log            ║"
echo "╚══════════════════════════════════════════════════════════╝"
