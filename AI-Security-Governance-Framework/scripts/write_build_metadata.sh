#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${1:-evidence}"
mkdir -p "$OUT_DIR"

TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
SHA="${GITHUB_SHA:-$(git rev-parse HEAD 2>/dev/null || echo "unknown")}"
RUN_ID="${GITHUB_RUN_ID:-unknown}"
RUN_NUMBER="${GITHUB_RUN_NUMBER:-unknown}"
WORKFLOW="${GITHUB_WORKFLOW:-unknown}"
REPO="${GITHUB_REPOSITORY:-unknown}"

cat > "$OUT_DIR/build-metadata.json" <<JSON
{
  "timestamp_utc": "$TS",
  "repo": "$REPO",
  "workflow": "$WORKFLOW",
  "run_id": "$RUN_ID",
  "run_number": "$RUN_NUMBER",
  "commit_sha": "$SHA"
}
JSON

echo "Wrote $OUT_DIR/build-metadata.json"
