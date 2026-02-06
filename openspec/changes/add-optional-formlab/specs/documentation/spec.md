## ADDED Requirements

### Requirement: README includes FormLab in components
The README.md file SHALL list FormLab as an optional component in the components section.

#### Scenario: FormLab is listed in Overview components
- **WHEN** reading the README.md components section
- **THEN** FormLab is listed with description as optional SMART-on-FHIR demonstration

#### Scenario: FormLab is marked as optional
- **WHEN** examining the FormLab component listing
- **THEN** it is clearly indicated as optional (not core)

### Requirement: README provides FormLab quickstart
The README.md file SHALL include instructions for starting FHIRLab Core with FormLab enabled.

#### Scenario: Profile command is documented
- **WHEN** reading the README quickstart or usage section
- **THEN** the command `docker compose --profile formlab up -d` is shown

#### Scenario: FormLab access URL is provided
- **WHEN** reading FormLab documentation in README
- **THEN** the default access URL (http://localhost:8084) is documented

### Requirement: README documents FormLab port configuration
The README.md file SHALL document how to customize the FormLab port in the configuration section.

#### Scenario: Port environment variable is listed
- **WHEN** reading the README configuration section
- **THEN** `FORMLAB_PORT` variable is listed with its default value

### Requirement: Documentation website includes FormLab page
The documentation website SHALL include a dedicated page or section covering FormLab setup and usage.

#### Scenario: FormLab page exists in docs
- **WHEN** browsing the documentation website
- **THEN** a page titled "FormLab" or "SMART-on-FHIR with FormLab" exists

#### Scenario: FormLab is in navigation
- **WHEN** viewing the documentation website navigation menu
- **THEN** FormLab page is accessible from the navigation

### Requirement: FormLab documentation covers purpose
The FormLab documentation page SHALL explain what FormLab is and why users would enable it.

#### Scenario: Purpose is explained
- **WHEN** reading the FormLab documentation page
- **THEN** it explains FormLab provides SMART-on-FHIR demonstration with questionnaire/form capabilities

#### Scenario: Reference to source is provided
- **WHEN** reading the FormLab documentation page
- **THEN** it includes a link to https://gitlab.com/australian-e-health-research-centre/form-lab

### Requirement: FormLab documentation covers setup
The FormLab documentation page SHALL provide step-by-step instructions for enabling and accessing FormLab.

#### Scenario: Enable command is documented
- **WHEN** reading the FormLab setup instructions
- **THEN** it shows the `docker compose --profile formlab up -d` command

#### Scenario: Verification steps are provided
- **WHEN** reading the FormLab setup instructions
- **THEN** it explains how to verify FormLab is running and accessible

### Requirement: FormLab documentation covers usage
The FormLab documentation page SHALL provide guidance on how to use FormLab with HAPI FHIR.

#### Scenario: Basic usage workflow is documented
- **WHEN** reading the FormLab usage section
- **THEN** it provides examples of using FormLab to interact with FHIR resources

#### Scenario: Integration with HAPI FHIR is explained
- **WHEN** reading the FormLab usage section
- **THEN** it explains how FormLab connects to the HAPI FHIR server

### Requirement: FormLab documentation includes troubleshooting
The FormLab documentation page SHALL include common troubleshooting scenarios.

#### Scenario: Port conflict troubleshooting is documented
- **WHEN** reading the FormLab troubleshooting section
- **THEN** it explains how to resolve port conflicts by setting FORMLAB_PORT

#### Scenario: Connection issues are addressed
- **WHEN** reading the FormLab troubleshooting section
- **THEN** it provides guidance for troubleshooting FormLab connection to HAPI FHIR

### Requirement: Architecture diagram includes FormLab
The README or documentation SHALL include FormLab in any architecture diagrams showing system components.

#### Scenario: FormLab appears in architecture diagram
- **WHEN** viewing the architecture diagram in README
- **THEN** FormLab is shown as an optional component

#### Scenario: FormLab relationship to HAPI FHIR is shown
- **WHEN** viewing the architecture diagram
- **THEN** it shows FormLab connecting to HAPI FHIR
