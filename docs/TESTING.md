# Testing traceability

| Requirement | Test |
|---|---|
| FR-A1–A4 | `cd app && npm ci && npm test`; inspect health, version, page and 404. |
| FR-J1–J5 | `docker compose -f jenkins/docker-compose.yml config`, start Jenkins and run CI/deploy/rollback. |
| FR-B1–B9 | `cd bot && npm ci && npm test`; test authorised and malicious Telegram commands. |
| P1 rollback | Deploy `v3` with simulated failure; verify prior version remains live. |
| Persistence | Restart Docker, then confirm Jenkins state and image tags persist. |
