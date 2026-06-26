# Maintaining FHIRLab Core

## Repository Relationship

This GitLab repository (`core-website`) is the **canonical development source**.

The public-facing repository is **https://github.com/aehrc/FHIRLab** and is reconciled by hand from this source. The project's convention is that GitHub is the visible home for all end-user content — issues, clone URLs, and contributing links all point there.

## URL Convention for Content Files

All user-facing content (README, docs, quick-start) must reference GitHub, not this repository:

| Purpose | URL to use |
|---------|-----------|
| Clone | `https://github.com/aehrc/FHIRLab.git` |
| Issues | `https://github.com/aehrc/FHIRLab/issues` |
| Repo link | `https://github.com/aehrc/FHIRLab` |

Do not include references to this GitLab repository or the GitLab Pages URL in any file that is reconciled to GitHub.

## Reconciliation Process

Changes made here must be manually applied to the GitHub downstream. When committing content changes to `main`:

1. Commit to this repo as normal
2. Apply the same file changes to `aehrc/FHIRLab` on GitHub (`master` branch)
3. Use the GitLab commit short-ID in the GitHub commit message (e.g. `Mirror of GitLab commit abc1234`)

Operational files that should **not** be reconciled to GitHub (they are GitLab-specific):
- `MAINTAINING.md` (this file)
- `.gitlab-ci.yml`
- `.claude/`

## CI/CD

There is no active CI/CD pipeline. Documentation is plain Markdown browsable directly on GitHub; MkDocs infrastructure has been removed.
