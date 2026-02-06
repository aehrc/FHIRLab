## 1. Update start.sh script messaging

- [x] 1.1 Update help text/comments to clarify SMART launcher is a separate service
- [x] 1.2 Change "SMART on FHIR profile enabled" message to "SMART launcher service will be started"
- [x] 1.3 Update any other status messages that might imply HAPI has SMART mode

## 2. Update smoke-test.sh script messaging

- [x] 2.1 Review smoke-test.sh for SMART-related messaging
- [x] 2.2 Update messages to refer to "SMART launcher service" rather than just "SMART on FHIR"

## 3. Update docker-compose.yml comments

- [x] 3.1 Enhance SMART launcher section comment to explicitly state it's a separate service
- [x] 3.2 Add comment clarifying no HAPI-specific SMART configuration is needed
- [x] 3.3 Ensure service description makes architectural independence clear

## 4. Review and update documentation

- [x] 4.1 Review docs/docs/quick-start.md for misleading SMART language
- [x] 4.2 Review docs/docs/reference/scripts.md for clarity about SMART launcher being separate
- [x] 4.3 Review docs/docs/reference/configuration.md SMART section
- [x] 4.4 Review docs/docs/guide/lifecycle.md for accurate service descriptions
- [x] 4.5 Update any other documentation that might imply HAPI has SMART modes

## 5. Verify no functional changes

- [x] 5.1 Test that `./docker/scripts/start.sh` works identically (just different messages)
- [x] 5.2 Test that `./docker/scripts/start.sh --smart` still starts SMART launcher correctly
- [x] 5.3 Verify docker-compose.yml still works with --profile smart
