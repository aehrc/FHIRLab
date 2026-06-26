# Scripts Reference

Complete reference for all FHIRLab Core scripts.

## Lifecycle Scripts

### start.sh

Starts all FHIRLab Core services.

```bash
./scripts/start.sh [options]
```

**Options:**

| Option | Description |
|--------|-------------|
| `--smart` | Also start the SMART launcher service (separate service) |

**Behavior:**

1. Creates `.env` from `.env.example` if missing
2. Starts Docker containers
3. Waits for health checks to pass
4. Displays service URLs

**Example:**

```bash
# Start core services
./scripts/start.sh

# Start with SMART launcher (separate service)
./scripts/start.sh --smart
```

---

### stop.sh

Stops all running services, preserving data.

```bash
./scripts/stop.sh
```

**Behavior:**

1. Stops all containers (including SMART profile)
2. Preserves data in Docker volumes

---

### reset.sh

Stops services and removes all data.

```bash
./scripts/reset.sh [options]
```

**Options:**

| Option | Description |
|--------|-------------|
| `--force` | Skip confirmation prompt |

**Behavior:**

1. Prompts for confirmation (unless `--force`)
2. Stops all containers
3. Removes Docker volumes
4. Cleans up orphaned resources

> **⚠ Warning:** This permanently deletes all data. Cannot be undone.
**Example:**

```bash
# Interactive reset
./scripts/reset.sh

# Force reset (no prompt)
./scripts/reset.sh --force
```

## Data Scripts

### load-data.sh

Loads example FHIR resources into HAPI FHIR.

```bash
./scripts/load-data.sh
```

**Requirements:**

- HAPI FHIR CLI installed
- HAPI FHIR server running

**Behavior:**

1. Checks for HAPI FHIR CLI
2. Waits for server to be ready
3. Uploads example R4 resources

**Reference:** [HAPI FHIR CLI upload-examples](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-example-resources-upload-examples)

---

### upload-terminology.sh

Uploads terminology files to HAPI FHIR.

```bash
./scripts/upload-terminology.sh <file>
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `<file>` | Path to terminology file (JSON or XML) |

**Supported Formats:**

- CodeSystem resources
- ValueSet resources
- FHIR Bundles containing terminology

**Example:**

```bash
./scripts/upload-terminology.sh ./my-codesystem.json
./scripts/upload-terminology.sh ./valueset-bundle.xml
```

**Reference:** [HAPI FHIR CLI upload-terminology](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-terminology)

## Testing Scripts

### smoke-test.sh

Verifies all services are running correctly.

```bash
./scripts/smoke-test.sh [options]
```

**Options:**

| Option | Description |
|--------|-------------|
| `--smart` | Also test SMART Launcher |

**Checks Performed:**

| Service | Test |
|---------|------|
| HAPI FHIR | Fetches CapabilityStatement |
| HAPI FHIR R4 | Verifies FHIR version |
| Elasticsearch | Checks cluster health |
| Snowstorm | Fetches version info |
| SNOMED Browser | HTTP connectivity |
| SMART Launcher | HTTP connectivity (if `--smart`) |

**Exit Codes:**

| Code | Meaning |
|------|---------|
| 0 | All critical tests passed |
| N | N tests failed |

**Example:**

```bash
# Test core services
./scripts/smoke-test.sh

# Include SMART launcher (separate service)
./scripts/smoke-test.sh --smart
```

## Script Locations

All scripts are in the `docker/scripts/` directory:

```
docker/
└── scripts/
    ├── start.sh
    ├── stop.sh
    ├── reset.sh
    ├── load-data.sh
    ├── upload-terminology.sh
    └── smoke-test.sh
```

## Using Scripts from Any Directory

Scripts can be run from any directory using the full path:

```bash
/path/to/core/docker/scripts/start.sh
```

Or add to your PATH:

```bash
export PATH="/path/to/core/docker/scripts:$PATH"
```
