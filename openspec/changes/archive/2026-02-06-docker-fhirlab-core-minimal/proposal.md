## Why

Healthcare teams and developers wanting to learn or deploy FHIRLab Core face a significant barrier: the current setup requires substantial DevOps expertise. Many small clinics, educational institutions, and development teams lack dedicated infrastructure specialists, preventing them from adopting FHIR-based workflows. A minimal, Docker-based deployment option would dramatically lower the entry barrier.

**Success Metric**: FHIRLab Core can be cloned, started, reset, and stopped in their own environment by regional user/teams with basic technical skills, without ongoing DevOps support.

**Guiding Principle**: FHIRLab self-deployments by external parties will rely on simple, transparent, container-based approaches (e.g. basic Docker images) sufficient for a learning sandbox, rather than production-grade operational automation.

## What Changes

### Core Services (Scope)

- **HAPI FHIR (R4)**: Primary FHIR server
- **Snowstorm**: SNOMED CT terminology server (avoids licensing issues)
- **Optional: Basic SMART on FHIR**: Learning read-only demonstration only

### Setup Components

- Docker and Docker Compose configuration
- Simple shell scripts for common operations
- Example `.env` files with clear defaults for learning
- Script to load baseline data
- Script to reset environment

### Documentation

- How to start (environment setup)
- How to reset
- How to stop
- How to load data
- How to use Postman Collection with FHIRLab Core

## Capabilities

### New Capabilities

- `docker-deployment`: Docker Compose configuration orchestrating HAPI FHIR (R4), Snowstorm, and optional SMART on FHIR services with example env files and clear defaults
- `lifecycle-scripts`: Shell scripts for start, stop, reset, and data loading operations
- `quick-start-guide`: Documentation covering environment setup, lifecycle operations, data loading, and Postman Collection usage
- `sample-data`: Baseline FHIR resources and scripts for loading/resetting learning data

### Modified Capabilities

None - this is a new deployment option that does not modify existing capabilities.

## Impact

- **Repository**: New `docker/` directory with Compose files, Dockerfiles, shell scripts, and configuration
- **Documentation**: Comprehensive quick-start guide covering all lifecycle operations
- **Dependencies**: Requires Docker and Docker Compose on target systems
- **External Resources**: Postman Collection for API exploration
- **Target audience**: Regional teams with basic technical skills, no DevOps support required
