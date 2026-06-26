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

## SNOMED CT Licensing

SNOMED CT is a proprietary clinical terminology owned by SNOMED International. Loading SNOMED CT content into Snowstorm requires a license.

### License Options

**SNOMED International member countries (free)**

Many countries are [SNOMED International members](https://www.snomed.org/members). If yours is, you may be entitled to a free license through your National Release Centre (NRC). Register and download via the [Member Licensing and Distribution Service (MLDS)](https://mlds.ihtsdotools.org/).

**SNOMED CT Global Patient Set (GPS) — available in any country**

The GPS is a curated subset of ~8,000 SNOMED CT concepts covering clinical findings, procedures, and substances used in international patient summaries. It is available under a less restrictive license with no NRC membership required.

**This is the recommended starting point for learning.**

**Full SNOMED CT International Release**

Requires a license from your NRC or SNOMED International. Download from [MLDS](https://mlds.ihtsdotools.org/) after authenticating with a licensed account.

### Licensing Constraints

!!! warning "Redistribution and automated download are not permitted"
    - SNOMED CT release files **cannot be redistributed** to other users
    - Downloads **cannot be automated** — each user must obtain their own copy through MLDS
    - FHIRLab scripts upload a file you have already downloaded; they do not fetch SNOMED CT on your behalf

## Loading SNOMED CT into Snowstorm

Snowstorm accepts SNOMED CT RF2 release packages (`.zip` files) via its REST API. The import is asynchronous: create a job, upload the file, then wait.

### What to Download

From [MLDS](https://mlds.ihtsdotools.org/), download an RF2 **Snapshot** package:

| Release | File name pattern | Size | When to use |
|---------|-------------------|------|-------------|
| **GPS** | `SnomedCT_GPSRefset_Production_YYYYMMDDTXXXXXX.zip` | ~300 MB | Learning — recommended |
| Full international | `SnomedCT_InternationalRF2_PRODUCTION_YYYYMMDDTXXXXXX.zip` | ~1.5 GB | Full SNOMED CT content |

### Step 1: Create an Import Job

```bash
JOB_ID=$(curl -s -X POST "http://localhost:8081/imports" \
  -H "Content-Type: application/json" \
  -d '{
    "branchPath": "MAIN",
    "createCodeSystemVersion": true,
    "type": "SNAPSHOT"
  }' | jq -r '.id')

echo "Import job: $JOB_ID"
```

### Step 2: Upload the RF2 Package

```bash
curl -X POST "http://localhost:8081/imports/$JOB_ID/archive" \
  -F "file=@/path/to/SnomedCT_Release.zip"
```

### Step 3: Monitor Progress

```bash
curl "http://localhost:8081/imports/$JOB_ID"
```

Status progresses: `WAITING_FOR_FILE` → `RUNNING` → `COMPLETED`.

- GPS: typically a few minutes
- Full international release: 30+ minutes

!!! tip "No `jq` installed?"
    Install with `apt install jq` or `brew install jq`. Or copy the `id` value from the Step 1 JSON response manually.

See the [Snowstorm loading guide](https://github.com/IHTSDO/snowstorm/blob/master/docs/loading-snomed.md) for full details.

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
