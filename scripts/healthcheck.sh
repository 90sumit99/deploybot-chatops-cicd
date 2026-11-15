#!/usr/bin/env bash
set -euo pipefail
expected="${1:?usage: healthcheck.sh <expected_version> [base_url]}"; base="${2:-http://deploybot-app:3000}"; retries="${HEALTH_RETRIES:-20}"; interval="${HEALTH_INTERVAL:-3}"
for ((i=1;i<=retries;i++)); do
  health="$(curl -fsS "$base/health" 2>/dev/null || true)"; version="$(curl -fsS "$base/version" 2>/dev/null || true)"
  if [[ "$health" == *'"status":"ok"'* && "$health" == *"\"version\":\"$expected\""* && "$version" == *"\"version\":\"$expected\""* ]]; then echo "Health check passed for $expected"; exit 0; fi
  echo "Health check attempt $i/$retries failed"; sleep "$interval"
done
echo "Health check failed for $expected" >&2; exit 1
