#!/usr/bin/env bash
# FHIRLab Core - Load Example Data Script
# =======================================
# Loads example FHIR resources into the HAPI FHIR server.
# Note: FormLab has its own sample data loaded automatically on startup.
#
# Usage:
#   ./load-data.sh

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

FHIR_SERVER="http://localhost:${HAPI_FHIR_PORT:-8080}/fhir"

# Wait for FHIR server to be ready
wait_for_fhir_server() {
    local max_attempts=60
    local attempt=1

    print_status "Waiting for HAPI FHIR server to be ready..."

    while [[ $attempt -le $max_attempts ]]; do
        if curl -sf "$FHIR_SERVER/metadata" > /dev/null 2>&1; then
            print_success "HAPI FHIR server is ready"
            return 0
        fi
        echo -n "."
        sleep 2
        ((attempt++)) || true
    done

    echo ""
    print_error "HAPI FHIR server did not become ready within timeout"
    echo "Make sure services are running: ./scripts/start.sh"
    return 1
}

# Create a sample patient
create_patient() {
    local given="$1"
    local family="$2"
    local gender="$3"
    local birthDate="$4"

    curl -sf -X POST "$FHIR_SERVER/Patient" \
        -H "Content-Type: application/fhir+json" \
        -d "{
            \"resourceType\": \"Patient\",
            \"name\": [{\"given\": [\"$given\"], \"family\": \"$family\"}],
            \"gender\": \"$gender\",
            \"birthDate\": \"$birthDate\"
        }" > /dev/null
}

# Create a sample observation
create_observation() {
    local patient_id="$1"
    local code="$2"
    local display="$3"
    local value="$4"
    local unit="$5"

    curl -sf -X POST "$FHIR_SERVER/Observation" \
        -H "Content-Type: application/fhir+json" \
        -d "{
            \"resourceType\": \"Observation\",
            \"status\": \"final\",
            \"code\": {
                \"coding\": [{
                    \"system\": \"http://loinc.org\",
                    \"code\": \"$code\",
                    \"display\": \"$display\"
                }]
            },
            \"subject\": {\"reference\": \"Patient/$patient_id\"},
            \"valueQuantity\": {
                \"value\": $value,
                \"unit\": \"$unit\",
                \"system\": \"http://unitsofmeasure.org\"
            }
        }" > /dev/null
}

# Create a sample practitioner
create_practitioner() {
    local given="$1"
    local family="$2"

    curl -sf -X POST "$FHIR_SERVER/Practitioner" \
        -H "Content-Type: application/fhir+json" \
        -d "{
            \"resourceType\": \"Practitioner\",
            \"name\": [{\"given\": [\"$given\"], \"family\": \"$family\"}]
        }" > /dev/null
}

# Create a sample organization
create_organization() {
    local name="$1"

    curl -sf -X POST "$FHIR_SERVER/Organization" \
        -H "Content-Type: application/fhir+json" \
        -d "{
            \"resourceType\": \"Organization\",
            \"name\": \"$name\"
        }" > /dev/null
}

# Main execution
print_status "FHIRLab Core - Loading Example Data"
echo ""

# Wait for server
if ! wait_for_fhir_server; then
    exit 1
fi

print_status "Uploading example FHIR resources..."
echo ""

# Create Organizations
print_status "Creating organizations..."
create_organization "General Hospital"
create_organization "Community Health Clinic"
create_organization "Specialist Medical Center"
echo -e "  ${GREEN}3 organizations created${NC}"

# Create Practitioners
print_status "Creating practitioners..."
create_practitioner "Sarah" "Johnson"
create_practitioner "Michael" "Chen"
create_practitioner "Emily" "Williams"
create_practitioner "James" "Brown"
create_practitioner "Lisa" "Davis"
echo -e "  ${GREEN}5 practitioners created${NC}"

# Create Patients
print_status "Creating patients..."
create_patient "John" "Smith" "male" "1980-05-15"
create_patient "Jane" "Doe" "female" "1975-08-22"
create_patient "Robert" "Wilson" "male" "1990-03-10"
create_patient "Maria" "Garcia" "female" "1985-11-30"
create_patient "David" "Lee" "male" "1965-07-04"
create_patient "Susan" "Taylor" "female" "1972-01-18"
create_patient "Michael" "Anderson" "male" "1988-09-25"
create_patient "Jennifer" "Martinez" "female" "1995-12-08"
create_patient "William" "Thompson" "male" "1960-04-20"
create_patient "Elizabeth" "White" "female" "1978-06-14"
echo -e "  ${GREEN}10 patients created${NC}"

# Get patient IDs for observations
print_status "Creating observations..."
PATIENTS=$(curl -sf "$FHIR_SERVER/Patient?_count=10" | grep -o '"id":"[^"]*"' | head -5 | sed 's/"id":"//g' | sed 's/"//g')

for patient_id in $PATIENTS; do
    # Blood pressure systolic
    create_observation "$patient_id" "8480-6" "Systolic blood pressure" "$((110 + RANDOM % 40))" "mmHg"
    # Blood pressure diastolic
    create_observation "$patient_id" "8462-4" "Diastolic blood pressure" "$((60 + RANDOM % 30))" "mmHg"
    # Heart rate
    create_observation "$patient_id" "8867-4" "Heart rate" "$((60 + RANDOM % 40))" "/min"
    # Body temperature
    create_observation "$patient_id" "8310-5" "Body temperature" "$(echo "scale=1; 36.5 + $RANDOM % 15 / 10" | bc)" "Cel"
    # Body weight
    create_observation "$patient_id" "29463-7" "Body weight" "$((50 + RANDOM % 50))" "kg"
done
echo -e "  ${GREEN}25 observations created${NC}"

echo ""
print_success "Example data loaded successfully!"
echo ""
echo "Summary:"
echo "  - 3 Organizations"
echo "  - 5 Practitioners"
echo "  - 10 Patients"
echo "  - 25 Observations"
echo ""
echo "You can now explore the data:"
echo "  - FHIR API: $FHIR_SERVER"
echo "  - Patient list: $FHIR_SERVER/Patient"
echo "  - Observation list: $FHIR_SERVER/Observation"
echo ""
echo "Use the Postman Collection for guided API exploration."
