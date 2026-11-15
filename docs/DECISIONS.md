# Decisions

- Added `dotenv` because it is needed to load the bot `.env` file; all other runtime dependencies are specified in the PRD.
- Metrics are enabled in the app at P1 so Prometheus works without a second application build.
- The P2 Trivy stage is documented as optional and is not enabled by default to avoid a network dependency during a demo.
