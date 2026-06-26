# Configuration

Customize FHIRLab Core for your environment.

## Environment Variables

Configuration is managed through the `.env` file in the `docker/` directory.

### Creating Your Configuration

```bash
cd docker
cp .env.example .env
```

Edit `.env` to customize settings.

## Available Settings

### HAPI FHIR Server

| Variable | Default | Description |
|----------|---------|-------------|
| `HAPI_FHIR_PORT` | `8080` | Port for HAPI FHIR web interface and API |
| `HAPI_FHIR_SERVER_ADDRESS` | `http://localhost:8080/fhir` | External URL for resource references |

### Elasticsearch

| Variable | Default | Description |
|----------|---------|-------------|
| `ES_PORT` | `127.0.0.1:9200` | Elasticsearch port (localhost only by default) |
| `ES_HEAP_SIZE` | `2g` | JVM heap size for Elasticsearch |
| `ES_MEMORY` | `2g` | Memory reservation for container |

### Snowstorm

| Variable | Default | Description |
|----------|---------|-------------|
| `SNOWSTORM_PORT` | `8081` | Port for Snowstorm API |
| `SNOWSTORM_MIN_HEAP` | `1g` | Minimum JVM heap |
| `SNOWSTORM_MAX_HEAP` | `2g` | Maximum JVM heap |

### SNOMED Browser

| Variable | Default | Description |
|----------|---------|-------------|
| `SNOMED_BROWSER_PORT` | `8082` | Port for SNOMED CT Browser |

### SMART Launcher (Optional Separate Service)

The SMART launcher is a separate service that connects to HAPI FHIR. No HAPI-specific configuration needed.

| Variable | Default | Description |
|----------|---------|-------------|
| `SMART_LAUNCHER_PORT` | `8083` | Port for SMART Launcher service |

## Common Customizations

### Change Default Ports

If port 8080 is already in use:

```bash
# In .env
HAPI_FHIR_PORT=9080
HAPI_FHIR_SERVER_ADDRESS=http://localhost:9080/fhir
```

### Reduce Memory Usage

For systems with limited RAM (8GB or less):

```bash
# In .env
ES_HEAP_SIZE=1g
ES_MEMORY=1g
SNOWSTORM_MIN_HEAP=512m
SNOWSTORM_MAX_HEAP=1g
```

### Allow Remote Access to Elasticsearch

> **Warning:** Only do this in trusted environments.
```bash
# In .env
ES_PORT=0.0.0.0:9200
```

### External Server Address

If accessing from other machines:

```bash
# In .env
HAPI_FHIR_SERVER_ADDRESS=http://192.168.1.100:8080/fhir
```

## Docker Compose Overrides

For advanced customization, create `docker-compose.override.yml`:

```yaml
services:
  hapi-fhir:
    environment:
      - hapi.fhir.openapi_enabled=true
      - hapi.fhir.cors.allowed_origin=*
```

This file is automatically merged with the main compose file.

## Volumes and Data

### Data Locations

| Service | Storage | Persistence |
|---------|---------|-------------|
| **HAPI FHIR** | In-memory H2 database | Data resets on restart |
| **Snowstorm** | Docker volume `fhirlab-elastic-data` | Persists between restarts |

> **Note:** By default, HAPI FHIR uses an in-memory database for simplicity. Data will be lost when the container restarts. This is intentional for a learning environment - use `load-data.sh` to reload example data after restart.
### Backup Volumes

```bash
# List volumes
docker volume ls | grep fhirlab

# Backup a volume
docker run --rm \
  -v fhirlab-hapi-data:/source:ro \
  -v $(pwd):/backup \
  alpine tar czf /backup/hapi-backup.tar.gz -C /source .
```

### Restore Volumes

```bash
docker run --rm \
  -v fhirlab-hapi-data:/target \
  -v $(pwd):/backup \
  alpine sh -c "cd /target && tar xzf /backup/hapi-backup.tar.gz"
```

## Network Configuration

All services communicate on the `fhirlab-network` Docker network.

### Service Discovery

Within the Docker network, services can reach each other by name:

- `hapi-fhir:8080` - HAPI FHIR
- `elasticsearch:9200` - Elasticsearch
- `snowstorm:8080` - Snowstorm
- `snomed-browser:80` - SNOMED Browser

## Troubleshooting Configuration

### Verify Environment

```bash
# Check loaded environment
docker compose config

# Verify specific variable
docker compose config | grep HAPI_FHIR_PORT
```

### Reset to Defaults

```bash
cp .env.example .env
./scripts/reset.sh
./scripts/start.sh
```
