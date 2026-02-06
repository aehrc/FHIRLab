## Why

Healthcare teams and developers wanting to learn or deploy FHIRLab Core face a significant barrier: the current setup requires substantial DevOps expertise. Many small clinics, educational institutions, and development teams lack dedicated infrastructure specialists, preventing them from adopting FHIR-based workflows. A minimal, Docker-based deployment option with clear documentation would dramatically lower the entry barrier.

**Success Metric**: FHIRLab Core can be cloned, started, reset, and stopped in their own environment by regional user/teams with basic technical skills, without ongoing DevOps support.

**Guiding Principle**: FHIRLab self-deployments by external parties will rely on simple, transparent, container-based approaches (e.g. basic Docker images) sufficient for a learning sandbox, rather than production-grade operational automation.

## What Changes

### Core Services (Scope)

- **HAPI FHIR (R4)**: Primary FHIR server - Docker config based on [akkadakka](https://gitlab.com/australian-e-health-research-centre/akkadakka)
- **Snowstorm**: SNOMED CT terminology server (avoids licensing issues) - based on [IHTSDO snowstorm-x](https://github.com/IHTSDO/snowstorm-x/blob/master/docker-compose.yml) with [documentation](https://github.com/IHTSDO/snowstorm-x/blob/master/docs/using-docker.md#starting-snowstorm)
- **Optional: Basic SMART on FHIR**: Learning read-only demonstration only

### Setup Components

- Docker and Docker Compose configuration
- Simple shell scripts for lifecycle operations (start, stop, reset)
- Example `.env` files with clear defaults for learning
- Script to load baseline data using [HAPI FHIR CLI upload-examples](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-example-resources-upload-examples)
- Script to upload terminology using [HAPI FHIR CLI upload-terminology](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-terminology) (user-supplied files)
- Smoke tests to verify services are running

### Documentation Website

- SSG-based documentation website appealing to healthcare teams with limited DevOps skills
- Content covering: how to start, stop, reset, load data, upload terminology, use Postman Collection

## Capabilities

### New Capabilities

- `docker-deployment`: Docker Compose configuration orchestrating HAPI FHIR (R4), Snowstorm, and optional SMART on FHIR services with example env files and clear defaults
- `lifecycle-scripts`: Shell scripts for start, stop, reset operations
- `data-loading`: Scripts for loading example FHIR resources and user-supplied terminology files
- `smoke-tests`: Self-test capability to verify all services are running correctly
- `documentation-website`: SSG-based website with quick-start guide, lifecycle operations, and Postman Collection usage

### Modified Capabilities

None - this is a new deployment option that does not modify existing capabilities.

## Impact

- **Repository**: New `docker/` directory with Compose files, scripts, and configuration
- **Website**: New SSG-based documentation site in repository
- **Dependencies**: Docker, Docker Compose, HAPI FHIR CLI on target systems
- **External Resources**: Postman Collection for API exploration
- **Target audience**: Regional healthcare teams with basic technical skills, no DevOps support required

## References

| Component | Source |
|-----------|--------|
| HAPI FHIR Docker | [akkadakka](https://gitlab.com/australian-e-health-research-centre/akkadakka) |
| Snowstorm Docker | [snowstorm-x](https://github.com/IHTSDO/snowstorm-x/blob/master/docker-compose.yml) |
| Snowstorm docs | [using-docker.md](https://github.com/IHTSDO/snowstorm-x/blob/master/docs/using-docker.md#starting-snowstorm) |
| Example data loading | [HAPI FHIR CLI upload-examples](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-example-resources-upload-examples) |
| Terminology upload | [HAPI FHIR CLI upload-terminology](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-terminology) |
