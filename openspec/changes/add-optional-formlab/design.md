## Context

FHIRLab Core uses Docker Compose profiles for optional services (e.g., SMART launcher with `--profile smart`). FormLab provides a SMART-on-FHIR demonstration with questionnaire/form capabilities from https://gitlab.com/australian-e-health-research-centre/form-lab. The current architecture has:
- Core services: HAPI FHIR, Snowstorm, Elasticsearch, SNOMED Browser
- Optional service: SMART Launcher (profile-based)
- Documentation website using MkDocs
- Operational scripts: start.sh, stop.sh, reset.sh, load-data.sh

FormLab integration follows the same pattern as the existing SMART launcher - a separate optional service that connects to HAPI FHIR.

## Goals / Non-Goals

**Goals:**
- Add FormLab as an optional Docker Compose service using profile `formlab`
- Maintain zero impact on core services (HAPI FHIR, Snowstorm)
- Provide clear documentation for users to discover and use FormLab
- Keep deployment simple - one command to enable FormLab
- Update operational scripts to mention FormLab availability

**Non-Goals:**
- Deep integration with HAPI FHIR configuration (FormLab connects as external client)
- Making FormLab a default/mandatory service
- Custom FormLab configuration beyond basic connection settings
- Modifying FormLab's internal behavior or functionality

## Decisions

### Decision 1: Use Docker Compose Profile Pattern
**Chosen:** Add FormLab as a profile-activated service (similar to SMART launcher)

**Rationale:** 
- Consistent with existing optional service pattern
- Users already understand `--profile` concept from SMART launcher
- Zero impact when not enabled
- Simple activation: `docker compose --profile formlab up -d`

**Alternatives considered:**
- Separate docker-compose-formlab.yml file → Rejected: Adds complexity, multiple compose files harder to manage
- Make FormLab default service → Rejected: Violates "minimal core" principle

### Decision 2: Reference FormLab GitLab Repository
**Chosen:** Extract docker compose configuration from FormLab repository and adapt for FHIRLab context

**Rationale:**
- FormLab already has working docker compose configuration
- Need to adapt network names, service names, and environment variables for FHIRLab conventions
- Maintain single docker-compose.yml for all services

**Implementation approach:**
1. Review FormLab's docker compose snippet
2. Extract service definition
3. Adapt to use `fhirlab` network and naming conventions
4. Configure to connect to existing HAPI FHIR service

### Decision 3: Documentation Strategy
**Chosen:** Add dedicated FormLab page in docs website + README section

**Rationale:**
- Documentation website provides detailed setup/usage instructions
- README gives quick overview and quickstart
- Maintains consistency with how other optional features are documented

**Sections to add:**
- README: FormLab in components list, quickstart command, port info
- Docs: New page covering FormLab purpose, setup, usage examples, troubleshooting

### Decision 4: Minimal Script Changes
**Chosen:** Update scripts to mention FormLab profile availability in help text, but don't modify core behavior

**Rationale:**
- Scripts work with any profile via docker compose passthrough
- Adding FormLab-specific logic increases maintenance burden
- Users can combine profiles: `--profile smart --profile formlab`

**Updates needed:**
- Add FormLab to help text in start.sh
- Mention FormLab in reset.sh documentation comments
- No changes needed to stop.sh (works universally)

## Risks / Trade-offs

**[Risk] FormLab Docker image may not be publicly available or may change**
→ **Mitigation:** Document the FormLab GitLab reference clearly. If image becomes unavailable, instructions guide users to the source repository.

**[Risk] FormLab may require specific HAPI FHIR configuration not present in default setup**
→ **Mitigation:** Test FormLab connection with default HAPI FHIR configuration. Document any prerequisites clearly. FormLab should work as external client without HAPI modifications.

**[Risk] Port conflicts if user already has service on FormLab's default port**
→ **Mitigation:** Use environment variable for port configuration (e.g., `FORMLAB_PORT`). Include in .env.example with clear default. Document port customization.

**[Trade-off] FormLab configuration extracted from source repository may drift over time**
→ **Accepted:** FormLab is optional and maintained separately. Document the source repository URL so users can reference updates. Version pin the Docker image for stability.

**[Risk] Users may not discover FormLab exists**
→ **Mitigation:** Mention in README components section, quickstart instructions, and documentation website navigation. Include in architecture diagram.

## Migration Plan

**Deployment Steps:**
1. Add FormLab service definition to docker-compose.yml
2. Add FormLab configuration variables to .env.example
3. Update README.md with FormLab information
4. Add FormLab page to documentation website
5. Update operational scripts with FormLab references
6. Test end-to-end: start with profile, verify connectivity, reset, stop

**Validation:**
- Verify core services start normally without profile (no regression)
- Verify FormLab starts with `--profile formlab`
- Test FormLab can connect to HAPI FHIR
- Verify documentation builds correctly
- Test operational scripts still work

**Rollback:**
- Profile-based design means FormLab can be removed by reverting changes
- No data migration needed (FormLab is stateless or uses its own storage)
- No breaking changes to existing users

## Open Questions

1. **What is the exact Docker image name for FormLab?**
   - Need to identify the image from the GitLab repository
   - May need to reference docker compose snippet directly

2. **What port does FormLab expose?**
   - Need to determine default port and ensure no conflicts
   - Suggest: 8084 (next available after SMART launcher at 8083)

3. **Does FormLab require data preloading or initialization?**
   - Check if FormLab needs specific FHIR resources loaded
   - May need to add to load-data.sh script

4. **Should FormLab be included in the architecture diagram?**
   - Yes, as optional component alongside SMART launcher
