## ADDED Requirements

### Requirement: FormLab service definition
The docker-compose.yml file SHALL include a FormLab service definition that uses Docker Compose profiles for optional deployment.

#### Scenario: FormLab service is defined with profile
- **WHEN** examining the docker-compose.yml file
- **THEN** a service named `formlab` or `form-lab` exists with `profiles: ["formlab"]`

#### Scenario: FormLab is not started by default
- **WHEN** user runs `docker compose up -d` without profile flag
- **THEN** FormLab service does not start

#### Scenario: FormLab starts with profile flag
- **WHEN** user runs `docker compose --profile formlab up -d`
- **THEN** FormLab service starts successfully

### Requirement: FormLab network integration
The FormLab service SHALL be connected to the fhirlab network to communicate with HAPI FHIR and other services.

#### Scenario: FormLab uses shared network
- **WHEN** FormLab service is started
- **THEN** it is connected to the `fhirlab` network

#### Scenario: FormLab can reach HAPI FHIR
- **WHEN** FormLab service is running
- **THEN** it can connect to the HAPI FHIR service at `http://hapi-fhir:8080/fhir`

### Requirement: FormLab port configuration
The FormLab service SHALL expose its web interface on a configurable port with a sensible default.

#### Scenario: Default port is configured
- **WHEN** no custom port is specified in .env
- **THEN** FormLab is accessible at `http://localhost:8084`

#### Scenario: Custom port can be configured
- **WHEN** user sets `FORMLAB_PORT=9000` in .env file
- **THEN** FormLab is accessible at `http://localhost:9000`

### Requirement: FormLab environment variables
The FormLab service SHALL be configured with environment variables to connect to the HAPI FHIR server.

#### Scenario: FHIR server URL is configured
- **WHEN** FormLab service starts
- **THEN** it is configured to use the HAPI FHIR server address from environment variable

#### Scenario: Environment variables are documented
- **WHEN** examining the .env.example file
- **THEN** FormLab configuration variables are present with comments explaining their purpose

### Requirement: FormLab service dependencies
The FormLab service SHALL declare a dependency on the HAPI FHIR service to ensure correct startup order.

#### Scenario: FormLab depends on HAPI FHIR
- **WHEN** examining the docker-compose.yml file
- **THEN** FormLab service has `depends_on: [hapi-fhir]` configured

#### Scenario: FormLab waits for HAPI FHIR
- **WHEN** starting services with `--profile formlab`
- **THEN** HAPI FHIR starts before FormLab attempts to start

### Requirement: FormLab container naming
The FormLab service SHALL use consistent container naming following the fhirlab convention.

#### Scenario: Container name follows convention
- **WHEN** FormLab service is started
- **THEN** container is named `fhirlab-formlab` or similar following the `fhirlab-*` pattern

### Requirement: FormLab restart policy
The FormLab service SHALL have appropriate restart policy for a learning environment.

#### Scenario: FormLab restarts on failure
- **WHEN** FormLab service is configured in docker-compose.yml
- **THEN** restart policy is set to `unless-stopped` or `always`

### Requirement: FormLab healthcheck
The FormLab service SHOULD include a healthcheck to verify the service is responding correctly.

#### Scenario: Healthcheck is configured
- **WHEN** FormLab service has been running for startup period
- **THEN** Docker reports the service as healthy

#### Scenario: Healthcheck uses appropriate endpoint
- **WHEN** healthcheck executes
- **THEN** it checks a valid HTTP endpoint that indicates FormLab is operational
