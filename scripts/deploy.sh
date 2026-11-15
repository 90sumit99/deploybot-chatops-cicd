#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib/common.sh"
version="${1:?usage: deploy.sh <version> [simulate_failure]}"; simulate="${2:-false}"; validate_version "$version"; ensure_network
docker image inspect "deploybot-app:$version" >/dev/null || die "image deploybot-app:$version does not exist"
old="$(read_state current)"; export APP_VERSION="$version"; export FAIL_HEALTH="$simulate"
log "Deploying $version"; docker compose -p deploybot -f docker-compose.yml up -d --force-recreate --remove-orphans
if "$(dirname "$0")/healthcheck.sh" "$version"; then
  [[ -n "$old" && "$old" != "$version" ]] && write_state previous "$old"; write_state current "$version"; printf '%s DEPLOY %s\n' "$(date -Iseconds)" "$version" >> "$STATE_DIR/history.log"; log "Deployment successful"; exit 0
fi
log "Deployment failed"; if [[ -n "$old" ]]; then export APP_VERSION="$old" FAIL_HEALTH=false; docker compose -p deploybot -f docker-compose.yml up -d --force-recreate --remove-orphans; "$(dirname "$0")/healthcheck.sh" "$old"; printf '%s AUTO_ROLLBACK %s\n' "$(date -Iseconds)" "$old" >> "$STATE_DIR/history.log"; fi
[[ -n "$old" ]] || docker compose -p deploybot -f docker-compose.yml down; exit 1
