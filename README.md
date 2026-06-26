# FHIRLab Core

A minimal, Docker-based FHIR learning environment for healthcare teams.

FHIRLab Core provides a complete healthcare interoperability stack — HAPI FHIR R4, Snowstorm SNOMED CT terminology server, and optional SMART on FHIR capabilities — that regional teams can deploy, experiment with, and learn from without ongoing DevOps support.

## Quick Start

**Prerequisites:** Docker 20.x+, Docker Compose 2.x+, 8 GB RAM

```bash
git clone https://github.com/aehrc/FHIRLab.git
cd FHIRLab/docker
./scripts/start.sh
./scripts/smoke-test.sh
```

| Service | URL |
|---------|-----|
| HAPI FHIR | http://localhost:8080/fhir |
| Snowstorm API | http://localhost:8081 |
| SNOMED Browser | http://localhost:8082 |

Optional profiles: `--smart` (port 8083), `--profile validator` (port 3500), `--profile formlab` (port 8084).

## Documentation

| Guide | Description |
|-------|-------------|
| [Quick Start](docs/quick-start.md) | Full step-by-step setup guide |
| [Starting & Stopping](docs/guide/lifecycle.md) | Manage services, reset data |
| [Loading Data](docs/guide/data-loading.md) | Import FHIR resources and terminology |
| [Using the API](docs/guide/api-usage.md) | HAPI FHIR REST API examples |
| [SNOMED CT Browser](docs/guide/snomed-browser.md) | Terminology server and licensing |
| [Configuration](docs/reference/configuration.md) | Environment variables, ports, memory |
| [Scripts Reference](docs/reference/scripts.md) | All shell scripts explained |
| [Postman Collection](docs/reference/postman.md) | API testing setup |
| [FormLab](docs/formlab.md) | Optional SMART on FHIR forms environment |
| [IG Validator](docs/validator.md) | Optional FHIR IG validator |
| [Troubleshooting](docs/troubleshooting.md) | Common issues and fixes |
| [Learning Resources](docs/resources/learning.md) | FHIR education and Postman workspaces |
| [Upstream Projects](docs/resources/upstream.md) | Open-source projects FHIRLab builds on |

## Components

| Component | Description |
|-----------|-------------|
| **HAPI FHIR R4** | Full-featured FHIR R4 server |
| **Snowstorm** | SNOMED CT terminology server |
| **SNOMED Browser** | Visual interface for browsing SNOMED CT |
| **SMART Launcher** | (Optional) SMART on FHIR demonstration |
| **FormLab** | (Optional) SMART forms learning environment |
| **FHIR IG Validator** | (Optional) Validate resources against IGs |

## Guiding Principle

FHIRLab self-deployments rely on simple, transparent, container-based approaches sufficient for a learning sandbox, rather than production-grade operational automation.

## Success Metric

> FHIRLab Core can be cloned, started, reset, and stopped in their own environment by regional teams with basic technical skills, without ongoing DevOps support.

## Contributing

Open an issue at https://github.com/aehrc/FHIRLab/issues.

## License

[Specify license]

## Authors

Australian e-Health Research Centre — Digital Health Strengthening Standards Capability Team
