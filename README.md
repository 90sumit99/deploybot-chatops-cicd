# DeployBot

DeployBot is a ChatOps CI/CD capstone: an authorised Telegram command starts Jenkins, which tests, builds, deploys and health-checks a versioned Docker image. Failed deployments roll back automatically.

```
Telegram → Node bot → Jenkins → Docker → deploybot-app
                         ↘ Prometheus/Grafana
```

Start with [the runbook](docs/RUNBOOK.md). Commands: `/deploy v2`, `/deploy v3 broken`, `/rollback`, `/status`, `/history`, `/logs`, `/whoami`, `/help`.

| Laptop | Member | Ownership |
|---|---|---|
| L1 | <MEMBER_1_NAME> | leadership, documentation, app and Docker deployment |
| L2 | <MEMBER_2_NAME> | Jenkins pipeline and deployment scripts |
| L3 | <MEMBER_3_NAME> | Telegram ChatOps bot |
| L4 | <MEMBER_4_NAME> | monitoring and Kubernetes extension |

Take screenshots of Jenkins stages, v1/v2 page, Telegram results, rollback, Grafana and GitHub PRs.
