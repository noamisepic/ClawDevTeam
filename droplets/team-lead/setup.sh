#!/bin/bash
# Droplet 1 (Team Lead / Alex) — One-time setup script
# Run this on a fresh DigitalOcean Ubuntu droplet to configure Alex's OpenClaw instance
#
# Prerequisites on the droplet:
#   - Ubuntu 22.04+
#   - SSH key access
#   - GitHub SSH key or PAT configured
#
# Usage:
#   ssh root@<DROPLET_1_IP>
#   curl -fsSL https://raw.githubusercontent.com/<user>/ClawDevTeam/main/droplets/team-lead/setup.sh | bash

set -e

REPO_URL="${OPENCLAW_REPO_URL:-git@github.com:REPLACE_ME/ClawDevTeam.git}"
REPO_DIR="/opt/openclaw/repo"
AGENT_ID="team-lead"
OPENCLAW_WORKSPACE="$HOME/.openclaw/agents/${AGENT_ID}"

echo "🦞 Setting up OpenClaw Droplet 1 — Team Lead (Alex)"
echo ""

# ── System deps ───────────────────────────────────────────────────────────────
echo "📦 Installing system dependencies..."
apt-get update -qq
apt-get install -y -qq git curl build-essential

# ── Node.js 22 ────────────────────────────────────────────────────────────────
if ! command -v node &>/dev/null || [[ "$(node -v)" < "v22" ]]; then
  echo "📦 Installing Node.js 22..."
  curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
  apt-get install -y nodejs
fi
echo "✅ Node $(node -v)"

# ── OpenClaw ──────────────────────────────────────────────────────────────────
echo "📦 Installing OpenClaw..."
npm install -g openclaw@latest
echo "✅ OpenClaw $(openclaw --version)"

# ── Clone repo ────────────────────────────────────────────────────────────────
echo "📂 Cloning repository..."
mkdir -p "$(dirname "$REPO_DIR")"
if [ -d "$REPO_DIR/.git" ]; then
  cd "$REPO_DIR" && git pull
else
  git clone "$REPO_URL" "$REPO_DIR"
fi
echo "✅ Repo at $REPO_DIR"

# ── Configure git for autonomous commits ──────────────────────────────────────
cd "$REPO_DIR"
git config user.email "alex-team-lead@openclaw.local"
git config user.name "Alex (Team Lead)"

# ── Install OpenClaw workspace for Alex ───────────────────────────────────────
echo "🦞 Configuring OpenClaw workspace for Alex..."
mkdir -p "$OPENCLAW_WORKSPACE"

# Copy Alex's SOUL.md to his workspace
cp "$REPO_DIR/.openclaw/team-lead/SOUL.md" "$OPENCLAW_WORKSPACE/SOUL.md"

# Copy AGENTS.md as the project playbook
cp "$REPO_DIR/AGENTS.md" "$OPENCLAW_WORKSPACE/AGENTS.md"

echo "✅ Workspace configured at $OPENCLAW_WORKSPACE"

# ── Create systemd service for standup timer ──────────────────────────────────
echo "⚙️  Installing standup timer service..."
cat > /etc/systemd/system/openclaw-team-lead.service << EOF
[Unit]
Description=OpenClaw Team Lead Standup Timer
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=${REPO_DIR}
Environment=STANDUP_INTERVAL=${STANDUP_INTERVAL:-600}
Environment=OPENCLAW_AGENT_DIR=${OPENCLAW_WORKSPACE}
ExecStart=/bin/bash ${REPO_DIR}/droplets/team-lead/standup-timer.sh
Restart=on-failure
RestartSec=30
StandardOutput=append:/var/log/openclaw-team-lead.log
StandardError=append:/var/log/openclaw-team-lead.log

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable openclaw-team-lead
echo "✅ Service installed (not started yet)"

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Droplet 1 (Team Lead) setup complete!                   ║"
echo "║                                                          ║"
echo "║  To start the autonomous standup loop:                   ║"
echo "║    systemctl start openclaw-team-lead                    ║"
echo "║                                                          ║"
echo "║  To trigger a single standup now:                        ║"
echo "║    cd ${REPO_DIR} && bash droplets/team-lead/standup-timer.sh once"
echo "║                                                          ║"
echo "║  To watch the logs:                                      ║"
echo "║    tail -f /var/log/openclaw-team-lead.log               ║"
echo "╚══════════════════════════════════════════════════════════╝"
