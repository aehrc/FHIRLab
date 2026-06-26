# Troubleshooting

Solutions for common issues with FHIRLab Core.

## Startup Issues

### Port Already in Use

**Error:** `Bind for 0.0.0.0:8080 failed: port is already allocated`

**Solution:**

1. Find what's using the port:
   ```bash
   # Linux/macOS
   lsof -i :8080

   # Windows
   netstat -ano | findstr :8080
   ```

2. Either stop the conflicting service, or change the port in `.env`:
   ```bash
   HAPI_FHIR_PORT=9080
   ```

---

### Out of Memory

**Symptoms:**

- Containers keep restarting
- `docker logs` shows `OutOfMemoryError`
- System becomes unresponsive

**Solution:**

1. Check available memory:
   ```bash
   docker stats
   ```

2. Reduce memory allocation in `.env`:
   ```bash
   ES_HEAP_SIZE=1g
   ES_MEMORY=1g
   SNOWSTORM_MAX_HEAP=1g
   ```

3. Stop unused applications on your system

---

### Containers Won't Start

**Check the logs:**

```bash
docker compose logs --tail 50
```

**Common causes:**

| Log Message | Solution |
|-------------|----------|
| `No space left on device` | Clear Docker storage: `docker system prune` |
| `Permission denied` | Check file permissions, run with correct user |
| `Network error` | Restart Docker daemon |

---

### Snowstorm Takes Forever to Start

**Expected:** Snowstorm can take 2-5 minutes to fully initialize.

**If it never starts:**

1. Check Elasticsearch is healthy first:
   ```bash
   curl http://localhost:9200/_cluster/health
   ```

2. Check Snowstorm logs:
   ```bash
   docker compose logs snowstorm --tail 100
   ```

3. Ensure sufficient memory is allocated

## Runtime Issues

### HAPI FHIR Returns 500 Errors

**Check the logs:**

```bash
docker compose logs hapi-fhir --tail 100
```

**Common causes:**

- Database corruption (try reset.sh)
- Invalid FHIR resources being submitted
- Memory pressure

---

### Snowstorm Search Returns No Results

**If SNOMED content wasn't loaded:**

1. Snowstorm works without content but returns empty results
2. Load SNOMED CT RF2 files (requires license)
3. See [SNOMED Browser Guide](guide/snomed-browser.md)

---

### Cannot Connect to Services

**Verify services are running:**

```bash
docker compose ps
```

**Check network connectivity:**

```bash
curl -v http://localhost:8080/fhir/metadata
```

**Firewall issues:**

- Ensure Docker ports aren't blocked
- On Linux, check `iptables` or `firewalld`
- On Windows, check Windows Firewall

## Data Issues

### Lost Data After Restart

**Data should persist.** If it didn't:

1. Check you didn't run `reset.sh`
2. Verify volumes exist:
   ```bash
   docker volume ls | grep fhirlab
   ```
3. Ensure you're using `stop.sh`, not `docker compose down -v`

---

### Cannot Delete Resources

**HAPI FHIR requires explicit delete permission:**

This is enabled by default in FHIRLab Core. If you've customized:

```bash
# Check configuration
docker compose exec hapi-fhir env | grep DELETE
```

---

### Database Corrupted

**Symptoms:**

- Startup failures mentioning database
- Missing data after restart
- Inconsistent query results

**Solution:**

```bash
./scripts/reset.sh
./scripts/start.sh
./scripts/load-data.sh  # Reload example data
```

## Performance Issues

### Slow Queries

**For large datasets:**

1. Add search parameters to narrow results:
   ```bash
   # Instead of
   curl http://localhost:8080/fhir/Observation

   # Use
   curl "http://localhost:8080/fhir/Observation?subject=Patient/123&_count=100"
   ```

2. Increase memory allocation
3. Consider this is a learning environment, not production

---

### High CPU Usage

**Check which container:**

```bash
docker stats
```

**Common causes:**

- Elasticsearch indexing (temporary)
- Large data import
- Insufficient memory causing swapping

## Getting Help

### Collect Diagnostic Information

```bash
# System info
docker version
docker compose version

# Container status
docker compose ps

# Recent logs
docker compose logs --tail 100 > fhirlab-logs.txt
```

### Where to Get Help

1. Check this troubleshooting guide
2. Review [Upstream Documentation](resources/upstream.md)
3. Search existing issues on GitHub
4. Open a new issue with diagnostic information

## Quick Fixes

### Full Reset

When all else fails:

```bash
./scripts/reset.sh --force
docker system prune -a  # Caution: removes ALL Docker data
./scripts/start.sh
```

### Restart Docker

Sometimes Docker itself needs a restart:

```bash
# macOS/Windows: Restart Docker Desktop

# Linux
sudo systemctl restart docker
```
