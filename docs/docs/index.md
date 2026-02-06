# FHIRLab Core

**A minimal, Docker-based FHIR learning environment for healthcare teams**

FHIRLab Core provides everything you need to start learning and experimenting with FHIR (Fast Healthcare Interoperability Resources) - without requiring DevOps expertise.

<div class="grid cards" markdown>

-   :material-rocket-launch:{ .lg .middle } **Quick Start**

    ---

    Get running in under 10 minutes with just Docker installed.

    [:octicons-arrow-right-24: Get started](quick-start.md)

-   :material-api:{ .lg .middle } **HAPI FHIR R4**

    ---

    Full-featured FHIR R4 server for storing and querying healthcare data.

    [:octicons-arrow-right-24: Learn more](guide/api-usage.md)

-   :material-book-open-variant:{ .lg .middle } **SNOMED CT**

    ---

    Snowstorm terminology server with visual browser for clinical coding.

    [:octicons-arrow-right-24: Explore](guide/snomed-browser.md)

-   :material-cloud-download:{ .lg .middle } **Postman Collection**

    ---

    Ready-to-use API examples for HAPI FHIR and Snowstorm.

    [:octicons-arrow-right-24: Import collection](reference/postman.md)

-   :material-help-circle:{ .lg .middle } **Troubleshooting**

    ---

    Common issues and how to resolve them.

    [:octicons-arrow-right-24: Get help](troubleshooting.md)

</div>

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

!!! note "Learning Environment"
    FHIRLab Core is designed for **learning and development**, not production use. It prioritizes simplicity over scalability and security hardening.

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
- Open an issue on [GitHub](https://github.com/fhirlab/core/issues)
