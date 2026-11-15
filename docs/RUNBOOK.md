# Clean-laptop runbook

1. Install Git, Docker Desktop with Compose v2, and Node 22; clone the repository.
2. Copy `jenkins/.env.example` to `jenkins/.env`; set password and `REPO_URL`.
3. Run `docker compose -f jenkins/docker-compose.yml --env-file jenkins/.env up -d --build`.
4. Sign in at http://localhost:8080, create an API token, and build `DEPLOY v1`.
5. Confirm http://localhost:8081, then copy `bot/.env.example` to `bot/.env`, fill values, run `cd bot; npm ci; npm start`.
6. Send `/whoami`, add its ID to `ALLOWED_CHAT_IDS`, restart bot, then use `/status`.
7. Optional monitoring: `docker compose -f monitoring/docker-compose.monitoring.yml up -d`.

| Problem | Fix |
|---|---|
| Docker permission denied | Check socket mount and `user: root`. |
| App name cannot resolve | Ensure Jenkins and app use `deploybot-net`. |
| Jenkins 401 | Use an API token, not password. |
| CRLF shell error | Re-normalise using `.gitattributes`. |
| Telegram conflict | Stop another bot process. |
