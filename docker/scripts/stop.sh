#!/usr/bin/env bash
# FHIRLab Core - Stop Script
# ==========================
# Gracefully stops all FHIRLab Core services.
# Data is preserved in Docker volumes.
#
# Usage:
#   ./stop.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKER_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[FHIRLab]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[FHIRLab]${NC} $1"
}

cd "$DOCKER_DIR"

print_status "Stopping FHIRLab Core services..."

# Stop all services (including any profiles)
docker compose --profile smart down

print_success "All services stopped."
echo ""
echo "Your data is preserved. Run './scripts/start.sh' to restart."
echo "To remove all data, run './scripts/reset.sh'"
