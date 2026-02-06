## Why

The current documentation and scripts use language that may mislead users into thinking HAPI FHIR has a "SMART mode" or SMART-specific configuration. In reality, SMART on FHIR is a completely separate optional service (smart-launcher container) that connects to HAPI as an external client. There are no HAPI-specific SMART parameters or modes to configure.

## What Changes

- Clarify in scripts and documentation that SMART on FHIR is a separate optional service, not a mode or configuration of HAPI FHIR
- Update script help text and comments to emphasize SMART launcher is an additional service
- Review and update documentation language to avoid implying HAPI has SMART-specific configuration
- No changes to actual functionality - SMART launcher service remains available as-is

## Capabilities

### New Capabilities
<!-- None - this is a documentation/clarity improvement -->

### Modified Capabilities
- `lifecycle-scripts`: Update script help text and output messages to clarify SMART launcher is a separate service, not a HAPI mode
- `docker-deployment`: Update comments in docker-compose.yml to emphasize SMART launcher independence from HAPI configuration

## Impact

- **Scripts**: `docker/scripts/start.sh`, `docker/scripts/smoke-test.sh` - update help text and status messages
- **Docker**: `docker/docker-compose.yml` - update comments for clarity
- **Documentation**: Review and update any language that implies HAPI has SMART configuration
- **No breaking changes**: All functionality remains identical, only improving clarity
