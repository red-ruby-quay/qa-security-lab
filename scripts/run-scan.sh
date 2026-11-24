#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

mkdir -p reports
trap 'docker compose down -v' EXIT

echo "Starting OWASP Juice Shop..."
docker compose up -d juice-shop

echo "Waiting for Juice Shop on 127.0.0.1:3000..."
ready=0
for _ in $(seq 1 90); do
  if curl -fsS http://127.0.0.1:3000/ >/dev/null 2>&1; then
    ready=1
    break
  fi
  sleep 2
done

if [ "$ready" != "1" ]; then
  echo "Juice Shop did not become ready in time" >&2
  docker compose logs --tail=50 juice-shop >&2 || true
  exit 1
fi

echo "Running ZAP baseline scan..."
docker compose run --rm zap || true

if [ ! -s reports/zap-report.html ]; then
  echo "ZAP did not produce reports/zap-report.html" >&2
  exit 1
fi

echo "Reports written to $ROOT_DIR/reports"
