## ADDED Requirements

### Requirement: Postman collection file structure
The system SHALL provide a Postman collection file in v2.1 format organized by service and operation type.

#### Scenario: Collection is valid Postman v2.1
- **WHEN** user imports the collection into Postman
- **THEN** Postman recognizes it as a valid v2.1 collection without errors

#### Scenario: Requests organized by service
- **WHEN** user views the collection structure
- **THEN** top-level folders exist for "HAPI FHIR" and "Snowstorm" services

### Requirement: HAPI FHIR request examples
The system SHALL include example requests for common HAPI FHIR R4 operations including server metadata, Patient operations, Observation operations, and Bundle operations.

#### Scenario: Server metadata request
- **WHEN** user sends the "Server Metadata" request
- **THEN** request is GET to `{{fhir_base}}/metadata`
- **AND** response contains FHIR CapabilityStatement

#### Scenario: Patient CRUD operations
- **WHEN** user views Patient Operations folder
- **THEN** requests exist for: list patients, search by name, get by ID, create patient
- **AND** create patient request includes example FHIR Patient resource JSON

#### Scenario: Observation search operations
- **WHEN** user views Observation Operations folder
- **THEN** requests exist for: list observations, search by patient, search by code
- **AND** requests use proper FHIR search parameters

#### Scenario: Bundle transaction example
- **WHEN** user sends the transaction bundle request
- **THEN** request is POST to `{{fhir_base}}` with Bundle resourceType
- **AND** bundle includes example transaction entry

### Requirement: Snowstorm request examples
The system SHALL include example requests for Snowstorm SNOMED CT API operations including version info, concept search, and concept details.

#### Scenario: Version endpoint
- **WHEN** user sends the "Version Info" request
- **THEN** request is GET to `{{snowstorm_base}}/version`

#### Scenario: Concept search
- **WHEN** user sends the "Search Concepts" request
- **THEN** request uses `/MAIN/concepts` endpoint with term parameter
- **AND** request includes limit parameter for pagination

#### Scenario: Concept details
- **WHEN** user sends concept details requests
- **THEN** requests exist for: get concept, get descriptions, get children
- **AND** requests use example concept ID in URL

### Requirement: Environment configuration
The system SHALL provide a Postman environment file with pre-configured variables for localhost deployment.

#### Scenario: Environment file provided
- **WHEN** user imports the environment file
- **THEN** environment is named "FHIRLab Core - Localhost"
- **AND** variables exist for `fhir_base` and `snowstorm_base`

#### Scenario: Localhost defaults
- **WHEN** user views environment variables
- **THEN** `fhir_base` is set to `http://localhost:8080/fhir`
- **AND** `snowstorm_base` is set to `http://localhost:8081`

### Requirement: Response validation tests
The system SHALL include basic Postman test scripts for response validation to help users learn expected API behavior.

#### Scenario: Status code validation
- **WHEN** user sends any request with tests
- **THEN** test verifies response status code (200, 201, etc.)

#### Scenario: FHIR resourceType validation
- **WHEN** user sends HAPI FHIR requests that return resources
- **THEN** test verifies response JSON contains expected resourceType

### Requirement: Documentation integration
The existing Postman documentation SHALL reference the actual collection files for easy import.

#### Scenario: Documentation links to collection
- **WHEN** user reads `docs/docs/reference/postman.md`
- **THEN** documentation includes instructions to import collection from file
- **AND** documentation references the file path in the repository
