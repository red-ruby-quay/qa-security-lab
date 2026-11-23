#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

mkdir -p reports
trap 'docker compose down -v' EXIT

echo "Starting OWASP Juice Shop and the ZAP baseline scan..."
docker compose run --rm zap || true

if [ ! -s reports/zap-report.html ]; then
  echo "ZAP did not produce reports/zap-report.html" >&2
  exit 1
fi

echo "Reports written to $ROOT_DIR/reports"
