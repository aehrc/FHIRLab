## MODIFIED Requirements

### Requirement: Start script
The system SHALL provide a `start.sh` script that starts all FHIRLab Core services, with clear messaging that distinguishes between core services and optional add-on services.

#### Scenario: Start services
- **WHEN** user runs `./start.sh`
- **THEN** all Docker services start and script waits for health checks to pass

#### Scenario: Start with SMART launcher service
- **WHEN** user runs `./start.sh --smart`
- **THEN** all core services plus the separate SMART launcher service start
- **AND** status messages clearly indicate SMART launcher is an additional service, not a HAPI mode

### Requirement: Scripts provide clear feedback
All lifecycle scripts SHALL provide clear, user-friendly feedback about what operations are being performed, using precise language that reflects the actual architecture.

#### Scenario: Progress indication
- **WHEN** user runs any lifecycle script
- **THEN** script outputs progress messages indicating current operation with accurate service descriptions

#### Scenario: Error handling
- **WHEN** an operation fails
- **THEN** script outputs clear error message and exits with non-zero status

#### Scenario: SMART launcher messaging
- **WHEN** user runs script with `--smart` flag
- **THEN** output messages refer to "SMART launcher service" or "SMART launcher (separate service)" rather than implying HAPI has a SMART mode
