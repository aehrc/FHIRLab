# FHIRLab Learning Activities

Eight FHIR R4 transaction bundles for hands-on learning with HAPI FHIR and Ontoserver (Snowstorm).

All bundles are idempotent (PUT with stable logical IDs) — safe to re-submit multiple times.  
The fictional patient **Maria Santos** (MRN-12345) is shared across all bundles.

## Bundle Index

| # | File | Resources | Key standards |
|---|------|-----------|---------------|
| 01 | `01-patient-registration.json` | Patient | Patient demographics, identifiers, communication |
| 02 | `02-vital-signs.json` | Patient + 5 Observations | LOINC vital signs codes |
| 03 | `03-chronic-conditions.json` | Patient + 2 Conditions | SNOMED CT: 44054006, 59621000 |
| 04 | `04-allergy-records.json` | Patient + 2 AllergyIntolerances | SNOMED CT: 764146007, 372687004 |
| 05 | `05-immunization-history.json` | Patient + 3 Immunizations | SNOMED CT vaccine/disease codes |
| 06 | `06-lab-results.json` | Patient + 3 Observations | LOINC + SNOMED; reference ranges |
| 07 | `07-medication-plan.json` | Patient + Practitioner + 2 MedicationRequests | SNOMED substance codes, dosage |
| 08 | `08-full-encounter.json` | Patient + Practitioner + Encounter + 2 Conditions + 2 Observations + MedicationRequest | All resource types linked via encounter |

## Sources and Rationale

### HL7 IPS (International Patient Summary)
- **Source:** https://hl7.org/fhir/uv/ips/
- **Used for:** Patient demographics pattern (bundle 01), blood pressure LOINC codes (bundle 02), allergy intolerance structure and penicillin code 764146007 (bundle 04), LOINC vital sign codes (bundle 02)
- **Assessment:** The IPS IG publishes FSH-sourced, JSON-published bundles with real clinical coding. Best available source for complete, conformant FHIR patient summaries. The `bundle-ips-all-sections` example directly provided the BP panel code (85354-9) and the HTN SNOMED code (59621000).
- **Licence:** Apache 2.0 (HL7 FHIR specifications)

### chronic-care/sample-data (MITRE)
- **Source:** https://github.com/chronic-care/sample-data
- **Used for:** T2DM SNOMED code 44054006 and HTN SNOMED code 38341003 (bundles 03, 08); CKD/kidney function rationale for including creatinine in bundle 06
- **Assessment:** The richest source of SNOMED-coded chronic condition data found. Directly relevant to the SSCP target population (T2DM and HTN are the leading NCDs across Pacific island nations). Apache 2.0 licensed, R4, multi-file JSON.

### WHO SMART Guidelines — Immunizations (IMMZ)
- **Source:** https://github.com/WorldHealthOrganization/smart-example-immz
- **Used for:** Immunization bundle structure (bundle 05), COVID-19 SNOMED vaccine code 1119305005, measles/EPI scenario pattern, ConceptMap approach for Ontoserver exercises
- **Assessment:** April 2026 v1.0.0 release; authoritative for Pacific EPI programme contexts. The IMMZ IG is directly aligned with WHO's SMART on FHIR guidelines used in SSCP partner countries.

### HL7 FHIR R4 Specification (Official Examples)
- **Source:** https://hl7.org/fhir/R4/bundle-examples.html
- **Assessment:** Only 1 of 9 official bundle examples uses SNOMED CT (severity/body-site codes only); none cover T2DM or HTN. **Not used as a content source** — spec bundles are HTTP-mechanics demos, not clinical content. The LOINC codes for vital signs and labs are drawn from the FHIR R4 vital signs profile (http://hl7.org/fhir/StructureDefinition/vitalsigns) and the Observation resource spec.

### Terminology codes used

All SNOMED CT codes validated against the SNOMED International browser (https://browser.ihtsdotools.org/).

| SNOMED CT code | Display |
|----------------|---------|
| 44054006 | Type 2 diabetes mellitus (disorder) |
| 59621000 | Essential hypertension (disorder) |
| 764146007 | Substance with penicillin structure and pharmacological action (substance) |
| 372687004 | Aspirin (substance) |
| 1119305005 | COVID-19 antigen vaccine (product) |
| 76902006 | Tetanus (disorder) |
| 840539006 | Disease caused by SARS-CoV-2 (disorder) |
| 43396009 | Haemoglobin A1c measurement (procedure) |
| 372567009 | Metformin (substance) |
| 386864001 | Amlodipine (substance) |
| 309343006 | Physician (occupation) |
| 390906007 | Follow-up encounter (procedure) |
| 26643006 | Oral route (qualifier value) |

| LOINC code | Display |
|------------|---------|
| 85354-9 | Blood pressure panel |
| 8480-6 | Systolic blood pressure |
| 8462-4 | Diastolic blood pressure |
| 8867-4 | Heart rate |
| 59408-5 | Oxygen saturation (pulse oximetry) |
| 8310-5 | Body temperature |
| 29463-7 | Body weight |
| 59261-8 | HbA1c (IFCC) |
| 14743-9 | Glucose (capillary, glucometer) |
| 2160-0 | Creatinine (serum/plasma) |

## Ontoserver / Snowstorm Exercises

Use the **Ontoserver** section of the Postman collection to exercise the SNOMED terminology server:

- **Concept lookup** — resolve a SNOMED code to its full definition
- **$validate-code** — check whether a code is valid in a ValueSet
- **$expand** — expand a ValueSet to see all included codes
- **Subsumption ($subsumes)** — test whether T2DM is a subtype of Diabetes mellitus
- **Search** — find SNOMED concepts by text (e.g. search for "hypertension")

## Loading the bundles

Using Postman with the `FHIRLab-Learning.postman_collection.json` collection:

1. Import `FHIRLab-Learning.postman_collection.json` and the `../FHIRLab-Core.postman_environment.json` environment
2. Select the **FHIRLab Core - Localhost** environment
3. Run bundles 01–08 in order from the **Load Bundles** folder
4. Use the **Query HAPI** folder to verify data was loaded
5. Use the **Ontoserver Exercises** folder to explore SNOMED terminology

Or via curl:

```bash
curl -X POST http://localhost:8080/fhir \
  -H "Content-Type: application/fhir+json" \
  -d @bundles/01-patient-registration.json
```
