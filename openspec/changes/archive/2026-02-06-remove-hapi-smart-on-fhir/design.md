## Context

Current state: The SMART on FHIR implementation uses a separate `smart-launcher` container that runs independently of HAPI FHIR. However, script messages and comments use language like "Start with SMART on FHIR enabled" which may confuse users into thinking HAPI has SMART-specific configuration or modes.

Reality:
- HAPI FHIR has no SMART-specific environment variables or configuration
- SMART launcher is completely separate service that connects to HAPI as external client
- The `--smart` flag simply enables an additional Docker Compose profile

This is a documentation/clarity improvement with zero functional changes.

## Goals / Non-Goals

**Goals:**
- Clarify that SMART launcher is an independent service, not a HAPI mode
- Update script output messages to use precise language
- Make docker-compose.yml comments more explicit about service independence
- Help users understand the architecture: HAPI + separate SMART launcher

**Non-Goals:**
- Not removing SMART launcher functionality
- Not changing .env variables or ports
- Not modifying docker-compose.yml structure or service definitions
- Not changing how users invoke the scripts (--smart flag remains)

## Decisions

### Decision 1: Update script messaging to emphasize "additional service"

**Rationale**: Change "SMART on FHIR enabled" to "SMART launcher service enabled" or "Starting SMART launcher (separate service)".

**Why**: The word "enabled" can imply enabling a feature/mode in HAPI. "Service" makes it clear it's an additional container.

**Alternatives considered**:
- Remove --smart flag entirely → Rejected: breaks existing usage patterns
- Add educational warnings → Rejected: adds noise without improving clarity

### Decision 2: Enhance docker-compose.yml comments

**Rationale**: Add comments explicitly stating "This is a separate service, not a HAPI configuration".

**Why**: Users reading the compose file should understand the architectural separation immediately.

### Decision 3: Keep all functionality identical

**Rationale**: This is purely a clarity/documentation improvement.

**Why**: No user behavior changes means no migration risk. Same commands, same results, better understanding.

## Risks / Trade-offs

**Risk**: Users accustomed to current messaging might be confused by wording changes  
→ **Mitigation**: Changes are subtle and descriptive, not fundamentally different. Documentation updates explain the architecture.

**Trade-off**: More verbose messages in exchange for clarity  
→ **Accept**: Clarity is worth an extra word or two in script output.

**Risk**: Might still not be clear enough for all users  
→ **Mitigation**: Documentation pages can provide architecture diagrams and fuller explanation.
