# Jenkins controller

Copy `.env.example` to `.env`, set a strong local password and the repository URL, then run:

`docker compose -f jenkins/docker-compose.yml --env-file jenkins/.env up -d --build`

Open http://localhost:8080 and sign in. Create an API token from the user menu → Security → Add new Token. Run **Build with Parameters** using `ACTION=DEPLOY`, `VERSION=v1`. Reset the local controller with `docker compose -f jenkins/docker-compose.yml down -v`.

The Docker socket is deliberately mounted for this classroom demo; it grants effectively root-equivalent host access.
