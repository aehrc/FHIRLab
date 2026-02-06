#!/usr/bin/env bash
# FHIRLab Core - Upload Terminology Script
# ========================================
# Uploads terminology files to HAPI FHIR server.
# Uses the HAPI FHIR CLI bundled inside the Docker container - no local installation required.
#
# Reference: https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-terminology
#
# Usage:
#   ./upload-terminology.sh <path-to-terminology-file>
#
# Supported formats:
#   - CodeSystem resources (JSON/XML)
#   - ValueSet resources (JSON/XML)
#   - FHIR Bundles containing terminology resources

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

# Load environment variables
if [[ -f "$DOCKER_DIR/.env" ]]; then
    source "$DOCKER_DIR/.env"
fi

CONTAINER_NAME="fhirlab-hapi-fhir"
FHIR_SERVER_INTERNAL="http://localhost:8080/fhir"
FHIR_SERVER_EXTERNAL="http://localhost:${HAPI_FHIR_PORT:-8080}/fhir"

# Check arguments
if [[ -z "$1" ]]; then
    print_error "No terminology file specified!"
    echo ""
    echo "Usage: ./upload-terminology.sh <path-to-terminology-file>"
    echo ""
    echo "Examples:"
    echo "  ./upload-terminology.sh ./my-codesystem.json"
    echo "  ./upload-terminology.sh ./terminology-bundle.xml"
    echo ""
    echo "Supported formats:"
    echo "  - CodeSystem resources (JSON/XML)"
    echo "  - ValueSet resources (JSON/XML)"
    echo "  - FHIR Bundles containing terminology resources"
    echo ""
    echo "Reference: https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-terminology"
    exit 1
fi

TERMINOLOGY_FILE="$1"

# Check file exists
if [[ ! -f "$TERMINOLOGY_FILE" ]]; then
    print_error "File not found: $TERMINOLOGY_FILE"
    exit 1
fi

# Get absolute path and filename
TERMINOLOGY_FILE_ABS="$(cd "$(dirname "$TERMINOLOGY_FILE")" && pwd)/$(basename "$TERMINOLOGY_FILE")"
TERMINOLOGY_FILENAME="$(basename "$TERMINOLOGY_FILE")"

# Check if container is running
check_container() {
    if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        print_error "HAPI FHIR container is not running!"
        echo ""
        echo "Start the services first:"
        echo "  ./scripts/start.sh"
        return 1
    fi
    return 0
}

# Wait for FHIR server to be ready
wait_for_fhir_server() {
    local max_attempts=60
    local attempt=1

    print_status "Waiting for HAPI FHIR server to be ready..."

    while [[ $attempt -le $max_attempts ]]; do
        if curl -sf "$FHIR_SERVER_EXTERNAL/metadata" > /dev/null 2>&1; then
            print_success "HAPI FHIR server is ready"
            return 0
        fi
        echo -n "."
        sleep 2
        ((attempt++)) || true
    done

    echo ""
    print_error "HAPI FHIR server did not become ready within timeout"
    return 1
}

# Main execution
print_status "FHIRLab Core - Upload Terminology"
echo ""

# Check container is running
if ! check_container; then
    exit 1
fi

# Wait for server
if ! wait_for_fhir_server; then
    exit 1
fi

print_status "Uploading terminology from: $TERMINOLOGY_FILE"
echo ""

# Copy file into container and upload
print_status "Copying file to container..."
docker cp "$TERMINOLOGY_FILE_ABS" "$CONTAINER_NAME:/tmp/$TERMINOLOGY_FILENAME"

print_status "Uploading terminology..."
# Upload terminology using HAPI FHIR CLI inside the container
# Reference: https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-terminology
docker exec "$CONTAINER_NAME" \
    java -jar /app/main.war upload-terminology \
    --fhir-version r4 \
    --target "$FHIR_SERVER_INTERNAL" \
    --data "/tmp/$TERMINOLOGY_FILENAME"

# Clean up
docker exec "$CONTAINER_NAME" rm -f "/tmp/$TERMINOLOGY_FILENAME"

echo ""
print_success "Terminology uploaded successfully!"
echo ""
echo "You can verify the upload at: $FHIR_SERVER_EXTERNAL/CodeSystem"
echo "Or search ValueSets at: $FHIR_SERVER_EXTERNAL/ValueSet"
