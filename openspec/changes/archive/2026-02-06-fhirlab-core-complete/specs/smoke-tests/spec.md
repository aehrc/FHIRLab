## ADDED Requirements

### Requirement: Smoke test script
The system SHALL provide a `smoke-test.sh` script that verifies all services are running correctly.

#### Scenario: All services healthy
- **WHEN** user runs `./smoke-test.sh` with all services running
- **THEN** script outputs success status for each service and exits with zero status

#### Scenario: Service unhealthy
- **WHEN** user runs `./smoke-test.sh` with a service not responding
- **THEN** script outputs failure status for the unhealthy service and exits with non-zero status

### Requirement: HAPI FHIR health check
The smoke test SHALL verify HAPI FHIR server is responding to requests.

#### Scenario: HAPI FHIR responding
- **WHEN** smoke test checks HAPI FHIR
- **THEN** test confirms server returns valid metadata/capability statement

### Requirement: Snowstorm health check
The smoke test SHALL verify Snowstorm terminology server is responding to requests.

#### Scenario: Snowstorm responding
- **WHEN** smoke test checks Snowstorm
- **THEN** test confirms server returns valid response from health endpoint

### Requirement: Optional SMART on FHIR health check
The smoke test SHALL check SMART on FHIR service only when running with the smart profile.

#### Scenario: SMART service check when enabled
- **WHEN** smoke test runs with SMART profile active
- **THEN** test includes SMART on FHIR service health check

#### Scenario: SMART service check when disabled
- **WHEN** smoke test runs without SMART profile
- **THEN** test skips SMART on FHIR service check

### Requirement: Clear test output
The smoke test SHALL output results in a clear, human-readable format.

#### Scenario: Test results display
- **WHEN** smoke test completes
- **THEN** output shows each service name with PASS/FAIL status and overall summary
