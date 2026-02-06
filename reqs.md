"Scope for core includes: 

1. HAPI FHIR (R4)
2. Snowstorm (to avoid lisencing issues)
3. Optional: basic SMART on FHIR (learning read-only demonstration only)

Setup ideally must be using:
Docker; Docker compose and simple shell scripts
example env files
clear defaults for learning
script to load baseline data
scripts to reset

Documentation
-How to start (env)
-How to reset
-How to stop
-How to load data
-How to use Postman Collection using core

Success Metric: 
FHIRLab Core can be cloned, started, reset, and stopped in their own environment by regional user/teams with basic technical skills, without ongoing DevOps support.

Guiding Principle: FHIRLab self-deployments by external parties will rely on simple, transparent, container-based approaches (e.g. basic Docker images) sufficient for a learning sandbox, rather than production-grade operational automation."