# DeployBot project report

## Abstract
DeployBot replaces manual local deployment with an auditable ChatOps pipeline.
## Introduction and problem
Manual release steps are slow and inconsistent; this project makes them repeatable.
## Objectives and tools
Node.js, Express, Docker, Jenkins JCasC, Telegram, Prometheus and Grafana implement tested, reversible releases.
## Architecture and implementation
L1 owns documentation, integration and the application/container; L2 owns Jenkins and rollback scripts; L3 owns the Telegram command client; L4 owns monitoring and the Kubernetes extension.
## Testing and results
See `TESTING.md`; insert screenshots of the required acceptance tests here.
## Security
Secrets remain in ignored `.env` files, chat IDs are allowlisted, and versions are validated at three boundaries.
## Limitations and future work
Use webhooks, dedicated agents, Kubernetes, Terraform/Ansible and Loki for production evolution.
## Conclusion
The result demonstrates CI, container delivery, observability and controlled rollback.
## References
Node.js, Express, Jenkins, Docker, Telegraf, Prometheus and Grafana official documentation.
