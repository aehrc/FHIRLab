#!/usr/bin/env bash
# FHIRLab Core - Smoke Test Script
# ================================
# Verifies all FHIRLab Core services are running and responding correctly.
#
# Usage:
#   ./smoke-test.sh           # Test core services
#   ./smoke-test.sh --smart   # Also test SMART launcher service (separate from HAPI)
#   ./smoke-test.sh --formlab # Also test FormLab services

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKER_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Load environment variables
if [[ -f "$DOCKER_DIR/.env" ]]; then
    source "$DOCKER_DIR/.env"
fi

# Parse arguments
CHECK_SMART=false
CHECK_FORMLAB=false
if [[ "$1" == "--smart" ]]; then
    CHECK_SMART=true
elif [[ "$1" == "--formlab" ]]; then
    CHECK_FORMLAB=true
fi

# Counters
PASSED=0
FAILED=0
WARNINGS=0

print_header() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}  FHIRLab Core - Smoke Test${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

print_test() {
    printf "  %-25s" "$1"
}

print_pass() {
    echo -e "${GREEN}PASS${NC}"
    ((PASSED++)) || true
}

print_fail() {
    echo -e "${RED}FAIL${NC} - $1"
    ((FAILED++)) || true
}

print_warn() {
    echo -e "${YELLOW}WARN${NC} - $1"
    ((WARNINGS++)) || true
}

# Test functions
test_hapi_fhir() {
    print_test "HAPI FHIR Server"

    local url="http://localhost:${HAPI_FHIR_PORT:-8080}/fhir/metadata"
    local response

    response=$(curl -sf "$url" 2>/dev/null) || {
        print_fail "Not responding at $url"
        return 1
    }

    # Check it's a valid CapabilityStatement
    if echo "$response" | grep -q '"resourceType".*"CapabilityStatement"'; then
        print_pass
        return 0
    else
        print_fail "Invalid response (not a CapabilityStatement)"
        return 1
    fi
}

test_hapi_fhir_r4() {
    print_test "HAPI FHIR R4 Version"

    local url="http://localhost:${HAPI_FHIR_PORT:-8080}/fhir/metadata"
    local response

    response=$(curl -sf "$url" 2>/dev/null) || {
        print_fail "Could not fetch metadata"
        return 1
    }

    if echo "$response" | grep -q '"fhirVersion".*"4\.'; then
        print_pass
        return 0
    else
        print_warn "Could not confirm R4 version"
        return 1
    fi
}

test_elasticsearch() {
    print_test "Elasticsearch"

    local url="http://localhost:${ES_PORT:-9200}"
    # Handle case where ES_PORT includes bind address
    if [[ "$url" == *":"*":"* ]]; then
        url="http://localhost:9200"
    fi

    local response
    response=$(curl -sf "$url" 2>/dev/null) || {
        print_fail "Not responding at $url"
        return 1
    }

    if echo "$response" | grep -q '"cluster_name"'; then
        print_pass
        return 0
    else
        print_fail "Invalid response"
        return 1
    fi
}

test_snowstorm() {
    print_test "Snowstorm"

    local url="http://localhost:${SNOWSTORM_PORT:-8081}/version"
    local response

    response=$(curl -sf "$url" 2>/dev/null) || {
        print_fail "Not responding at $url"
        return 1
    }

    if echo "$response" | grep -qi "snowstorm\|version"; then
        print_pass
        return 0
    else
        print_warn "Responding but version unclear"
        return 1
    fi
}

test_snomed_browser() {
    print_test "SNOMED Browser"

    local url="http://localhost:${SNOMED_BROWSER_PORT:-8082}"

    if curl -sf "$url" > /dev/null 2>&1; then
        print_pass
        return 0
    else
        print_warn "Not responding (optional service)"
        return 1
    fi
}

test_smart_launcher() {
    print_test "SMART Launcher"

    local url="http://localhost:${SMART_LAUNCHER_PORT:-8083}"

    if curl -sf "$url" > /dev/null 2>&1; then
        print_pass
        return 0
    else
        print_fail "Not responding at $url"
        return 1
    fi
}

test_formlab_homepage() {
    print_test "FormLab Homepage"

    local url="http://localhost:${FORMLAB_PORT:-8084}"

    if curl -sf "$url" > /dev/null 2>&1; then
        print_pass
        return 0
    else
        print_fail "Not responding at $url"
        return 1
    fi
}

test_formlab_fhir() {
    print_test "FormLab FHIR Server"

    local url="http://localhost:${FORMLAB_FHIR_PORT:-8088}/fhir/metadata"
    local response

    response=$(curl -sf "$url" 2>/dev/null) || {
        print_fail "Not responding at $url"
        return 1
    }

    if echo "$response" | grep -q '"resourceType".*"CapabilityStatement"'; then
        print_pass
        return 0
    else
        print_fail "Invalid response"
        return 1
    fi
}

print_summary() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo "  Summary"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    echo -e "  ${GREEN}Passed:${NC}   $PASSED"
    echo -e "  ${RED}Failed:${NC}   $FAILED"
    echo -e "  ${YELLOW}Warnings:${NC} $WARNINGS"
    echo ""

    if [[ $FAILED -eq 0 ]]; then
        echo -e "${GREEN}All critical tests passed!${NC}"
        return 0
    else
        echo -e "${RED}Some tests failed. Check the services above.${NC}"
        return 1
    fi
}

# Main execution
print_header

echo "Core Services:"
test_hapi_fhir || true
test_hapi_fhir_r4 || true
test_elasticsearch || true
test_snowstorm || true
test_snomed_browser || true

if [[ "$CHECK_SMART" == "true" ]]; then
    echo ""
    echo "SMART Launcher Service (separate from HAPI):"
    test_smart_launcher || true
fi

if [[ "$CHECK_FORMLAB" == "true" ]]; then
    echo ""
    echo "FormLab Services:"
    test_formlab_homepage || true
    test_formlab_fhir || true
fi

print_summary
exit $FAILED
