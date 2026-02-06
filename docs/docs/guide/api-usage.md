# Using the API

Learn how to interact with the HAPI FHIR REST API.

## API Endpoint

The FHIR R4 API is available at:

```
http://localhost:8080/fhir
```

## Getting Started

### Server Capabilities

View the server's capability statement:

```bash
curl http://localhost:8080/fhir/metadata
```

This returns a CapabilityStatement resource describing supported features.

### Search Resources

List all patients:

```bash
curl http://localhost:8080/fhir/Patient
```

Search with parameters:

```bash
# Find patients named "Smith"
curl "http://localhost:8080/fhir/Patient?family=Smith"

# Find observations with a specific code
curl "http://localhost:8080/fhir/Observation?code=http://loinc.org|55284-4"
```

## Common Operations

### Read a Resource

```bash
curl http://localhost:8080/fhir/Patient/123
```

### Create a Resource

```bash
curl -X POST http://localhost:8080/fhir/Patient \
  -H "Content-Type: application/fhir+json" \
  -d '{
    "resourceType": "Patient",
    "name": [{"family": "Smith", "given": ["John"]}],
    "birthDate": "1980-01-15"
  }'
```

### Update a Resource

```bash
curl -X PUT http://localhost:8080/fhir/Patient/123 \
  -H "Content-Type: application/fhir+json" \
  -d '{
    "resourceType": "Patient",
    "id": "123",
    "name": [{"family": "Smith", "given": ["John", "Robert"]}],
    "birthDate": "1980-01-15"
  }'
```

### Delete a Resource

```bash
curl -X DELETE http://localhost:8080/fhir/Patient/123
```

## Search Parameters

### Common Search Parameters

| Parameter | Description | Example |
|-----------|-------------|---------|
| `_id` | Resource ID | `?_id=123` |
| `_lastUpdated` | Last update time | `?_lastUpdated=gt2023-01-01` |
| `_count` | Results per page | `?_count=50` |
| `_sort` | Sort order | `?_sort=-_lastUpdated` |
| `_summary` | Summary mode | `?_summary=count` |

### Patient-Specific

| Parameter | Description | Example |
|-----------|-------------|---------|
| `family` | Family name | `?family=Smith` |
| `given` | Given name | `?given=John` |
| `birthdate` | Birth date | `?birthdate=1980-01-15` |
| `identifier` | Identifier | `?identifier=12345` |

### Chaining and Includes

```bash
# Find observations for a specific patient
curl "http://localhost:8080/fhir/Observation?subject=Patient/123"

# Include referenced resources
curl "http://localhost:8080/fhir/Observation?_include=Observation:subject"
```

## Response Formats

### JSON (Default)

```bash
curl http://localhost:8080/fhir/Patient \
  -H "Accept: application/fhir+json"
```

### XML

```bash
curl http://localhost:8080/fhir/Patient \
  -H "Accept: application/fhir+xml"
```

### Pretty Print

Add `_pretty=true` to format the response:

```bash
curl "http://localhost:8080/fhir/Patient?_pretty=true"
```

## Bulk Operations

### Transaction Bundle

```bash
curl -X POST http://localhost:8080/fhir \
  -H "Content-Type: application/fhir+json" \
  -d '{
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
  }'
```

### Bulk Export

```bash
# Initiate export
curl -X GET "http://localhost:8080/fhir/\$export" \
  -H "Accept: application/fhir+json" \
  -H "Prefer: respond-async"
```

## Web Interface

HAPI FHIR includes a web interface for browsing and testing:

1. Open [http://localhost:8080](http://localhost:8080)
2. Use the search forms to query resources
3. View and edit resources through the UI

## Using Postman

See the [Postman Collection](../reference/postman.md) for a pre-built collection of API requests.
