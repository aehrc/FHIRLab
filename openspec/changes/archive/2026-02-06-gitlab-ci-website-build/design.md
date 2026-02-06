## Context

Current state: The documentation is built using MkDocs with Material theme. The docs source is in `docs/` directory and can be built locally with `mkdocs build`. There's currently no CI/CD automation for building or deploying the documentation.

This is a GitLab repository, so GitLab CI/CD is the natural choice for automation. The built site needs to be archived as an artifact for potential deployment to GitLab Pages or other hosting services.

## Goals / Non-Goals

**Goals:**
- Automatically build the documentation website on every commit
- Archive the built static site as a GitLab CI artifact
- Install all required dependencies (MkDocs, plugins, Material theme)
- Make the artifact easily downloadable for manual deployment or inspection
- Keep the build fast and reliable

**Non-Goals:**
- Not automatically deploying to a hosting service (just archiving)
- Not setting up GitLab Pages (can be added later)
- Not testing documentation (spell check, link validation, etc.) - focus on build only
- Not building documentation for multiple branches (just main/default branch)

## Decisions

### Decision 1: Use Python Docker image as base

**Rationale**: Use `python:3.11` or similar official Python image as the CI job base.

**Why**: MkDocs is a Python tool. Using the official Python image ensures all dependencies are available and provides a clean, reproducible build environment.

**Alternatives considered**:
- Alpine-based image → Rejected: May have dependency issues, not worth the size savings for CI
- Custom Docker image → Rejected: Overkill for a simple MkDocs build

### Decision 2: Install dependencies via pip in CI job

**Rationale**: Use `pip install mkdocs mkdocs-material mkdocs-minify-plugin` directly in the CI script.

**Why**: Simple and explicit. All dependencies are visible in the CI config. No need for a requirements.txt just for CI.

**Alternatives considered**:
- Create requirements.txt → Rejected: Adds maintenance overhead when it's just 3 packages
- Pre-built Docker image with MkDocs → Rejected: Unnecessary complexity

### Decision 3: Build to `docs/site` and archive entire directory

**Rationale**: Run `mkdocs build` from the `docs/` directory, which creates `docs/site/`. Archive `docs/site/` as the artifact.

**Why**: Default MkDocs behavior. The `site/` directory contains the complete static website ready for serving.

### Decision 4: Set artifact expiration to 30 days

**Rationale**: Keep artifacts for 30 days to balance storage costs with usefulness.

**Why**: Recent builds are most relevant. 30 days provides enough history for debugging or manual deployment without accumulating too much storage.

### Decision 5: Run build job on every push

**Rationale**: No branch restrictions initially - build on every push to verify docs are always buildable.

**Why**: Catches documentation build errors immediately. Fast feedback loop for contributors.

## Risks / Trade-offs

**Risk**: Build breaks if MkDocs or plugins change behavior  
→ **Mitigation**: Pin versions in CI config (e.g., `mkdocs==1.6.1`). Update deliberately when needed.

**Risk**: CI job uses unnecessary resources on every commit  
→ **Accept**: Documentation builds are fast (~10-30 seconds). Cost is negligible for valuable automation.

**Trade-off**: No deployment automation vs. keeping CI simple  
→ **Accept**: Archive-only approach keeps this change focused. Deployment can be added separately based on hosting needs.

**Risk**: Artifact storage accumulates over time  
→ **Mitigation**: 30-day expiration prevents unbounded growth. Can be adjusted if needed.
