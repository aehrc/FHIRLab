# Postman Collection

Use Postman to explore the FHIRLab Core APIs interactively.

!!! success "Ready-to-Use Collection"
    FHIRLab Core includes a pre-configured Postman collection with 15 example requests for HAPI FHIR and Snowstorm APIs. No manual setup required!

## Download Collection Files

The collection files are included in the repository:

- **Collection**: `postman/FHIRLab-Core.postman_collection.json`
- **Environment**: `postman/FHIRLab-Core.postman_environment.json`

Or download directly:

- [:octicons-download-24: Download Collection](https://raw.githubusercontent.com/fhirlab/core/main/postman/FHIRLab-Core.postman_collection.json)
- [:octicons-download-24: Download Environment](https://raw.githubusercontent.com/fhirlab/core/main/postman/FHIRLab-Core.postman_environment.json)

## Getting Postman

Download Postman from [postman.com/downloads](https://www.postman.com/downloads/).

## Importing the Collection

FHIRLab Core provides ready-to-use Postman collection and environment files.

### Quick Import

1. Open Postman
2. Click **Import** in the top left
3. Select **Upload Files**
4. Import both files from the repository:
   - `postman/FHIRLab-Core.postman_collection.json` - Request collection
   - `postman/FHIRLab-Core.postman_environment.json` - Environment variables
5. Select the "FHIRLab Core - Localhost" environment from the dropdown in the top right

You're ready to send requests! Try the "Get Server Metadata" request under HAPI FHIR → Server Metadata.

### What's Included

The collection includes 15 pre-configured requests organized into folders:

**HAPI FHIR:**
- Server Metadata (CapabilityStatement)
- Patient Operations (List, Search, Get, Create)
- Observation Operations (List, Search by Patient, Search by Code)
- Bundle Operations (Transaction Bundle)

**Snowstorm:**
- Version & Health Check
- Concept Search (with example: "diabetes")
- Concept Details (Get concept, descriptions, children)

All requests include response validation tests and use environment variables for easy configuration.

### Manual Setup

If you prefer to create the collection manually, follow the examples below.

## Environment Setup

The imported environment file includes these pre-configured variables for localhost deployment:

| Variable | Value | Description |
|----------|-------|-------------|
| `fhir_base` | `http://localhost:8080/fhir` | HAPI FHIR base URL |
| `snowstorm_base` | `http://localhost:8081` | Snowstorm base URL |

## HAPI FHIR Requests

### Server Metadata

```
GET {{fhir_base}}/metadata
```

Returns the server's CapabilityStatement.

### Patient Operations

**List Patients:**
```
GET {{fhir_base}}/Patient
```

**Search by Name:**
```
GET {{fhir_base}}/Patient?family=Smith
```

**Get Patient by ID:**
```
GET {{fhir_base}}/Patient/123
```

**Create Patient:**
```
POST {{fhir_base}}/Patient
Content-Type: application/fhir+json

{
  "resourceType": "Patient",
  "name": [
    {
      "family": "Smith",
      "given": ["John"]
    }
  ],
  "birthDate": "1980-01-15",
  "gender": "male"
}
```

### Observation Operations

**List Observations:**
```
GET {{fhir_base}}/Observation
```

**Search by Patient:**
```
GET {{fhir_base}}/Observation?subject=Patient/123
```

**Search by Code:**
```
GET {{fhir_base}}/Observation?code=http://loinc.org|55284-4
```

### Bundle Operations

**Transaction Bundle:**
```
POST {{fhir_base}}
Content-Type: application/fhir+json

{
  "resourceType": "Bundle",
  "type": "transaction",
  "entry": [
    {
      "resource": {
        "resourceType": "Patient",
        "name": [{"family": "Doe"}]
      },
      "request": {
        "method": "POST",
        "url": "Patient"
      }
    }
  ]
}
```

## Snowstorm Requests

### Version Info

```
GET {{snowstorm_base}}/version
```

### Search Concepts

```
GET {{snowstorm_base}}/MAIN/concepts?term=diabetes&limit=10
```

### Get Concept Details

```
GET {{snowstorm_base}}/MAIN/concepts/73211009
```

### Get Concept Descriptions

```
GET {{snowstorm_base}}/MAIN/concepts/73211009/descriptions
```

### Get Concept Children

```
GET {{snowstorm_base}}/MAIN/concepts/73211009/children?form=inferred
```

## Tips for Using Postman

### Save Responses as Examples

1. Send a request
2. Click **Save Response** > **Save as example**
3. Name it descriptively

### Use Pre-request Scripts

Set dynamic values:

```javascript
pm.environment.set("timestamp", new Date().toISOString());
```

### Test Responses

Add tests to validate responses:

```javascript
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

pm.test("Response is FHIR Bundle", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.resourceType).to.eql("Bundle");
});
```

### Collection Variables

Store commonly used values:

- Patient IDs for testing
- Code system URLs
- ValueSet references

## External Resources

- [HAPI FHIR Server Documentation](https://hapifhir.io/hapi-fhir/docs/server_jpa/)
- [FHIR R4 Specification](https://hl7.org/fhir/R4/)
- [Snowstorm API Documentation](https://github.com/IHTSDO/snowstorm/blob/master/docs/using-the-api.md)
- [Postman Learning Center](https://learning.postman.com/)
