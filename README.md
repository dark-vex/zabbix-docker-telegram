# zabbix-docker-telegram
Rebuild Zabbix MySQL docker 7.0 Ubuntu image with required python libraries for sending notifications via Telegram:

https://github.com/ableev/Zabbix-in-Telegram

## Verify the image

Images are signed with [cosign](https://github.com/sigstore/cosign) keyless signing from the `build.yaml` workflow on `main`:

```sh
cosign verify ghcr.io/dark-vex/zabbix-server-mysql:latest \
  --certificate-identity https://github.com/dark-vex/zabbix-docker-telegram/.github/workflows/build.yaml@refs/heads/main \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```
