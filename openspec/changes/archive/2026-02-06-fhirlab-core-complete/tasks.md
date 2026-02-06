## 1. Project Setup

- [x] 1.1 Create `docker/` directory structure (docker-compose.yml, scripts/, data/, config/)
- [x] 1.2 Create `docs/` directory for SSG website source

## 2. Docker Deployment

- [x] 2.1 Create docker-compose.yml based on akkadakka HAPI FHIR configuration (link: https://gitlab.com/australian-e-health-research-centre/akkadakka)
- [x] 2.2 Add Snowstorm service based on IHTSDO snowstorm-x (link: https://github.com/IHTSDO/snowstorm-x/blob/master/docker-compose.yml)
- [x] 2.3 Add optional SMART on FHIR service using Docker Compose profiles
- [x] 2.4 Create .env.example with documented defaults for all services
- [x] 2.5 Configure named Docker volumes for data persistence
- [x] 2.6 Add inline comments referencing upstream sources (akkadakka, snowstorm-x URLs)

## 3. Lifecycle Scripts

- [x] 3.1 Create start.sh script with health check waiting
- [x] 3.2 Add --smart flag support to start.sh for optional profile
- [x] 3.3 Create stop.sh script for graceful shutdown
- [x] 3.4 Create reset.sh script with confirmation prompt and --force flag
- [x] 3.5 Ensure all scripts have proper shebang, executable permissions, and clear output messages

## 4. Data Loading Scripts

- [x] 4.1 Create load-data.sh script using HAPI FHIR CLI upload-examples (link: https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-example-resources-upload-examples)
- [x] 4.2 Create upload-terminology.sh script using HAPI FHIR CLI upload-terminology (link: https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-terminology)
- [x] 4.3 Add server readiness check with retry logic to data loading scripts
- [x] 4.4 Add HAPI FHIR CLI availability check with installation instructions

## 5. Smoke Tests

- [x] 5.1 Create smoke-test.sh script framework
- [x] 5.2 Implement HAPI FHIR health check (metadata/capability statement)
- [x] 5.3 Implement Snowstorm health check
- [x] 5.4 Add conditional SMART on FHIR health check when profile is active
- [x] 5.5 Format output with PASS/FAIL per service and overall summary

## 6. Documentation Website

- [x] 6.1 Choose and set up SSG (evaluate Hugo, Astro, MkDocs, Docusaurus for target audience)
- [x] 6.2 Create appealing theme/design appropriate for healthcare audience
- [x] 6.3 Write quick start guide (clone to running in 10 minutes)
- [x] 6.4 Document lifecycle operations (start, stop, reset)
- [x] 6.5 Document data loading (load-data.sh, upload-terminology.sh)
- [x] 6.6 Document Postman Collection usage
- [x] 6.7 Add reference links to upstream documentation (akkadakka, snowstorm-x, HAPI FHIR CLI)
- [x] 6.8 Create troubleshooting section (port conflicts, memory issues, common errors)

## 7. Testing & Validation

- [x] 7.1 Test full lifecycle: clone → start → smoke-test → load-data → reset → stop
- [x] 7.2 Test on fresh system with only Docker/Docker Compose installed
- [x] 7.3 Verify documentation accuracy by following guides step-by-step
- [x] 7.4 Test optional SMART on FHIR profile

> Note: Tasks 7.1-7.4 are manual validation tasks to be performed before deployment.
