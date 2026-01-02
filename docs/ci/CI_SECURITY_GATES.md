# CI Security Gates (Enterprise Pattern)

This repo demonstrates CI gates for AI security using two classes of controls:

1) Infrastructure-as-Code (IaC) validation and drift signals
2) Adversarial AI testing (prompt injection, sensitive data leakage, RAG poisoning patterns)

## Terraform Validate + Drift Signals
- Terraform fmt/validate runs against the drift-demo config
- Drift signals intentionally detect insecure patterns (public S3 policy, missing encryption)

## Adversarial Report Gate (SLXP-style)
- CI validates a SLXP-style JSON report
- CI gates on severity thresholds (CRITICAL fails)

## Evidence-First Outputs
Each CI run writes logs/reports to `evidence/` and uploads them as artifacts.
See `docs/ci/CI_EVIDENCE_ARTIFACTS.md`.
