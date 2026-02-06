## ADDED Requirements

### Requirement: Start script mentions FormLab profile
The start.sh script SHALL mention the FormLab profile in its help text or comments.

#### Scenario: Help text includes FormLab
- **WHEN** user runs `./start.sh --help` or reads script comments
- **THEN** FormLab profile option is mentioned

#### Scenario: Profile usage is documented
- **WHEN** reading start.sh help text
- **THEN** it shows how to start with FormLab using `--profile formlab`

### Requirement: Start script supports profile passthrough
The start.sh script SHALL support passing profile flags to docker compose.

#### Scenario: Script passes through profile arguments
- **WHEN** user runs `./start.sh --profile formlab`
- **THEN** script passes the profile flag to docker compose command

#### Scenario: Multiple profiles can be combined
- **WHEN** user runs script with multiple profile flags
- **THEN** all profiles are passed to docker compose correctly

### Requirement: Stop script works with FormLab
The stop.sh script SHALL stop FormLab service when it is running.

#### Scenario: Stop works with any profile
- **WHEN** user runs `./stop.sh` after starting with FormLab profile
- **THEN** all services including FormLab are stopped

### Requirement: Reset script mentions FormLab
The reset.sh script SHALL mention FormLab in its documentation or help text.

#### Scenario: Reset help includes FormLab
- **WHEN** user reads reset.sh comments or help text
- **THEN** FormLab is mentioned as one of the optional services that will be reset

#### Scenario: Reset works with FormLab volumes
- **WHEN** user runs `./reset.sh` after using FormLab
- **THEN** any FormLab-specific volumes or data are removed

### Requirement: Scripts maintain backward compatibility
The operational scripts SHALL continue to work for users not using FormLab.

#### Scenario: Scripts work without FormLab
- **WHEN** user runs scripts without any profile flags
- **THEN** core services start, stop, and reset normally without errors

#### Scenario: Existing script behavior unchanged
- **WHEN** comparing script behavior before and after FormLab addition
- **THEN** default behavior (without profiles) remains identical

### Requirement: Script documentation is consistent
All script updates SHALL maintain consistent documentation style and clarity.

#### Scenario: Comments follow existing style
- **WHEN** reading updated script comments
- **THEN** they follow the same format and style as existing comments

#### Scenario: Examples are clear
- **WHEN** reading script examples or help text
- **THEN** FormLab usage examples are as clear as existing service examples

### Requirement: Load data script acknowledges FormLab
The load-data.sh script SHOULD mention if any FormLab-specific data loading is supported.

#### Scenario: Script comments mention FormLab
- **WHEN** reading load-data.sh comments
- **THEN** it mentions whether FormLab requires any specific data preloading

#### Scenario: FormLab data loading is optional
- **WHEN** running load-data.sh without FormLab profile active
- **THEN** script completes successfully without errors

### Requirement: Smoke test script can verify FormLab
The smoke-test.sh script SHOULD be able to verify FormLab is running when enabled.

#### Scenario: Smoke test checks FormLab when active
- **WHEN** smoke-test.sh runs and FormLab service is running
- **THEN** it verifies FormLab endpoint is accessible

#### Scenario: Smoke test skips FormLab when inactive
- **WHEN** smoke-test.sh runs and FormLab service is not running
- **THEN** it skips FormLab checks without failing
