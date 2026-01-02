# CI Evidence Output (Artifacts + Evidence Folder)

This repo implements an evidence-first CI pattern:
1) Each job writes outputs to an `evidence/` folder
2) CI uploads those outputs as downloadable workflow artifacts

## What gets written to evidence/
- `evidence/build-metadata.json`
- `evidence/terraform/` logs and optional plan output
- `evidence/iac-scan/` checkov JSON and tfsec pattern output
- `evidence/redteam/` SLXP report copy and gate logs
- `evidence/policies/` policy copy + checksum

## Enterprise upgrade ideas
- Sign artifacts (cosign / sigstore)
- Publish evidence to immutable storage (S3 Object Lock)
- Attach evidence to change requests (ITSM integration)
