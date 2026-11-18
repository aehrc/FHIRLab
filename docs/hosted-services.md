# Hosted FHIRLab Services

Besides the FHIRLab Core kit you run yourself, CSIRO runs a small set of hosted FHIRLab services. This page lists what is running, what is paused, and the known limitations of the Snowstorm terminology server.

*Last checked: 18 November 2026.*

## Running

| Service | Endpoint | Software | Purpose |
|---------|----------|----------|---------|
| **FHIRLab Terminology** | https://tx.fhirlab.net/fhir | Ontoserver 6.31 | Terminology server: SNOMED CT International, SNOMED CT GPS, LOINC |
| **FHIRLab CDR** | https://cdr.fhirlab.net/fhir | HAPI FHIR 8.2 (R4) | General-purpose FHIR R4 server |
| **PH eReferral CDR** | https://cdr.pheref.fhirlab.net/fhir | HAPI FHIR 8.10 (R4) | FHIR server for the Philippines eReferral IG |
| **PH Core CDR** | https://cdr.phcore.fhirlab.net/fhir | HAPI FHIR 8.10 (R4) | FHIR server for PH Core |
| **IPS CDR** | https://ips.fhirlab.net/fhir | HAPI FHIR 8.8 (R4) | FHIR server for International Patient Summary (IPS) testing |
| **Inferno (IPS)** | https://inferno.fhirlab.net/ips/ | Inferno with the IPS test kit | Conformance testing against the IPS CDR |
| **Aidbox** | https://aidbox.fhirlab.net | Aidbox | FHIR platform with forms |

Backup instances of the terminology server and the CDR are kept ready for events such as training and connectathons:

| Service | Endpoint |
|---------|----------|
| Terminology (backup) | https://tx.staging.fhirlab.net/fhir |
| CDR (backup) | https://cdr.staging.fhirlab.net/fhir |

## Paused

These services are paused. Their addresses show a "Service Paused" page.

- Snowstorm (`snowstorm.fhirlab.net`)
- Bahmni (`bahmni.dev.fhirlab.net`)
- BedaEMR (`beda.fhirlab.net`)
- Smile CDR (`smile.fhirlab.net`)
- FormLab (`formlab.fhirlab.net` and its `ehr`, `forms` and `fhir` sub-sites)

To run FormLab or Snowstorm yourself, use FHIRLab Core: see [FormLab](formlab.md) and [SNOMED CT Browser](guide/snomed-browser.md).

## Snowstorm: Supported Operations and Limitations

Snowstorm is the open-source SNOMED CT terminology server used in FHIRLab Core. FHIRLab Core uses it instead of Ontoserver because Ontoserver needs a licence. The hosted instance ran Snowstorm 7.0.1 (FHIR R4) until it was paused.

### Supported FHIR operations

| Resource | Operations |
|----------|------------|
| CodeSystem | `$lookup`, `$validate-code`, `$subsumes` |
| ValueSet | `$expand`, `$validate-code` |
| ConceptMap | `$translate` |

Snowstorm supports SNOMED CT only. For LOINC or other code systems, use a server such as Ontoserver.

### Limitations

**The GPS package on its own is not enough for FHIR terminology operations.** The SNOMED CT Global Patient Set (GPS) package is a reference set, meaning a list of concept IDs. It does not include the descriptions, relationships or hierarchy of those concepts. A test of the hosted instance in January 2026, with the GPS package loaded, gave these results:

| Check | Result |
|-------|--------|
| Is a concept in the GPS? (membership) | Works |
| `$lookup` | Fails: concept not found |
| `$expand` | Fails (HTTP 500) |
| `$validate-code` | Fails |

For working `$lookup`, `$expand` and `$validate-code`, load the **SNOMED CT International Edition** as well. That requires a SNOMED CT licence: see [SNOMED CT Licensing](guide/snomed-browser.md#snomed-ct-licensing).

**Licensing.** SNOMED CT release files cannot be redistributed. Every user or organisation must get their own copy through [MLDS](https://mlds.ihtsdotools.org/). A hosted Snowstorm instance can only offer the content its operator is licensed to provide.
