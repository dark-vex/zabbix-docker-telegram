# zabbix-docker-telegram
Rebuild Zabbix MySQL docker 7.0 Ubuntu image with required python libraries for sending notifications via Telegram:

https://github.com/ableev/Zabbix-in-Telegram

## Tags

Images are published to `ghcr.io/dark-vex/zabbix-server-mysql`:

| Tag | Meaning |
|---|---|
| `7.0.x` (e.g. `7.0.31`) | Built from that exact Zabbix release. Rebuilt weekly with the latest OS and Python fixes, so the digest can change |
| `7.0` | Latest build of the most recent 7.0.x release |
| `ubuntu-7.0` | Same as `7.0` |
| `latest` | Same as `7.0` |

Every tag is a multi-arch image for `linux/amd64` and `linux/arm64`. Both platforms are scanned with Wiz before any tag is published.

Pin a digest (`ghcr.io/dark-vex/zabbix-server-mysql@sha256:...`) for fully reproducible deployments.

## Usage

The image is a drop-in replacement for `zabbix/zabbix-server-mysql:ubuntu-7.0-latest` and accepts the same environment variables. Put the [Zabbix-in-Telegram](https://github.com/ableev/Zabbix-in-Telegram) scripts (`zbxtg.py`, `zbxtg_settings.py` and, if needed, `zbxtg_group.py`) in a local `alertscripts` directory and mount it on the server `AlertScriptsPath` (`/usr/lib/zabbix/alertscripts`):

```yaml
services:
  zabbix-server:
    image: ghcr.io/dark-vex/zabbix-server-mysql:7.0
    environment:
      DB_SERVER_HOST: mysql
      MYSQL_USER: zabbix
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
      MYSQL_DATABASE: zabbix
    volumes:
      - ./alertscripts:/usr/lib/zabbix/alertscripts:ro
    ports:
      - "10051:10051"
```

The scripts run as the `zabbix` user (UID 1997), so make them readable and executable by it. `python` inside the container points to a virtual environment with the required libraries (`requests`, `PySocks`); then configure the media type in Zabbix as described in the Zabbix-in-Telegram README.

## Verify the image

Images are signed with [cosign](https://github.com/sigstore/cosign) keyless signing from the `build.yaml` workflow on `main`:

```sh
cosign verify ghcr.io/dark-vex/zabbix-server-mysql:latest \
  --certificate-identity https://github.com/dark-vex/zabbix-docker-telegram/.github/workflows/build.yaml@refs/heads/main \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```

Each image also carries SLSA build provenance, verifiable with the GitHub CLI:

```sh
gh attestation verify oci://ghcr.io/dark-vex/zabbix-server-mysql:latest --repo dark-vex/zabbix-docker-telegram
```

An SPDX SBOM is attested for each platform image. Get the platform digest and verify it:

```sh
docker buildx imagetools inspect ghcr.io/dark-vex/zabbix-server-mysql:latest
gh attestation verify oci://ghcr.io/dark-vex/zabbix-server-mysql@sha256:<platform digest> \
  --repo dark-vex/zabbix-docker-telegram --predicate-type https://spdx.dev/Document/v2.3
```
