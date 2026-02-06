## Why

Users currently need to manually create Postman requests from documentation examples. A ready-to-use Postman collection with pre-configured requests and example responses would significantly accelerate learning and API exploration for FHIRLab Core services (HAPI FHIR, Snowstorm).

## What Changes

- Create a Postman collection (JSON) with example requests for HAPI FHIR R4 and Snowstorm APIs
- Include pre-configured environment variables for localhost deployment
- Add example request bodies and saved response examples for common operations
- Organize requests into logical folders (HAPI FHIR, Snowstorm, SNOMED CT)
- Include basic Postman tests for response validation
- Reference the collection in existing documentation

## Capabilities

### New Capabilities

- `postman-collection`: Postman collection file with example API requests for HAPI FHIR and Snowstorm services, including environment configuration, request organization, and response examples

### Modified Capabilities

<!-- None - this is a new artifact, not modifying existing behavior -->

## Impact

- **New Files**: `postman/FHIRLab-Core.postman_collection.json`, `postman/FHIRLab-Core.postman_environment.json`
- **Documentation**: `docs/docs/reference/postman.md` - update to reference actual collection file
- **No breaking changes**: Purely additive - provides ready-to-use collection
