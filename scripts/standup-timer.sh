#!/bin/bash
# standup-timer.sh — Local convenience wrapper for the Team Lead standup timer
# In production this runs on Droplet 1 as a systemd service.
# Locally it can be used for testing the full flow without deploying to DigitalOcean.
#
# Usage: STANDUP_INTERVAL=60 bash scripts/standup-timer.sh &

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec bash "${SCRIPT_DIR}/../droplets/team-lead/standup-timer.sh" "$@"
