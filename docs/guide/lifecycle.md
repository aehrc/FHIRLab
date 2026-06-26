# Starting & Stopping

Learn how to manage FHIRLab Core services.

## Starting Services

### Basic Start

Start the core services (HAPI FHIR, Snowstorm, SNOMED Browser):

```bash
cd docker
./scripts/start.sh
```

The script will:

1. Check for `.env` file (creates from `.env.example` if missing)
2. Start all Docker containers
3. Wait for each service to become healthy
4. Display service URLs when ready

### Start with SMART Launcher

Include the optional SMART launcher service (separate service that connects to HAPI):

```bash
./scripts/start.sh --smart
```

### Manual Start (Alternative)

If you prefer using Docker Compose directly:

```bash
# Core services only
docker compose up -d

# With SMART launcher (separate service)
docker compose --profile smart up -d
```

## Stopping Services

### Graceful Stop

Stop all services while preserving data:

```bash
./scripts/stop.sh
```

This is equivalent to:

```bash
docker compose --profile smart down
```

Your data remains in Docker volumes and will be available when you restart.

## Resetting the Environment

### Interactive Reset

Remove all data and start fresh:

```bash
./scripts/reset.sh
```

The script will:

1. Ask for confirmation
2. Stop all services
3. Remove all data volumes
4. Leave you ready for a fresh start

### Force Reset (No Confirmation)

Skip the confirmation prompt:

```bash
./scripts/reset.sh --force
```

> **Warning:** Reset permanently deletes all FHIR resources, terminology data, and configurations. This cannot be undone.
## Checking Status

### Smoke Test

Verify all services are running correctly:

```bash
./scripts/smoke-test.sh
```

For SMART launcher testing:

```bash
./scripts/smoke-test.sh --smart
```

### Docker Status

View container status:

```bash
docker compose ps
```

View logs:

```bash
# All services
docker compose logs

# Specific service
docker compose logs hapi-fhir

# Follow logs in real-time
docker compose logs -f
```

## Service Startup Times

| Service | Typical Startup Time |
|---------|---------------------|
| HAPI FHIR | 30-60 seconds |
| Elasticsearch | 30-60 seconds |
| Snowstorm | 1-3 minutes |
| SNOMED Browser | 10-20 seconds |
| SMART Launcher | 10-20 seconds |

> **Tip:** Snowstorm can take several minutes to fully initialize, especially on first run or after loading terminology data.
## Troubleshooting Startup Issues

### Services Won't Start

1. Check available memory: `docker stats`
2. Verify ports aren't in use: `netstat -tlnp | grep 808`
3. Review logs: `docker compose logs`

### Health Checks Failing

1. Wait longer - some services need time
2. Check memory allocation in `.env`
3. See [Troubleshooting](../troubleshooting.md) for specific errors

### Container Keeps Restarting

```bash
# Check why a container is restarting
docker compose logs hapi-fhir --tail 50
```

Common causes:

- Insufficient memory
- Port conflict
- Configuration error
