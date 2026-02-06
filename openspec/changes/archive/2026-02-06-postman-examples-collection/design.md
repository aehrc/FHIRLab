## Context

Current state: Documentation in `docs/docs/reference/postman.md` provides manual examples but no actual collection file exists. Users must manually create requests in Postman.

Postman Collection format (v2.1) is JSON-based and widely supported. Collections can include:
- Request definitions with URLs, headers, bodies
- Environment variables
- Folder organization
- Saved example responses
- Pre-request scripts and tests

## Goals / Non-Goals

**Goals:**
- Provide ready-to-import Postman collection covering common FHIRLab Core API operations
- Include both HAPI FHIR R4 and Snowstorm endpoints
- Pre-configure environment variables for localhost deployment
- Organize requests logically by service and operation type
- Include example request bodies and saved responses where helpful

**Non-Goals:**
- Not creating exhaustive coverage of every possible FHIR operation
- Not providing production-ready authentication (learning environment only)
- Not maintaining multiple environment configs (only localhost)
- Not creating custom Postman visualizations or complex scripts

## Decisions

### Decision 1: Use Postman Collection v2.1 format

**Rationale**: v2.1 is widely supported, human-readable JSON, and compatible with both Postman desktop and web versions.

**Why**: Maximum compatibility and ease of maintenance.

**Alternatives considered**:
- v1.0 format → Rejected: deprecated, lacks modern features
- OpenAPI/Swagger → Rejected: different tool ecosystem, not Postman-native

### Decision 2: Organize by service, then operation type

**Rationale**: Top-level folders for HAPI FHIR and Snowstorm, sub-folders for resource types or operation categories.

Structure:
```
FHIRLab Core/
├── HAPI FHIR/
│   ├── Server Metadata
│   ├── Patient Operations
│   ├── Observation Operations
│   └── Bundle Operations
└── Snowstorm/
    ├── Version & Health
    ├── Concept Search
    └── Concept Details
```

**Why**: Matches how users think about the APIs - by service first, then operation.

**Alternatives considered**:
- By HTTP method → Rejected: less intuitive for FHIR
- Flat structure → Rejected: too many requests at one level

### Decision 3: Include environment file with localhost defaults

**Rationale**: Separate `.postman_environment.json` with variables for `fhir_base` and `snowstorm_base`.

**Why**: Users can import and immediately use without manual setup. Environment separation allows future addition of other deployments.

### Decision 4: Add basic response validation tests

**Rationale**: Include simple Postman tests (status code, resourceType validation) to help users learn API behavior.

**Why**: Educational value - users see what "correct" looks like. Not exhaustive, just illustrative.

### Decision 5: Store in `postman/` directory at repository root

**Rationale**: Top-level directory keeps collection discoverable and separate from docs.

**Why**: Common convention, easy to find, doesn't clutter docker/ or docs/ directories.

## Risks / Trade-offs

**Risk**: Collection becomes outdated as APIs evolve  
→ **Mitigation**: Keep collection simple with core operations that rarely change. Document that it's for learning, not production.

**Risk**: Users expect authentication examples  
→ **Mitigation**: Clearly document that FHIRLab Core is for learning and doesn't implement authentication.

**Trade-off**: Comprehensive coverage vs maintainability  
→ **Accept**: Prioritize common operations over exhaustive coverage. Users can extend the collection.

**Risk**: Postman format changes over time  
→ **Mitigation**: Use stable v2.1 format. If migration needed, Postman provides conversion tools.
