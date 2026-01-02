#!/usr/bin/env bash
set -euo pipefail

if ! command -v tfsec >/dev/null 2>&1; then
  echo "tfsec is not installed."
  echo "Install (macOS): brew install tfsec"
  echo "Or see: https://aquasecurity.github.io/tfsec/"
  exit 1
fi

echo "Running tfsec against Terraform..."
tfsec deployments/terraform
