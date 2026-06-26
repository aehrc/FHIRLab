# FormLab

## Overview

FormLab is a comprehensive SMART-on-FHIR learning environment that provides hands-on experience with healthcare forms, questionnaires, and SMART application launch sequences. It goes beyond basic SMART authentication to demonstrate real-world clinical workflows using Structured Data Capture (SDC) questionnaires.

FormLab is developed and maintained by the Australian e-Health Research Centre (AEHRC).

**Reference:** [FormLab GitLab Repository](https://gitlab.com/australian-e-health-research-centre/form-lab)

## What FormLab Provides

FormLab includes a complete stack of services:

- **Interactive Homepage** - Documentation and overview of the environment
- **SMART Launcher UI** - Web-based interface for launching SMART applications
- **Forms Application** - SDC questionnaire renderer and form management tool
- **HAPI FHIR Server** - Dedicated FHIR R4 server pre-loaded with sample data
- **PostgreSQL Database** - Persistent storage for FHIR resources
- **Sample Data Loader** - Automatically populates the FHIR server with example patients, questionnaires, and clinical data

## Why Use FormLab?

- **Learn SMART on FHIR** - Experience the complete SMART launch workflow in a realistic setting
- **Explore SDC Questionnaires** - Work with healthcare forms and structured data capture
- **Practice with Sample Data** - Pre-loaded clinical scenarios for immediate experimentation
- **Understand Integration** - See how SMART apps, FHIR servers, and forms work together
- **No Configuration Required** - Everything is pre-configured and ready to use

## Setup

### Prerequisites

- FHIRLab Core installed (see [Quick Start](quick-start.md))
- At least 2GB additional RAM available
- Ports 8084-8088 available on your system

### Enable FormLab

FormLab is enabled using Docker Compose profiles:

```bash
cd docker
docker compose --profile formlab up -d
```

This starts all FormLab services in the background. Initial startup may take 2-3 minutes as services initialize and sample data is loaded.

### Verify FormLab is Running

Check that all services are healthy:

```bash
docker compose ps
```

You should see FormLab services listed with status "Up" or "healthy":
- `fhirlab-formlab-homepage`
- `fhirlab-formlab-launcher`
- `fhirlab-formlab-proxy`
- `fhirlab-formlab-forms`
- `fhirlab-formlab-fhir`
- `fhirlab-formlab-db`

### Access FormLab

Open your web browser and navigate to:

**http://localhost:8084**

This opens the FormLab homepage with links to all components and documentation.

## Usage

### Basic Workflow

1. **Start at the Homepage** (http://localhost:8084)
   - Review the overview and available components
   - Access documentation and guides

2. **Launch a SMART Application** (http://localhost:8085)
   - Select a patient from the launcher
   - Choose the Forms Application
   - Click "Launch" to initiate the SMART sequence

3. **Work with Forms** (http://localhost:8087)
   - Browse available questionnaires
   - Fill out forms with patient data
   - Submit QuestionnaireResponse resources to the FHIR server

4. **Query FHIR Resources** (http://localhost:8088/fhir)
   - Access the dedicated FormLab FHIR server
   - Query for Patients, Questionnaires, QuestionnaireResponses
   - Explore the sample data

### Component URLs

| Component | URL | Purpose |
|-----------|-----|---------|
| **Homepage** | http://localhost:8084 | Documentation and entry point |
| **SMART Launcher** | http://localhost:8085 | Launch SMART applications |
| **SMART Proxy** | http://localhost:8086 | SMART authentication proxy |
| **Forms Application** | http://localhost:8087 | SDC questionnaire renderer |
| **FHIR Server** | http://localhost:8088/fhir | Dedicated FHIR R4 API |

### Integration with Core Services

FormLab runs as a **standalone environment** with its own FHIR server and database, separate from the core HAPI FHIR service. This design allows you to:

- Experiment with FormLab without affecting core FHIRLab data
- Compare different FHIR server setups
- Learn how complete healthcare IT stacks are architected
- Reset FormLab data independently

If you want to connect FormLab to the core HAPI FHIR server instead, see [Advanced Configuration](#advanced-configuration).

### Combining with Other Profiles

You can run FormLab alongside other optional services:

```bash
# Run FormLab and basic SMART launcher together
docker compose --profile formlab --profile smart up -d
```

## Configuration

FormLab configuration can be customized in `docker/.env`:

```bash
# FormLab Ports
FORMLAB_PORT=8084                 # Homepage
FORMLAB_LAUNCHER_PORT=8085        # SMART Launcher UI
FORMLAB_PROXY_PORT=8086           # SMART Proxy
FORMLAB_FORMS_PORT=8087           # Forms Application
FORMLAB_FHIR_PORT=8088            # FHIR Server

# FormLab Database
FORMLAB_DB_USER=admin
FORMLAB_DB_PASSWORD=admin
FORMLAB_DB_NAME=hapi
```

### Port Conflicts

If you have services already using these ports, modify the environment variables:

```bash
# Example: Move FormLab to higher port range
FORMLAB_PORT=9000
FORMLAB_LAUNCHER_PORT=9001
FORMLAB_PROXY_PORT=9002
FORMLAB_FORMS_PORT=9003
FORMLAB_FHIR_PORT=9004
```

After changing ports, restart the services:

```bash
docker compose --profile formlab down
docker compose --profile formlab up -d
```

## Troubleshooting

### FormLab Services Won't Start

**Symptom:** Services fail to start or exit immediately

**Solutions:**
1. Check port availability:
   ```bash
   # On Linux/Mac
   lsof -i :8084
   lsof -i :8085
   # etc.
   ```

2. Check Docker resources:
   - Ensure at least 6GB RAM total (4GB for core + 2GB for FormLab)
   - Increase Docker memory allocation if needed

3. View service logs:
   ```bash
   docker compose logs formlab-homepage
   docker compose logs formlab-fhir
   ```

### Cannot Connect to FormLab Services

**Symptom:** Browser shows "connection refused" or "cannot connect"

**Solutions:**
1. Verify services are running:
   ```bash
   docker compose ps | grep formlab
   ```

2. Check service health:
   ```bash
   docker compose logs formlab-homepage
   ```

3. Ensure you're using the correct URL (http://localhost:8084, not https)

4. Try accessing the FHIR server directly:
   ```bash
   curl http://localhost:8088/fhir/metadata
   ```

### Sample Data Not Loading

**Symptom:** FHIR server is empty, no patients or questionnaires

**Solutions:**
1. Check if the sample data loader ran:
   ```bash
   docker compose logs formlab-samples
   ```

2. The sample loader runs once on startup. If it failed, restart it:
   ```bash
   docker compose --profile formlab down
   docker compose --profile formlab up -d
   ```

3. Wait 2-3 minutes for all services to fully initialize

### FormLab FHIR Server Connection Issues

**Symptom:** Forms app cannot connect to FHIR server

**Solutions:**
1. Verify FHIR server is accessible:
   ```bash
   curl http://localhost:8088/fhir/metadata
   ```

2. Check proxy configuration:
   ```bash
   docker compose logs formlab-proxy
   ```

3. Ensure all services are on the same Docker network:
   ```bash
   docker network inspect fhirlab-network
   ```

### Database Errors

**Symptom:** FHIR server shows database connection errors

**Solutions:**
1. Check PostgreSQL is running:
   ```bash
   docker compose logs formlab-db
   ```

2. Reset the database:
   ```bash
   docker compose down -v
   docker compose --profile formlab up -d
   ```

3. Verify database credentials in `.env` match configuration

## Stopping FormLab

To stop FormLab services while keeping core services running:

```bash
docker compose --profile formlab down
```

To stop all services:

```bash
docker compose down
```

## Resetting FormLab Data

To completely reset FormLab and start fresh:

```bash
# Stop and remove all volumes
docker compose --profile formlab down -v

# Start again
docker compose --profile formlab up -d
```

This removes all FormLab data including the PostgreSQL database. Sample data will be reloaded automatically.

## Advanced Configuration

### Connecting FormLab to Core HAPI FHIR

By default, FormLab uses its own FHIR server. To connect FormLab forms to the core HAPI FHIR server:

1. Modify `docker/docker-compose.yml` in the `formlab-proxy` service:
   ```yaml
   environment:
     - FHIR_SERVER_R4=http://hapi-fhir:8080/fhir
   ```

2. Update the `formlab-ehr-config` to point to the core FHIR server

3. Restart FormLab:
   ```bash
   docker compose --profile formlab down
   docker compose --profile formlab up -d
   ```

**Note:** This configuration is not officially supported and may require additional adjustments.

## Learning Resources

- [FormLab GitLab Repository](https://gitlab.com/australian-e-health-research-centre/form-lab) - Source code and documentation
- [SMART on FHIR](https://docs.smarthealthit.org/) - Official SMART specification
- [HL7 SDC Implementation Guide](http://hl7.org/fhir/uv/sdc/) - Structured Data Capture standard
- [SMART Forms Documentation](https://github.com/aehrc/smart-forms) - Forms application details

## Next Steps

- Explore sample questionnaires and patient data
- Experiment with creating custom questionnaires
- Practice the SMART launch sequence with different patients
- Query FormLab's FHIR server using Postman or code
- Compare FormLab's architecture with core FHIRLab services
