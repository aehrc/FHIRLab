# Quick Start

Get FHIRLab Core running in under 10 minutes.

## Prerequisites

Before you begin, ensure you have:

- [x] **Docker** installed ([Get Docker](https://docs.docker.com/get-docker/))
- [x] **Docker Compose** v2+ (included with Docker Desktop)
- [x] At least **8 GB RAM** available
- [x] Basic command-line familiarity

!!! tip "Check Docker Installation"
    Run `docker --version` and `docker compose version` to verify your installation.

## Step 1: Clone the Repository

=== "GitLab (canonical)"

    ```bash
    git clone https://gitlab.com/australian-e-health-research-centre/digital-health-strengthening-standards-capability/core-website.git
    cd core-website
    ```

=== "GitHub (mirror)"

    ```bash
    git clone https://github.com/aehrc/FHIRLab.git
    cd FHIRLab
    ```

## Step 2: Start the Services

```bash
cd docker
./scripts/start.sh
```

This will:

1. Create a default configuration file (`.env`)
2. Pull the required Docker images
3. Start all services
4. Wait for services to become healthy

!!! info "First Run"
    The first start takes longer as Docker downloads the images (~2-3 GB). Subsequent starts are much faster.

## Step 3: Verify Everything Works

```bash
./scripts/smoke-test.sh
```

You should see output like:

```
========================================
  FHIRLab Core - Smoke Test
========================================

Core Services:
  HAPI FHIR Server          PASS
  HAPI FHIR R4 Version      PASS
  Elasticsearch             PASS
  Snowstorm                 PASS
  SNOMED Browser            PASS

========================================
  Summary
========================================

  Passed:   5
  Failed:   0
  Warnings: 0

All critical tests passed!
```

## Step 4: Explore the Services

Open these URLs in your browser:

| Service | URL | Description |
|---------|-----|-------------|
| HAPI FHIR | [http://localhost:8080](http://localhost:8080) | FHIR server web interface |
| FHIR API | [http://localhost:8080/fhir](http://localhost:8080/fhir) | FHIR REST API endpoint |
| Snowstorm | [http://localhost:8081](http://localhost:8081) | Terminology server API |
| SNOMED Browser | [http://localhost:8082](http://localhost:8082) | Visual SNOMED CT browser |

## Step 5: Load Example Data (Optional)

To populate the FHIR server with example resources:

```bash
./scripts/load-data.sh
```

!!! success "No Installation Required"
    The script uses the HAPI FHIR CLI bundled inside the Docker container.

!!! info "Data Persistence"
    HAPI FHIR uses an in-memory database by default. Data will be cleared when containers restart. Run `load-data.sh` again after restarts to reload example data. This is intentional for a learning environment.

## What's Next?

- **[Postman Collection](reference/postman.md)** - Ready-to-use API examples
- [Using the API](guide/api-usage.md) - Query and create FHIR resources
- [Loading Data](guide/data-loading.md) - Import your own data
- [Configuration](reference/configuration.md) - Customize ports and settings

!!! tip "Try the Postman Collection"
    Import the ready-to-use Postman collection from `postman/FHIRLab-Core.postman_collection.json` to explore all API endpoints with pre-configured examples. See the [Postman Collection](reference/postman.md) guide for details.

## Quick Reference

| Command | Description |
|---------|-------------|
| `./scripts/start.sh` | Start all services |
| `./scripts/stop.sh` | Stop all services (data preserved) |
| `./scripts/reset.sh` | Stop and delete all data |
| `./scripts/smoke-test.sh` | Verify services are healthy |
| `./scripts/load-data.sh` | Load example FHIR resources |

## Enable SMART Launcher (Optional)

To include the SMART launcher service for learning (runs as a separate service, not a HAPI mode):

```bash
./scripts/start.sh --smart
```

Then access the SMART Launcher at [http://localhost:8083](http://localhost:8083).
