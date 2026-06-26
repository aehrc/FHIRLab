# FHIRLab Core — Documentation

Browse the guides below, or start with the [Quick Start](quick-start.md).

## User Guide

| Guide | Description |
|-------|-------------|
| [Quick Start](quick-start.md) | Get running in under 10 minutes |
| [Starting & Stopping](guide/lifecycle.md) | Manage FHIRLab services |
| [Loading Data](guide/data-loading.md) | Import FHIR resources and terminology |
| [Using the API](guide/api-usage.md) | HAPI FHIR REST API reference |
| [SNOMED CT Browser](guide/snomed-browser.md) | Terminology server and SNOMED CT licensing |

## Reference

| Document | Description |
|----------|-------------|
| [Configuration](reference/configuration.md) | Environment variables and Docker settings |
| [Scripts](reference/scripts.md) | All shell scripts explained |
| [Postman Collection](reference/postman.md) | Ready-to-use API testing collection |

## Optional Features

| Document | Description |
|----------|-------------|
| [FormLab](formlab.md) | SMART on FHIR forms learning environment |
| [IG Validator](validator.md) | FHIR Implementation Guide validator |

## Resources

| Document | Description |
|----------|-------------|
| [Learning Resources](resources/learning.md) | FHIR education links and Postman workspaces |
| [Upstream Projects](resources/upstream.md) | Open-source projects FHIRLab is built on |
| [Troubleshooting](troubleshooting.md) | Common issues and fixes |

---

## What's Included

| Service | Description | Default Port |
|---------|-------------|--------------|
| **HAPI FHIR** | FHIR R4 server for healthcare data | 8080 |
| **Snowstorm** | SNOMED CT terminology server | 8081 |
| **SNOMED Browser** | Visual interface for SNOMED CT | 8082 |
| **SMART Launcher** | (Optional) Separate SMART launcher service | 8083 |

## Who Is This For?

FHIRLab Core is designed for:

- **Healthcare IT teams** exploring FHIR integration
- **Developers** building FHIR-enabled applications
- **Educators** teaching healthcare interoperability
- **Students** learning about modern health data standards

> **Note:** FHIRLab Core is designed for **learning and development**, not production use. It prioritises simplicity over scalability and security hardening.

## System Requirements

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| **RAM** | 8 GB | 16 GB |
| **Disk Space** | 20 GB | 50 GB |
| **Docker** | 20.10+ | Latest |
| **Docker Compose** | 2.0+ | Latest |

## Getting Help

- Check the [Troubleshooting](troubleshooting.md) guide
- Review [Upstream Documentation](resources/upstream.md) for detailed reference
- Open an issue on [GitHub](https://github.com/aehrc/FHIRLab/issues)
