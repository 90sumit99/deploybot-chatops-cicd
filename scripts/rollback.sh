#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib/common.sh"
previous="$(read_state previous)"; current="$(read_state current)"; [[ -n "$previous" ]] || die "no previous deployment exists"; docker image inspect "deploybot-app:$previous" >/dev/null || die "image deploybot-app:$previous does not exist"
ensure_network; export APP_VERSION="$previous" FAIL_HEALTH=false; docker compose -p deploybot -f docker-compose.yml up -d --force-recreate --remove-orphans; "$(dirname "$0")/healthcheck.sh" "$previous"; write_state current "$previous"; write_state previous "$current"; printf '%s ROLLBACK %s\n' "$(date -Iseconds)" "$previous" >> "$STATE_DIR/history.log"; log "Rollback successful"
