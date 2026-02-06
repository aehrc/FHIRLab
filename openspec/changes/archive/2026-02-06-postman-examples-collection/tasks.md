## 1. Setup directory and collection structure

- [x] 1.1 Create `postman/` directory at repository root
- [x] 1.2 Create initial Postman collection v2.1 JSON structure
- [x] 1.3 Set collection name to "FHIRLab Core" with description
- [x] 1.4 Create folder structure: HAPI FHIR and Snowstorm top-level folders

## 2. HAPI FHIR requests - Server Metadata

- [x] 2.1 Create "Server Metadata" folder under HAPI FHIR
- [x] 2.2 Add GET {{fhir_base}}/metadata request
- [x] 2.3 Add response validation test for status 200 and resourceType

## 3. HAPI FHIR requests - Patient Operations

- [x] 3.1 Create "Patient Operations" folder under HAPI FHIR
- [x] 3.2 Add "List Patients" GET request
- [x] 3.3 Add "Search by Name" GET request with family parameter
- [x] 3.4 Add "Get Patient by ID" GET request with example ID
- [x] 3.5 Add "Create Patient" POST request with example Patient JSON body
- [x] 3.6 Add response validation tests to patient requests

## 4. HAPI FHIR requests - Observation Operations

- [x] 4.1 Create "Observation Operations" folder under HAPI FHIR
- [x] 4.2 Add "List Observations" GET request
- [x] 4.3 Add "Search by Patient" GET request with subject parameter
- [x] 4.4 Add "Search by Code" GET request with LOINC code example
- [x] 4.5 Add response validation tests to observation requests

## 5. HAPI FHIR requests - Bundle Operations

- [x] 5.1 Create "Bundle Operations" folder under HAPI FHIR
- [x] 5.2 Add "Transaction Bundle" POST request
- [x] 5.3 Add example Bundle JSON with transaction entry creating a Patient
- [x] 5.4 Add response validation test for Bundle resourceType

## 6. Snowstorm requests - Version & Health

- [x] 6.1 Create "Version & Health" folder under Snowstorm
- [x] 6.2 Add "Version Info" GET {{snowstorm_base}}/version request
- [x] 6.3 Add response validation test for status 200

## 7. Snowstorm requests - Concept Search

- [x] 7.1 Create "Concept Search" folder under Snowstorm
- [x] 7.2 Add "Search Concepts" GET request with term and limit parameters
- [x] 7.3 Add example search term (e.g., "diabetes")
- [x] 7.4 Add response validation test

## 8. Snowstorm requests - Concept Details

- [x] 8.1 Create "Concept Details" folder under Snowstorm
- [x] 8.2 Add "Get Concept Details" GET request with example concept ID (73211009)
- [x] 8.3 Add "Get Concept Descriptions" GET request
- [x] 8.4 Add "Get Concept Children" GET request with form parameter
- [x] 8.5 Add response validation tests

## 9. Create environment file

- [x] 9.1 Create Postman environment v2.1 JSON structure
- [x] 9.2 Set environment name to "FHIRLab Core - Localhost"
- [x] 9.3 Add fhir_base variable with value http://localhost:8080/fhir
- [x] 9.4 Add snowstorm_base variable with value http://localhost:8081
- [x] 9.5 Save as `FHIRLab-Core.postman_environment.json`

## 10. Update documentation

- [x] 10.1 Update docs/docs/reference/postman.md with import instructions
- [x] 10.2 Add reference to collection file path in repository
- [x] 10.3 Add reference to environment file path
- [x] 10.4 Update "Importing the Collection" section with file location

## 11. Validate and test

- [x] 11.1 Validate collection JSON structure (valid JSON, valid v2.1 schema)
- [x] 11.2 Import collection into Postman and verify it loads without errors
- [x] 11.3 Import environment and verify variables are set correctly
- [x] 11.4 Test at least one request from each folder to verify functionality
