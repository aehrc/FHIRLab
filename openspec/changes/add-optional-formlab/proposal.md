## Why

FHIRLab Core currently provides HAPI FHIR and Snowstorm as core services, with basic SMART on FHIR launcher as an optional demonstration. FormLab (https://gitlab.com/australian-e-health-research-centre/form-lab) provides a more complete SMART-on-FHIR example with a working docker compose setup that demonstrates real-world questionnaire/form functionality. Adding FormLab as an optional component enhances the learning capabilities of FHIRLab Core by providing users with a practical, deployable SMART on FHIR demonstration that goes beyond basic authentication flows.

## What Changes

- Add FormLab as an optional Docker Compose profile (similar to existing SMART launcher)
- Integrate FormLab docker compose configuration into the main docker-compose.yml
- Update documentation website to describe FormLab functionality and usage
- Update README.md with FormLab quickstart and configuration instructions
- Add scripts for managing FormLab alongside other services
- Provide example workflows using FormLab with HAPI FHIR

## Capabilities

### New Capabilities
- `formlab-integration`: Docker Compose configuration to deploy FormLab as an optional service using profiles, including network configuration, environment variables, and service dependencies

### Modified Capabilities
- `documentation`: Enhanced documentation website content to cover FormLab setup, usage, and examples
- `operational-scripts`: Updated start/stop/reset scripts to handle FormLab profile

## Impact

**Affected Components:**
- `docker/docker-compose.yml`: Add FormLab service definition with profile
- `docker/.env.example`: Add FormLab configuration variables
- `docker/scripts/`: Update operational scripts to mention FormLab profile
- `docs/`: Add FormLab section/pages to documentation website
- `README.md`: Add FormLab to components list and usage instructions

**Dependencies:**
- FormLab GitLab repository reference for docker compose snippet
- Existing HAPI FHIR service (FormLab connects to it)
- Docker Compose profiles feature (already used for SMART launcher)

**User Impact:**
- Users can opt-in to FormLab with `docker compose --profile formlab up -d`
- No breaking changes - FormLab is entirely optional
- Enhances learning capabilities without affecting minimal core deployment
