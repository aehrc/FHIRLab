## ADDED Requirements

### Requirement: Docker Compose orchestration
The system SHALL provide a single `docker-compose.yml` file that orchestrates all FHIRLab Core services including HAPI FHIR (R4), Snowstorm, and optional SMART on FHIR.

#### Scenario: Start all core services
- **WHEN** user runs `docker compose up`
- **THEN** HAPI FHIR and Snowstorm services start and become available

#### Scenario: Start with optional SMART on FHIR
- **WHEN** user runs `docker compose --profile smart up`
- **THEN** HAPI FHIR, Snowstorm, and SMART on FHIR services start

### Requirement: HAPI FHIR configuration based on akkadakka
The HAPI FHIR service configuration SHALL be based on [akkadakka](https://gitlab.com/australian-e-health-research-centre/akkadakka) with appropriate adaptations for FHIRLab Core.

#### Scenario: HAPI FHIR R4 endpoint available
- **WHEN** services are running
- **THEN** HAPI FHIR R4 endpoint is accessible at the configured port

### Requirement: Snowstorm configuration based on IHTSDO snowstorm-x
The Snowstorm service configuration SHALL be based on [IHTSDO snowstorm-x](https://github.com/IHTSDO/snowstorm-x/blob/master/docker-compose.yml) following [using-docker.md](https://github.com/IHTSDO/snowstorm-x/blob/master/docs/using-docker.md#starting-snowstorm).

#### Scenario: Snowstorm endpoint available
- **WHEN** services are running
- **THEN** Snowstorm SNOMED CT terminology endpoint is accessible

### Requirement: Environment configuration via .env.example
The system SHALL provide a `.env.example` file with documented defaults suitable for learning environments.

#### Scenario: User configures environment
- **WHEN** user copies `.env.example` to `.env`
- **THEN** all services start with sensible defaults without modification

#### Scenario: User customizes ports
- **WHEN** user modifies port values in `.env`
- **THEN** services start on the configured ports

### Requirement: Data persistence via Docker volumes
The system SHALL use named Docker volumes to persist data between restarts.

#### Scenario: Data survives restart
- **WHEN** user stops and starts services
- **THEN** previously loaded FHIR resources and terminology remain available

### Requirement: Reference upstream sources
The docker-compose.yml and related configuration files SHALL include comments linking to the upstream sources (akkadakka, snowstorm-x) they are based on.

#### Scenario: Upstream references visible
- **WHEN** user reads docker-compose.yml
- **THEN** comments clearly indicate which sections are derived from akkadakka and snowstorm-x with URLs
