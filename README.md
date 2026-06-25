# FHIRLab Core

A simple, container-based FHIR learning sandbox designed for regional teams with basic technical skills. FHIRLab Core provides a complete healthcare interoperability stack including HAPI FHIR R4, Snowstorm terminology server, and optional SMART on FHIR demonstration capabilities.

## Overview

FHIRLab Core enables teams to quickly deploy, experiment with, and learn FHIR-based healthcare interoperability standards without requiring ongoing DevOps support.

### Components

1. **HAPI FHIR (R4)** - Full-featured FHIR server for storing and querying healthcare data
2. **Snowstorm** - SNOMED CT terminology server (open-source, avoiding licensing issues)
3. **SMART on FHIR Launcher** (Optional) - Read-only demonstration for learning SMART authentication flows
4. **FormLab** (Optional) - Comprehensive SMART-on-FHIR demonstration with questionnaires, forms, and sample data
5. **FHIR IG Validator** (Optional) - Validate FHIR resources against Implementation Guides (ARM compatible)

### Guiding Principle

FHIRLab self-deployments rely on simple, transparent, container-based approaches (basic Docker images) sufficient for a learning sandbox, rather than production-grade operational automation.

## Prerequisites

- Docker (version 20.x or later)
- Docker Compose (version 2.x or later)
- At least 4GB RAM available for containers
- Basic terminal/command-line skills

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/aehrc/FHIRLab.git
cd FHIRLab
```

### 2. Configure Environment (Optional)

Copy the example environment file and customize if needed:

```bash
cd docker
cp .env.example .env
# Edit .env to customize ports and settings (optional)
```

**Default configuration works out-of-the-box for learning purposes.**

### 3. Start the Services

```bash
cd docker
./scripts/start.sh
```

Or manually with Docker Compose:

```bash
docker compose up -d
```

Services will be available at:
- **HAPI FHIR**: http://localhost:8080/fhir
- **Snowstorm**: http://localhost:8081
- **SNOMED Browser**: http://localhost:8082
- **FormLab** (if enabled): http://localhost:8084

### 4. Verify Setup

```bash
./scripts/smoke-test.sh
```

## Usage

### How to Start

```bash
cd docker
./scripts/start.sh
```

### How to Load Baseline Data

Load sample FHIR resources:

```bash
cd docker
./scripts/load-data.sh
```

### How to Load Terminology Data

Upload SNOMED CT data to Snowstorm:

```bash
cd docker
./scripts/upload-terminology.sh /path/to/snomed-release.zip
```

### How to Stop

```bash
cd docker
./scripts/stop.sh
```

Or:

```bash
docker compose down
```

### How to Reset

To completely reset all data and start fresh:

```bash
cd docker
./scripts/reset.sh
```

Or manually:

```bash
docker compose down -v
docker compose up -d
```

**Note**: HAPI FHIR uses an in-memory database by default, so data resets on container restart.

### Using the FHIR IG Validator (Optional)

To enable the FHIR Implementation Guide Validator:

```bash
cd docker
docker compose --profile validator up -d
```

Access the Validator at: http://localhost:3500

To add custom Implementation Guides and use the REST API, see the [Validator documentation](docs/validator.md).

### Using SMART on FHIR (Optional)

To enable the SMART on FHIR launcher for demonstration:

```bash
cd docker
docker compose --profile smart up -d
```

Access the SMART Launcher at: http://localhost:8083

### Using FormLab (Optional)

FormLab provides a comprehensive SMART-on-FHIR learning environment with interactive questionnaires, forms management, and sample data. It includes its own HAPI FHIR server, SMART launcher, and forms application.

To enable FormLab:

```bash
cd docker
docker compose --profile formlab up -d
```

Access FormLab at: http://localhost:8084

FormLab includes:
- **Homepage**: http://localhost:8084 - Documentation and overview
- **SMART Launcher**: http://localhost:8085 - Interactive SMART launch interface
- **Forms Application**: http://localhost:8087 - SDC questionnaires and forms
- **FHIR Server**: http://localhost:8088/fhir - Dedicated FHIR server with sample data

For more details, see the [FormLab documentation](https://gitlab.com/australian-e-health-research-centre/form-lab).

## Using the Postman Collection

A Postman collection is provided in the `postman/` directory for testing and exploring the FHIR API.

1. Import the collection into Postman
2. Ensure FHIRLab Core services are running
3. Use the collection to:
   - Query FHIR resources
   - Create test patients
   - Search SNOMED CT codes
   - Test various FHIR operations

## Architecture

```
┌─────────────────────┐
│   HAPI FHIR R4      │  Port 8080
│   (FHIR Server)     │
└─────────────────────┘

