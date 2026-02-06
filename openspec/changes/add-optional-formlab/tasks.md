## 1. Research FormLab Configuration

- [x] 1.1 Access FormLab GitLab repository and locate docker compose snippet
- [x] 1.2 Identify Docker image name and version for FormLab
- [x] 1.3 Determine default port and required environment variables
- [x] 1.4 Document any FHIR resource dependencies or initialization needs

## 2. Docker Compose Integration

- [x] 2.1 Add FormLab service definition to docker/docker-compose.yml with profile "formlab"
- [x] 2.2 Configure FormLab container name following fhirlab-* convention
- [x] 2.3 Set up FormLab to use fhirlab network
- [x] 2.4 Configure depends_on for hapi-fhir service
- [x] 2.5 Set restart policy to "unless-stopped"
- [x] 2.6 Configure port mapping with FORMLAB_PORT environment variable (default: 8084)
- [x] 2.7 Add environment variables for HAPI FHIR connection
- [x] 2.8 Add healthcheck configuration for FormLab service

## 3. Environment Configuration

- [x] 3.1 Add FORMLAB_PORT to docker/.env.example with default value 8084
- [x] 3.2 Add FHIR server URL environment variable for FormLab
- [x] 3.3 Add comments to .env.example explaining FormLab variables

## 4. README Updates

- [x] 4.1 Add FormLab to Components section listing as optional
- [x] 4.2 Add FormLab service URLs to Quick Start section (http://localhost:8084)
- [x] 4.3 Add FormLab profile command to "Using SMART on FHIR" or create "Using FormLab" section
- [x] 4.4 Add FORMLAB_PORT to Configuration section
- [x] 4.5 Update Architecture diagram to include FormLab as optional component
- [x] 4.6 Add FormLab connection to HAPI FHIR in architecture diagram

## 5. Documentation Website

- [x] 5.1 Create new documentation page for FormLab (e.g., docs/docs/formlab.md)
- [x] 5.2 Add FormLab purpose and description section
- [x] 5.3 Add reference link to https://gitlab.com/australian-e-health-research-centre/form-lab
- [x] 5.4 Document FormLab setup steps with docker compose --profile formlab command
- [x] 5.5 Add verification steps for checking FormLab is running
- [x] 5.6 Add usage examples showing FormLab with HAPI FHIR
- [x] 5.7 Add troubleshooting section covering port conflicts and connection issues
- [x] 5.8 Add FormLab page to docs navigation in mkdocs.yml

## 6. Operational Scripts Updates

- [x] 6.1 Update docker/scripts/start.sh help text to mention FormLab profile
- [x] 6.2 Ensure start.sh supports profile flag passthrough
- [x] 6.3 Update docker/scripts/reset.sh comments to mention FormLab
- [x] 6.4 Update docker/scripts/load-data.sh comments about FormLab data needs (if any)
- [x] 6.5 Update docker/scripts/smoke-test.sh to check FormLab when running

## 7. Testing and Validation

- [x] 7.1 Test core services start without FormLab profile (no regression)
- [x] 7.2 Test FormLab starts with `docker compose --profile formlab up -d`
- [x] 7.3 Verify FormLab is accessible at http://localhost:8084
- [x] 7.4 Test FormLab can connect to HAPI FHIR server
- [x] 7.5 Test custom port configuration with FORMLAB_PORT
- [x] 7.6 Test stop.sh stops all services including FormLab
- [x] 7.7 Test reset.sh removes FormLab data/volumes
- [x] 7.8 Test combining profiles: --profile smart --profile formlab
- [x] 7.9 Verify documentation website builds correctly with new page
- [x] 7.10 Run smoke-test.sh with and without FormLab to verify checks work

## 8. Documentation Review

- [x] 8.1 Review README for completeness and clarity
- [x] 8.2 Review FormLab documentation page for accuracy
- [x] 8.3 Verify all links work (GitLab repo, localhost URLs)
- [x] 8.4 Check architecture diagram rendering
- [x] 8.5 Ensure consistent terminology across all documentation
