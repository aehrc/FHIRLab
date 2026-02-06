## ADDED Requirements

### Requirement: Load example FHIR resources
The system SHALL provide a `load-data.sh` script that loads example FHIR resources using [HAPI FHIR CLI upload-examples](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-example-resources-upload-examples).

#### Scenario: Load example data
- **WHEN** user runs `./load-data.sh`
- **THEN** example FHIR resources are uploaded to the HAPI FHIR server

#### Scenario: Verify data loaded
- **WHEN** data loading completes
- **THEN** script outputs summary of resources loaded

### Requirement: Upload user-supplied terminology
The system SHALL provide an `upload-terminology.sh` script that uploads terminology files using [HAPI FHIR CLI upload-terminology](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-terminology).

#### Scenario: Upload terminology file
- **WHEN** user runs `./upload-terminology.sh <path-to-file>`
- **THEN** terminology from the specified file is uploaded to HAPI FHIR

#### Scenario: Missing file error
- **WHEN** user runs `./upload-terminology.sh` with non-existent file
- **THEN** script outputs clear error message about missing file

### Requirement: HAPI FHIR CLI availability
Data loading scripts SHALL ensure HAPI FHIR CLI is available, either bundled or with clear instructions for installation.

#### Scenario: CLI not installed
- **WHEN** user runs data loading script without HAPI FHIR CLI installed
- **THEN** script outputs instructions for installing or downloading the CLI

### Requirement: Wait for server readiness
Data loading scripts SHALL wait for the HAPI FHIR server to be ready before attempting uploads.

#### Scenario: Server not ready
- **WHEN** user runs data loading script before server is fully started
- **THEN** script waits and retries until server is ready or timeout is reached

#### Scenario: Server timeout
- **WHEN** server does not become ready within timeout period
- **THEN** script outputs error message and exits with non-zero status
