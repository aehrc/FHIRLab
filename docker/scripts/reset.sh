#!/usr/bin/env bash
# FHIRLab Core - Reset Script
# ===========================
# Stops all services and removes all data volumes.
# WARNING: This will delete all FHIR resources, terminology data, and configurations.
#
# Usage:
#   ./reset.sh          # Interactive - asks for confirmation
#   ./reset.sh --force  # Skip confirmation prompt

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKER_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[FHIRLab]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[FHIRLab]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[FHIRLab]${NC} $1"
}

print_error() {
    echo -e "${RED}[FHIRLab]${NC} $1"
}

cd "$DOCKER_DIR"

# Check for --force flag
FORCE=false
if [[ "$1" == "--force" ]]; then
    FORCE=true
fi

# Confirmation prompt
if [[ "$FORCE" != "true" ]]; then
    echo ""
    print_warning "WARNING: This will delete ALL FHIRLab Core data!"
    echo ""
    echo "The following will be removed:"
    echo "  - All FHIR resources in HAPI FHIR"
    echo "  - All Elasticsearch/Snowstorm data"
    echo "  - Any uploaded terminology"
    echo ""
    read -p "Are you sure you want to continue? (yes/no): " confirm

    if [[ "$confirm" != "yes" ]]; then
        print_status "Reset cancelled."
        exit 0
    fi
fi

print_status "Stopping all services..."
docker compose --profile smart down 2>/dev/null || true

print_status "Removing data volumes..."
docker volume rm fhirlab-elastic-data 2>/dev/null || true

# Also try to remove any orphaned volumes with the project prefix
docker volume ls --filter "name=fhirlab" -q | xargs -r docker volume rm 2>/dev/null || true

print_success "Reset complete!"
echo ""
echo "FHIRLab Core has been reset to a clean state."
echo "Run './scripts/start.sh' to start fresh."
