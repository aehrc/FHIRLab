# FHIR IG Validator

FHIRLab Core includes an optional [HL7 FHIR Validator](https://github.com/hapifhir/org.hl7.fhir.validator-wrapper) service for validating FHIR resources against Implementation Guides (IGs).

## Quick Start

```bash
cd docker
docker compose --profile validator up -d
```

The validator UI is available at: **http://localhost:3500**

## Adding a Custom Implementation Guide

The validator stores its FHIR package cache in a persistent Docker volume. To add a custom IG, copy its `.tgz` package into the cache using the correct directory structure.

### Step 1: Obtain the IG Package

Build or download the IG's `package.tgz` file. For example, if you have a SUSHI-based IG:

```bash
sushi .
./_genonce.sh
# The package is at: output/package.tgz
```

Or download a published package from the [FHIR Package Registry](https://packages.fhir.org/).

### Step 2: Copy the Package into the Validator

The FHIR package cache uses the directory structure `~/.fhir/packages/<package-id>#<version>/package/`. To load a package:

```bash
# Set your IG details
IG_ID="example.fhir.my.ig"
IG_VERSION="1.0.0"
PACKAGE_TGZ="/path/to/package.tgz"

# Create the cache directory and extract the package
docker compose --profile validator exec fhir-validator \
  mkdir -p /home/ktor/.fhir/packages/${IG_ID}\#${IG_VERSION}/package

# Copy and extract the package
docker cp "$PACKAGE_TGZ" fhirlab-fhir-validator:/tmp/package.tgz
docker compose --profile validator exec fhir-validator \
  tar -xzf /tmp/package.tgz -C /home/ktor/.fhir/packages/${IG_ID}\#${IG_VERSION}/package
```

### Step 3: Restart the Validator

```bash
docker compose --profile validator restart fhir-validator
```

The IG will now be available for validation.

## Using the REST API

The validator exposes a REST API for programmatic validation. This is the recommended way to validate against custom IGs, since the web UI dropdown only lists well-known IGs.

### Validate a Resource

```bash
curl -X POST http://localhost:3500/validate \
  -H "Content-Type: application/json" \
  -d '{
    "cliContext": {
      "igs": ["example.fhir.my.ig#1.0.0"],
      "sv": "4.0.1"
    },
    "filesToValidate": [
      {
        "fileName": "patient.json",
        "fileContent": "{\"resourceType\":\"Patient\",\"id\":\"example\"}",
        "fileType": "json"
      }
    ]
  }'
```

### Key API Parameters

| Parameter | Description |
|-----------|-------------|
| `cliContext.igs` | Array of IG package references (`id#version`) |
| `cliContext.sv` | FHIR version (`4.0.1` for R4) |
| `filesToValidate[].fileContent` | The FHIR resource as a string |
| `filesToValidate[].fileType` | `json` or `xml` |

Full API documentation: https://validator.fhir.org/swagger-ui/index.html

## Pre-loading IGs at Build Time

To create a custom Docker image with IGs baked in, create a Dockerfile that extends the validator:

```dockerfile
FROM fhirlab-fhir-validator:latest

# Copy your IG package
COPY package.tgz /tmp/package.tgz
RUN mkdir -p /home/ktor/.fhir/packages/example.fhir.my.ig#1.0.0/package && \
    tar -xzf /tmp/package.tgz -C /home/ktor/.fhir/packages/example.fhir.my.ig#1.0.0/package && \
    rm /tmp/package.tgz
```

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `VALIDATOR_PORT` | `3500` | Host port for the validator UI and API |
| `VALIDATOR_MEMORY` | `1g` | Memory reservation for the validator container |

## Architecture Notes

- The Docker image is built from `eclipse-temurin:17-jre-alpine`, which supports both **amd64** and **arm64** (aarch64)
- The upstream `markiantorno/validator-wrapper` image is amd64-only; this custom build provides ARM compatibility for Oracle Cloud Free Tier deployments
- The FHIR package cache is persisted in a Docker volume (`fhirlab-validator-packages`), so loaded IGs survive container restarts
- Use `docker compose down -v` to reset all data including loaded IGs
