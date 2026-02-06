## Context

FHIRLab Core currently lacks a simple deployment option for teams without DevOps expertise. The target users are regional healthcare teams, educational institutions, and developers who need a learning sandbox but cannot invest in complex infrastructure setup.

**Current state**: No standardized deployment method exists in the SSCP GitHub repository.

**Constraints**:
- Must work on any system with Docker and Docker Compose installed
- No cloud-specific dependencies (AWS, GCP, Azure)
- No orchestration tools beyond Docker Compose (no Kubernetes, Helm)
- Learning sandbox only - not production-grade

**Stakeholders**: Regional healthcare teams, educators, FHIR developers, FHIRLab maintainers

## Goals / Non-Goals

**Goals:**
- Single-command startup of complete FHIRLab Core environment
- Clone-to-running in under 10 minutes for users with basic command-line skills
- Clear separation between configuration and runtime data
- Reproducible environment via reset scripts
- Self-documenting through example files and inline comments

**Non-Goals:**
- Production deployment (no HA, no scaling, no backups)
- Custom SSL/TLS configuration
- External database support (uses embedded/containerized databases)
- Kubernetes or cloud-native deployment
- Automated CI/CD pipelines for the learning environment itself

## Decisions

### 1. Use official upstream Docker images where available

**Decision**: Use official HAPI FHIR and Snowstorm images from Docker Hub rather than building custom images.

**Rationale**: Reduces maintenance burden, ensures security updates flow automatically, and keeps the setup transparent. Custom Dockerfiles only where necessary for configuration injection.

**Alternatives considered**:
- Build all images from source: More control but higher maintenance burden
- Fork upstream images: Unnecessary complexity for a learning sandbox

### 2. Single docker-compose.yml with optional service profiles

**Decision**: One Compose file with Docker Compose profiles to enable/disable optional services (e.g., SMART on FHIR).

**Rationale**: Keeps configuration centralized while allowing flexibility. Users can run `docker compose up` for core services or `docker compose --profile smart up` for extended setup.

**Alternatives considered**:
- Multiple Compose files: Harder to understand, merge conflicts
- Environment variable toggles: Less discoverable than profiles

### 3. Shell scripts wrap Docker Compose commands

**Decision**: Provide `start.sh`, `stop.sh`, `reset.sh`, and `load-data.sh` scripts that wrap Docker Compose with appropriate flags and feedback.

**Rationale**: Abstracts Docker Compose complexity, provides consistent UX, enables pre/post hooks (health checks, data validation), and documents the intended workflow.

**Alternatives considered**:
- Makefile: Less portable on Windows, unfamiliar to some users
- Direct Docker Compose only: Requires users to remember flags and sequences

### 4. Environment configuration via .env.example

**Decision**: Ship `.env.example` with documented defaults. Users copy to `.env` and modify as needed.

**Rationale**: Standard Docker Compose pattern, keeps secrets out of version control, self-documenting through comments.

**Alternatives considered**:
- Hardcoded values: Inflexible, harder to customize
- Config file (YAML/JSON): Requires additional tooling to merge with Compose

### 5. Sample data as FHIR Bundles loaded via script

**Decision**: Store sample data as FHIR Bundle JSON files, loaded via `load-data.sh` using curl or a lightweight loader container.

**Rationale**: FHIR-native format, version-controllable, easy to extend or replace. Script provides feedback on load success/failure.

**Alternatives considered**:
- Database dumps: Not portable across HAPI versions, opaque
- Synthea generation at runtime: Adds complexity and runtime dependencies

### 6. Directory structure under `docker/`

**Decision**: All Docker-related files in `docker/` subdirectory:
```
docker/
├── docker-compose.yml
├── .env.example
├── scripts/
│   ├── start.sh
│   ├── stop.sh
│   ├── reset.sh
│   └── load-data.sh
├── data/
│   └── sample-bundles/
└── config/
    └── (service-specific config files)
```

**Rationale**: Clear separation from application code, all deployment concerns in one location, easy to package or extract.

## Risks / Trade-offs

**[Risk] Upstream image breaking changes** → Pin to specific image tags in docker-compose.yml, document upgrade process

**[Risk] Snowstorm memory requirements** → Document minimum system requirements (8GB RAM recommended), provide guidance for memory-constrained systems

**[Risk] Port conflicts on user machines** → Use non-standard ports by default (e.g., 8080, 8081), document how to change via .env

**[Risk] Data persistence confusion** → Clearly document which volumes persist data, what reset.sh deletes, provide warnings before destructive operations

**[Trade-off] Simplicity vs flexibility** → Favor simplicity; advanced users can modify Compose file directly

**[Trade-off] Learning vs production** → Explicitly not production-ready; this prevents scope creep and keeps documentation focused
