# Security Policy

## Supported versions

Only the latest published image is supported:

| Image | Supported |
|---|---|
| `ghcr.io/dark-vex/zabbix-server-mysql:latest`, `:7.0`, `:ubuntu-7.0` and the most recent `:7.0.x` | Yes |
| Older `:7.0.x` tags | No, please upgrade |

The image is rebuilt weekly and whenever the Zabbix base image, the Python dependencies or the Dockerfile change.

## Reporting a vulnerability

Please do **not** open a public issue for security problems.

Report vulnerabilities privately through GitHub:
[Security → Report a vulnerability](https://github.com/dark-vex/zabbix-docker-telegram/security/advisories/new).

Include the affected image tag or digest, a description of the issue and, if possible, steps to reproduce. You should receive an answer within 7 days.

Vulnerabilities in the upstream Zabbix image or in [Zabbix-in-Telegram](https://github.com/ableev/Zabbix-in-Telegram) should also be reported to their respective projects.

## Verifying images

Every published image is signed with cosign (keyless) and carries SLSA build provenance and an SPDX SBOM attestation. See the README for the verification commands.
