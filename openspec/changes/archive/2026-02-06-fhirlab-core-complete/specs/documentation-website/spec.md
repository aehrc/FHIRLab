## ADDED Requirements

### Requirement: SSG-based documentation website
The system SHALL include a documentation website built with a static site generator (SSG).

#### Scenario: Build documentation site
- **WHEN** user runs the SSG build command
- **THEN** static HTML documentation is generated

### Requirement: Appealing design for healthcare teams
The documentation website SHALL have a professional, clean design appropriate for healthcare and educational audiences with limited DevOps experience.

#### Scenario: First impression
- **WHEN** user visits the documentation website
- **THEN** design is professional, uncluttered, and welcoming to non-technical users

### Requirement: Quick start guide
The documentation SHALL include a quick start guide covering environment setup and first run.

#### Scenario: New user follows quick start
- **WHEN** user follows the quick start guide
- **THEN** user can start FHIRLab Core within 10 minutes

### Requirement: Lifecycle operations documentation
The documentation SHALL explain how to start, stop, and reset the environment.

#### Scenario: User needs to reset
- **WHEN** user searches for reset instructions
- **THEN** documentation clearly explains reset process and data implications

### Requirement: Data loading documentation
The documentation SHALL explain how to load example data and upload custom terminology files.

#### Scenario: User wants to load terminology
- **WHEN** user searches for terminology upload instructions
- **THEN** documentation explains upload-terminology script usage and file requirements

### Requirement: Postman Collection documentation
The documentation SHALL explain how to use a Postman Collection with FHIRLab Core.

#### Scenario: User wants to explore API
- **WHEN** user searches for API exploration options
- **THEN** documentation provides Postman Collection and usage instructions

### Requirement: Reference links to upstream sources
The documentation SHALL include links to upstream project documentation (akkadakka, snowstorm-x, HAPI FHIR CLI).

#### Scenario: User needs advanced configuration
- **WHEN** user needs information beyond basic setup
- **THEN** documentation provides links to upstream project documentation

### Requirement: Troubleshooting section
The documentation SHALL include a troubleshooting section for common issues.

#### Scenario: User encounters port conflict
- **WHEN** user searches for port conflict resolution
- **THEN** troubleshooting section explains how to change ports via .env
