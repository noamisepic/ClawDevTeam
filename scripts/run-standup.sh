#!/bin/bash
# run-standup.sh — Manually trigger a single standup round on Droplet 1
# This is a convenience wrapper; production use is via droplets/team-lead/standup-timer.sh
#
# Usage: bash scripts/run-standup.sh [ROUND_NUMBER]

set -e

ROUND=${1:-1}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Manually triggering standup round ${ROUND}..."

bash "${REPO_ROOT}/droplets/team-lead/standup-timer.sh" once
