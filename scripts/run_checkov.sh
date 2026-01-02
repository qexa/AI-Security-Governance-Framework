#!/usr/bin/env bash
set -euo pipefail

if ! command -v checkov >/dev/null 2>&1; then
  echo "checkov is not installed."
  echo "Install: pip install checkov"
  exit 1
fi

echo "Running checkov against Terraform..."
checkov -d deployments/terraform --quiet
