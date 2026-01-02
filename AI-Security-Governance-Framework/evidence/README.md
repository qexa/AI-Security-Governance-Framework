# Evidence Artifacts

This folder is used by CI to store **audit-friendly evidence artifacts** generated during builds.

In GitHub Actions, artifacts are also uploaded automatically via `actions/upload-artifact`.
You can download them from the workflow run page under **Artifacts**.

## Typical artifacts produced
- Terraform validation logs and (optional) `terraform plan` outputs
- IaC scan outputs (checkov / tfsec), JSON where possible
- Adversarial scan outputs (SLXP report JSON)
- Guardrail policy files + checksums
- Build metadata (commit SHA, workflow run IDs, timestamps)

## Why this matters
Enterprises often fail audits not because controls are missing, but because evidence is missing.
This repo demonstrates a repeatable pattern for collecting evidence automatically.
