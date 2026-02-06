## MODIFIED Requirements

### Requirement: Docker Compose orchestration
The system SHALL provide a single `docker-compose.yml` file that orchestrates all FHIRLab Core services (HAPI FHIR R4, Snowstorm) with optional separate SMART launcher service, using comments that clearly explain the architectural separation.

#### Scenario: Start all core services
- **WHEN** user runs `docker compose up`
- **THEN** HAPI FHIR and Snowstorm services start and become available

#### Scenario: Start with optional SMART launcher
- **WHEN** user runs `docker compose --profile smart up`
- **THEN** HAPI FHIR, Snowstorm, and the separate SMART launcher service start

#### Scenario: SMART launcher independence documented
- **WHEN** user reads docker-compose.yml SMART launcher section
- **THEN** comments explicitly state that SMART launcher is a separate service with no HAPI-specific configuration required
