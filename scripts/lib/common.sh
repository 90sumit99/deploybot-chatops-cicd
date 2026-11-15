#!/usr/bin/env bash
set -euo pipefail
STATE_DIR="${STATE_DIR:-/var/jenkins_home/deploy-state}"
log(){ printf '%s %s\n' "$(date -Iseconds)" "$*"; }
die(){ log "ERROR: $*"; exit 1; }
validate_version(){ [[ "${1:-}" =~ ^v[0-9]+(\.[0-9]+){0,2}$ ]] || die "invalid version: ${1:-}"; }
read_state(){ [[ -f "$STATE_DIR/$1" ]] && cat "$STATE_DIR/$1" || true; }
write_state(){ mkdir -p "$STATE_DIR"; printf '%s\n' "$2" > "$STATE_DIR/$1"; }
ensure_network(){ docker network inspect deploybot-net >/dev/null 2>&1 || docker network create deploybot-net >/dev/null; }
