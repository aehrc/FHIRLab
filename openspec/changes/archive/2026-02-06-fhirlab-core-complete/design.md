## Context

FHIRLab Core currently lacks a simple deployment option for teams without DevOps expertise. The target users are regional healthcare teams, educational institutions, and developers who need a learning sandbox but cannot invest in complex infrastructure setup.

**Current state**: No standardized deployment method exists in the SSCP GitHub repository.

**Constraints**:
- Must work on any system with Docker and Docker Compose installed
- No cloud-specific dependencies (AWS, GCP, Azure)
- No orchestration tools beyond Docker Compose (no Kubernetes, Helm)
- Learning sandbox only - not production-grade

**Stakeholders**: Regional healthcare teams, educators, FHIR developers, FHIRLab maintainers

**Key References**:
- HAPI FHIR Docker: [akkadakka](https://gitlab.com/australian-e-health-research-centre/akkadakka)
- Snowstorm Docker: [IHTSDO snowstorm-x](https://github.com/IHTSDO/snowstorm-x)
- Data loading: [HAPI FHIR CLI](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html)

## Goals / Non-Goals

**Goals:**
- Single-command startup of complete FHIRLab Core environment
- Clone-to-running in under 10 minutes for users with basic command-line skills
- Clear separation between configuration and runtime data
- Reproducible environment via reset scripts
- Self-documenting through example files, inline comments, and dedicated website
- Smoke tests to verify services are operational

**Non-Goals:**
- Production deployment (no HA, no scaling, no backups)
- Custom SSL/TLS configuration
- External database support (uses embedded/containerized databases)
- Kubernetes or cloud-native deployment
- Automated CI/CD pipelines for the learning environment itself

## Decisions

### 1. Base HAPI FHIR configuration on akkadakka

**Decision**: Adapt Docker Compose configuration from [akkadakka](https://gitlab.com/australian-e-health-research-centre/akkadakka) for the HAPI FHIR server.

**Rationale**: akkadakka is a proven, Australian e-Health focused configuration that aligns with FHIRLab's goals. Provides tested defaults and patterns.

**Alternatives considered**:
- Start from scratch: Higher effort, no proven patterns
- Use generic HAPI starter: Less tailored to Australian healthcare context

### 2. Base Snowstorm configuration on IHTSDO snowstorm-x

**Decision**: Use Docker Compose configuration from [IHTSDO snowstorm-x](https://github.com/IHTSDO/snowstorm-x/blob/master/docker-compose.yml) with documentation from [using-docker.md](https://github.com/IHTSDO/snowstorm-x/blob/master/docs/using-docker.md#starting-snowstorm).

**Rationale**: Official IHTSDO configuration ensures compatibility and avoids licensing issues. Well-documented for the target audience.

**Alternatives considered**:
- Custom Snowstorm build: Unnecessary complexity
- Alternative terminology servers: Less community support, potential licensing issues

### 3. Use HAPI FHIR CLI for data operations

**Decision**: Use HAPI FHIR CLI's [upload-examples](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-example-resources-upload-examples) and [upload-terminology](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-terminology) commands for loading data.

**Rationale**: Official tooling, well-documented, handles FHIR-specific validation and dependencies. Allows users to supply their own terminology files.

**Alternatives considered**:
- Custom curl scripts: More error-prone, no validation
- Database imports: Not portable across versions

### 4. Single docker-compose.yml with optional service profiles

**Decision**: One Compose file with Docker Compose profiles to enable/disable optional services (e.g., SMART on FHIR).

**Rationale**: Keeps configuration centralized while allowing flexibility. Users can run `docker compose up` for core services or `docker compose --profile smart up` for extended setup.

**Alternatives considered**:
- Multiple Compose files: Harder to understand, merge conflicts
- Environment variable toggles: Less discoverable than profiles

### 5. Shell scripts wrap Docker Compose commands

**Decision**: Provide `start.sh`, `stop.sh`, `reset.sh`, `load-data.sh`, and `smoke-test.sh` scripts that wrap Docker Compose and HAPI CLI with appropriate flags and feedback.

**Rationale**: Abstracts complexity, provides consistent UX, enables pre/post hooks (health checks, data validation), and documents the intended workflow.

**Alternatives considered**:
- Makefile: Less portable on Windows, unfamiliar to some users
- Direct Docker Compose only: Requires users to remember flags and sequences

### 6. SSG-based documentation website

**Decision**: Build documentation website using a static site generator, hosted alongside the repository.

**Rationale**: Provides polished, searchable documentation appealing to healthcare teams. SSG ensures fast loading, easy maintenance, and GitHub Pages compatibility.

**Alternatives considered**:
- README-only: Limited navigation, less appealing
- Wiki: Separate from code, harder to version
- Full CMS: Overkill for documentation

### 7. Directory structure

**Decision**: Organize files as follows:
```
docker/
├── docker-compose.yml
├── .env.example
├── scripts/
│   ├── start.sh
│   ├── stop.sh
│   ├── reset.sh
│   ├── load-data.sh
│   ├── upload-terminology.sh
│   └── smoke-test.sh
├── data/
│   └── (sample data files)
└── config/
    └── (service-specific config files)
docs/
└── (SSG website source)
```

**Rationale**: Clear separation of concerns, all Docker-related files in one location.

## Risks / Trade-offs

**[Risk] Upstream akkadakka/snowstorm-x breaking changes** → Pin to specific versions/commits, document upgrade process

**[Risk] Snowstorm memory requirements** → Document minimum system requirements (8GB RAM recommended), provide guidance for memory-constrained systems

**[Risk] Port conflicts on user machines** → Use non-standard ports by default (e.g., 8080, 8081), document how to change via .env

**[Risk] Data persistence confusion** → Clearly document which volumes persist data, what reset.sh deletes, provide warnings before destructive operations

**[Risk] HAPI FHIR CLI version compatibility** → Pin CLI version, test with target HAPI server version

**[Trade-off] Simplicity vs flexibility** → Favor simplicity; advanced users can modify Compose file directly

**[Trade-off] Learning vs production** → Explicitly not production-ready; this prevents scope creep and keeps documentation focused