┌─────────────────────┐
│   Snowstorm         │  Port 8081
│   (Terminology)     │
└─────────────────────┘
          ↓
┌─────────────────────┐
│   Elasticsearch     │  (Internal)
└─────────────────────┘

┌─────────────────────┐
│   SNOMED Browser    │  Port 8082
└─────────────────────┘

┌─────────────────────┐
│ SMART Launcher      │  Port 8083 (Optional)
│ (--profile smart)   │
└─────────────────────┘

┌─────────────────────┐
│ FHIR IG Validator   │  Port 3500 (Optional)
│ (--profile validator)│
└─────────────────────┘

┌─────────────────────────────────────────┐
│          FormLab Stack                  │
│      (--profile formlab, Optional)      │
├─────────────────────────────────────────┤
│  Homepage         │  Port 8084          │
│  SMART Launcher   │  Port 8085          │
│  Forms App        │  Port 8087          │
│  FHIR Server      │  Port 8088          │
│  PostgreSQL DB    │  (Internal)         │
└─────────────────────────────────────────┘
```

## Configuration

Default settings are optimized for learning and can be customized via `docker/.env`:

- `HAPI_FHIR_PORT` - HAPI FHIR port (default: 8080)
- `SNOWSTORM_PORT` - Snowstorm port (default: 8081)
- `SNOMED_BROWSER_PORT` - Browser port (default: 8082)
- `SMART_LAUNCHER_PORT` - SMART launcher port (default: 8083)
- `VALIDATOR_PORT` - FHIR IG Validator port (default: 3500)
- `FORMLAB_PORT` - FormLab homepage port (default: 8084)
- `FORMLAB_LAUNCHER_PORT` - FormLab SMART launcher (default: 8085)
- `FORMLAB_FORMS_PORT` - FormLab forms app (default: 8087)
- `FORMLAB_FHIR_PORT` - FormLab FHIR server (default: 8088)
- `ES_HEAP_SIZE` - Elasticsearch memory (default: 2g)
- `SNOWSTORM_MAX_HEAP` - Snowstorm memory (default: 2g)

## Documentation

Full documentation is available in the `docs/` directory:

- Getting Started Guide
- Configuration Options
- Data Loading Procedures
- Troubleshooting
- API Examples

## Success Metric

**FHIRLab Core can be cloned, started, reset, and stopped in their own environment by regional user/teams with basic technical skills, without ongoing DevOps support.**

## Troubleshooting

### Services won't start
- Check Docker is running: `docker ps`
- Verify ports are available (8080-8083)
- Check logs: `docker compose logs`

### Out of memory errors
- Increase Docker memory allocation to at least 4GB
- Reduce heap sizes in `.env` file

### Data not persisting
- HAPI FHIR uses in-memory storage by default (intentional for learning)
- For persistent storage, see documentation on configuration options

## Contributing

This project is designed for learning and regional deployment. Contributions that maintain simplicity and accessibility are welcome.

## Support

For questions or issues, please open an issue in the [GitHub repository](https://github.com/aehrc/FHIRLab/issues).

## License

[Specify license]

## Authors

Australian e-Health Research Centre - Digital Health Strengthening Standards Capability Team
