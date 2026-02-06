#!/usr/bin/env bash
# FHIRLab Core - Start Script
# ===========================
# Starts all FHIRLab Core services and waits for them to be healthy.
#
# Usage:
#   ./start.sh          # Start core services (HAPI FHIR, Snowstorm)
#   ./start.sh --smart  # Start with SMART launcher service (separate from HAPI)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKER_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Parse arguments
PROFILE=""
if [[ "$1" == "--smart" ]]; then
    PROFILE="--profile smart"
    print_status "SMART launcher service will be started (separate service)"
fi

# Change to docker directory
cd "$DOCKER_DIR"

# Check for .env file
if [[ ! -f ".env" ]]; then
    print_warning ".env file not found, copying from .env.example"
    cp .env.example .env
fi

# Start services
print_status "Starting FHIRLab Core services..."
docker compose $PROFILE up -d

# Wait for services to be healthy
print_status "Waiting for services to become healthy..."

wait_for_service() {
    local service=$1
    local url=$2
    local max_attempts=${3:-60}
    local attempt=1

    while [[ $attempt -le $max_attempts ]]; do
        if curl -sf "$url" > /dev/null 2>&1; then
            return 0
        fi
        echo -n "."
        sleep 5
        ((attempt++))
    done
    return 1
}

# Wait for HAPI FHIR
echo -n "  HAPI FHIR: "
if wait_for_service "hapi-fhir" "http://localhost:${HAPI_FHIR_PORT:-8080}/fhir/metadata"; then
    print_success "Ready"
else
    print_error "Failed to start (timeout)"
    exit 1
fi

# Wait for Elasticsearch
echo -n "  Elasticsearch: "
if wait_for_service "elasticsearch" "http://localhost:${ES_PORT:-9200}" 30; then
    print_success "Ready"
else
    print_warning "May still be starting..."
fi

# Wait for Snowstorm
echo -n "  Snowstorm: "
if wait_for_service "snowstorm" "http://localhost:${SNOWSTORM_PORT:-8081}/version" 60; then
    print_success "Ready"
else
    print_warning "May still be starting (can take several minutes)..."
fi

# Check SMART launcher if enabled
if [[ -n "$PROFILE" ]]; then
    echo -n "  SMART Launcher (separate service): "
    if wait_for_service "smart-launcher" "http://localhost:${SMART_LAUNCHER_PORT:-8083}" 30; then
        print_success "Ready"
    else
        print_warning "May still be starting..."
    fi
fi

echo ""
print_success "FHIRLab Core is starting!"
echo ""
echo "Service URLs:"
echo "  HAPI FHIR:       http://localhost:${HAPI_FHIR_PORT:-8080}/fhir"
echo "  Snowstorm:       http://localhost:${SNOWSTORM_PORT:-8081}"
echo "  SNOMED Browser:  http://localhost:${SNOMED_BROWSER_PORT:-8082}"
if [[ -n "$PROFILE" ]]; then
    echo "  SMART Launcher:  http://localhost:${SMART_LAUNCHER_PORT:-8083}"
fi
echo ""
echo "Run './scripts/smoke-test.sh' to verify all services are working."
echo "Run './scripts/stop.sh' to stop all services."
