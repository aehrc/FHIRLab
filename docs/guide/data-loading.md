# Loading Data

Learn how to load FHIR resources and terminology into FHIRLab Core.

## Loading Example FHIR Resources

The `load-data.sh` script uploads example FHIR R4 resources to the server:

```bash
./scripts/load-data.sh
```

This loads a variety of example resources including:

- Patients
- Practitioners
- Organizations
- Observations
- Conditions
- Medications
- And more...

> The script uses the HAPI FHIR CLI bundled inside the Docker container. No local installation is needed.
**Reference:** [HAPI FHIR CLI Documentation](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-example-resources-upload-examples)

## Uploading Terminology

Upload custom terminology files (CodeSystems, ValueSets):

```bash
./scripts/upload-terminology.sh <path-to-file>
```

The script copies your file into the Docker container and uses the bundled HAPI FHIR CLI to upload it.

### Supported Formats

- CodeSystem resources (JSON or XML)
- ValueSet resources (JSON or XML)
- FHIR Bundles containing terminology resources

### Example

```bash
# Upload a custom CodeSystem
./scripts/upload-terminology.sh ./my-codesystem.json

# Upload a ValueSet
./scripts/upload-terminology.sh ./my-valueset.xml
```

**Reference:** [HAPI FHIR CLI - Upload Terminology](https://hapifhir.io/hapi-fhir/docs/tools/hapi_fhir_cli.html#upload-terminology)

## Loading Data via API

You can also load data directly using the FHIR REST API.

### Create a Single Resource

```bash
curl -X POST http://localhost:8080/fhir/Patient \
  -H "Content-Type: application/fhir+json" \
  -d '{
    "resourceType": "Patient",
    "name": [{"family": "Smith", "given": ["John"]}]
  }'
```

### Upload a Bundle

```bash
curl -X POST http://localhost:8080/fhir \
  -H "Content-Type: application/fhir+json" \
  -d @my-bundle.json
```

## Loading SNOMED CT Content

Snowstorm requires SNOMED CT RF2 release files. Due to licensing requirements, these are not included.

### Obtaining SNOMED CT Files

1. Register at [SNOMED International](https://www.snomed.org/snomed-ct/get-snomed)
2. Download the RF2 release files
3. Follow the [Snowstorm import documentation](https://github.com/IHTSDO/snowstorm/blob/master/docs/loading-snomed.md)

> **Note:** SNOMED CT usage requires appropriate licensing. FHIRLab Core uses Snowstorm to avoid licensing issues with the server itself, but content still requires proper licensing.
## Verifying Loaded Data

### Check FHIR Resources

```bash
# List all patients
curl http://localhost:8080/fhir/Patient

# Count observations
curl "http://localhost:8080/fhir/Observation?_summary=count"
```

### Check Terminology

```bash
# List CodeSystems
curl http://localhost:8080/fhir/CodeSystem

# List ValueSets
curl http://localhost:8080/fhir/ValueSet
```

## Clearing Data

To remove all data and start fresh:

```bash
./scripts/reset.sh
```

This removes all FHIR resources, terminology, and Elasticsearch data.
