# Architecture

Telegram long polling avoids a public webhook URL. The bot validates the version and calls Jenkins using an API token. Jenkins checks out `main`, tests inside a Docker build, tags the runtime image, and runs scripts that record `current` and `previous` state. Jenkins and the app share `deploybot-net`, allowing health checks by container name.

The Docker socket mount and root Jenkins process are intentionally demo-only: socket access is effectively root on the host. Production should use a dedicated agent or rootless Docker.
