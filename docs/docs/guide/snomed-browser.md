# SNOMED CT Browser

Explore SNOMED CT terminology using the visual browser.

## Accessing the Browser

Open [http://localhost:8082](http://localhost:8082) in your web browser.

## Overview

The SNOMED CT Browser provides a visual interface for:

- Browsing the SNOMED CT hierarchy
- Searching for clinical concepts
- Viewing concept details and relationships
- Exploring reference sets

## Loading SNOMED CT Content

!!! warning "Content Not Included"
    SNOMED CT content is not included due to licensing requirements. You'll need to load content separately.

### Obtaining SNOMED CT

1. **Register** at [SNOMED International Member Licensing](https://www.snomed.org/snomed-ct/get-snomed)
2. **Download** the appropriate RF2 release files
3. **Import** using Snowstorm's import API

### Import Process

Refer to the [Snowstorm documentation](https://github.com/IHTSDO/snowstorm/blob/master/docs/loading-snomed.md) for detailed import instructions.

Basic import via API:

```bash
# Start import job
curl -X POST "http://localhost:8081/imports" \
  -H "Content-Type: application/json" \
  -d '{
    "branchPath": "MAIN",
    "createCodeSystemVersion": true,
    "type": "SNAPSHOT"
  }'
```

## Snowstorm API

The Snowstorm API is available at [http://localhost:8081](http://localhost:8081).

### Swagger Documentation

View interactive API docs at [http://localhost:8081/swagger-ui.html](http://localhost:8081/swagger-ui.html).

### Common API Operations

#### Search Concepts

```bash
curl "http://localhost:8081/MAIN/concepts?term=diabetes"
```

#### Get Concept Details

```bash
curl "http://localhost:8081/MAIN/concepts/73211009"
```

#### Find Children

```bash
curl "http://localhost:8081/MAIN/concepts/73211009/children"
```

## Browser Features

### Hierarchy Navigation

- Browse from the root of the SNOMED CT hierarchy
- Expand/collapse concept trees
- View parent and child relationships

### Concept Search

- Full-text search across descriptions
- Filter by semantic tags
- Search within specific reference sets

### Concept Details

View for each concept:

- Fully Specified Name (FSN)
- Preferred terms in different languages
- Synonyms
- Relationships (IS-A, defining relationships)
- Reference set memberships

## Integration with HAPI FHIR

Snowstorm can be used as a terminology server for HAPI FHIR:

```bash
# Validate a code
curl "http://localhost:8080/fhir/CodeSystem/\$validate-code?url=http://snomed.info/sct&code=73211009"

# Expand a ValueSet
curl "http://localhost:8080/fhir/ValueSet/\$expand?url=http://snomed.info/sct?fhir_vs"
```

## Resources

- [Snowstorm GitHub](https://github.com/IHTSDO/snowstorm)
- [SNOMED CT Browser Documentation](https://github.com/IHTSDO/snomedct-browser)
- [SNOMED International](https://www.snomed.org/)
