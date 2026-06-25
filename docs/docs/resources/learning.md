# Learning Resources

Expand your FHIR and healthcare interoperability knowledge.

## Hands-On Learning Activities

FHIRLab ships with eight ready-to-run FHIR R4 transaction bundles covering a complete clinical scenario for a fictional patient (Maria Santos). Load them in order to build up a realistic dataset, then query HAPI and exercise Ontoserver.

**Import the collection:** `postman/learning/FHIRLab-Learning.postman_collection.json`

| # | Bundle | What you learn |
|---|--------|----------------|
| 01 | Patient Registration | Patient demographics, identifiers, language |
| 02 | Vital Signs | Observation, LOINC vital signs codes, UCUM units, BP components |
| 03 | Chronic Conditions | Condition, SNOMED CT (T2DM 44054006, HTN 59621000), clinicalStatus |
| 04 | Allergy Records | AllergyIntolerance, substance coding, criticality, reactions |
| 05 | Immunization History | Immunization, vaccine/disease SNOMED codes, protocolApplied |
| 06 | Lab Results | Laboratory Observations, LOINC + SNOMED dual-coding, referenceRange |
| 07 | Medication Plan | MedicationRequest, SNOMED substance codes, dosageInstruction |
| 08 | Full Encounter | Linking Patient, Practitioner, Encounter, Conditions, Observations, Medications |

After loading all bundles, the **Ontoserver Exercises** folder in the Postman collection walks through:

- `$lookup` — resolve a SNOMED code to its full definition
- `$validate-code` — confirm a code is valid in a ValueSet
- `$expand` — enumerate all concepts in a ValueSet
- `$subsumes` — test subsumption (is T2DM a subtype of Diabetes mellitus?)
- Full-text concept search

See `postman/learning/README.md` for bundle details, source attribution, and all SNOMED/LOINC codes used.

## FHIR Fundamentals

### Official Resources

| Resource | Description |
|----------|-------------|
| [FHIR Overview](https://hl7.org/fhir/R4/overview.html) | Introduction to FHIR concepts |
| [FHIR Summary](https://hl7.org/fhir/R4/summary.html) | Quick reference for developers |
| [Resource Index](https://hl7.org/fhir/R4/resourcelist.html) | Complete list of FHIR resources |

### Tutorials

| Resource | Description |
|----------|-------------|
| [FHIR Drills](https://fhirdrills.com/) | Interactive FHIR exercises |
| [Firely Academy](https://academy.fire.ly/) | Free FHIR courses |
| [HL7 FHIR Fundamentals](https://www.hl7.org/training/fhir-fundamentals.cfm) | Official HL7 training |

### Books

- *FHIR for Developers* - Comprehensive guide to FHIR implementation
- *Principles of Health Interoperability* - HL7 and FHIR context

## SNOMED CT

### Getting Started

| Resource | Description |
|----------|-------------|
| [SNOMED CT Starter Guide](https://confluence.ihtsdotools.org/display/DOCSTART) | Official introduction |
| [E-Learning](https://elearning.ihtsdotools.org/) | Free SNOMED CT courses |
| [Browser](https://browser.ihtsdotools.org/) | Online SNOMED CT browser |

### Technical Resources

| Resource | Description |
|----------|-------------|
| [Technical Implementation Guide](https://confluence.ihtsdotools.org/display/DOCTIG) | Implementation details |
| [FHIR Terminology Module](https://hl7.org/fhir/R4/terminology-module.html) | Using SNOMED CT with FHIR |

## Healthcare Standards

### HL7

| Resource | Description |
|----------|-------------|
| [HL7 International](https://www.hl7.org/) | Standards organization |
| [HL7 FHIR Foundation](https://fhir.org/) | FHIR community resources |

### IHE (Integrating the Healthcare Enterprise)

| Resource | Description |
|----------|-------------|
| [IHE Profiles](https://www.ihe.net/resources/profiles/) | Integration profiles |
| [IHE Wiki](https://wiki.ihe.net/) | Technical documentation |

### Australian Healthcare

| Resource | Description |
|----------|-------------|
| [Australian Digital Health Agency](https://www.digitalhealth.gov.au/) | National digital health |
| [ADHA Developer Resources](https://developer.digitalhealth.gov.au/) | API documentation |

## Development Tools

### FHIR Tools

| Tool | Description |
|------|-------------|
| [Postman](https://www.postman.com/) | API development and testing |
| [FHIR Validator](https://github.com/hapifhir/org.hl7.fhir.core) | Resource validation |
| [Synthea](https://synthetichealth.github.io/synthea/) | Synthetic patient data generator |

### Testing Servers

| Server | Description |
|--------|-------------|
| [HAPI FHIR Test Server](http://hapi.fhir.org/) | Public HAPI FHIR server |
| [SMART on FHIR Sandbox](https://launch.smarthealthit.org/) | SMART app testing |

## Community

### Forums and Discussion

| Platform | Link |
|----------|------|
| HL7 Zulip Chat | [chat.fhir.org](https://chat.fhir.org/) |
| FHIR Subreddit | [r/fhir](https://www.reddit.com/r/fhir/) |
| Stack Overflow | [fhir tag](https://stackoverflow.com/questions/tagged/fhir) |

### Conferences

- **HL7 FHIR DevDays** - Annual FHIR developer conference
- **HIMSS** - Healthcare Information and Management Systems Society
- **HL7 Working Group Meetings** - Standards development

## Hands-On Practice

### Sample Data

| Resource | Description |
|----------|-------------|
| [Synthea](https://synthetichealth.github.io/synthea/) | Generate synthetic patients |
| [SMART Sample Patients](https://github.com/smart-on-fhir/sample-patients) | Pre-built test data |

### Exercises

1. **Create a Patient** - POST a new Patient resource
2. **Search Observations** - Query for vital signs
3. **Build a Bundle** - Create a transaction with multiple resources
4. **Validate Resources** - Use the $validate operation
5. **Terminology Lookup** - Query SNOMED CT codes

## Certifications

| Certification | Organization |
|---------------|--------------|
| HL7 FHIR Certification | HL7 International |
| SNOMED CT Foundation | SNOMED International |

## Recommended Learning Path

1. **Week 1-2**: FHIR Fundamentals
   - Read FHIR overview
   - Complete FHIR Drills exercises
   - Create basic resources in FHIRLab Core

2. **Week 3-4**: Deep Dive
   - Explore specific resource types
   - Learn search parameters
   - Practice with Postman

3. **Week 5-6**: Terminology
   - Introduction to SNOMED CT
   - Using terminology in FHIR
   - Explore Snowstorm API

4. **Ongoing**: Build Projects
   - Create a simple FHIR client
   - Build a SMART on FHIR app
   - Contribute to open source projects
