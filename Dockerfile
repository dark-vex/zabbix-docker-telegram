ARG ZBX_IMAGE=zabbix/zabbix-server-mysql:ubuntu-7.0-latest
FROM ${ZBX_IMAGE}

USER root

COPY ./requirements.txt /tmp/requirements.txt

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y \
            --no-install-recommends install \
            python3 python3-venv && \
            apt-get -y clean && \
            rm -rf /var/lib/apt/lists/* && \
            python3 -m venv /opt/venv && \
            printf '#!/bin/sh\nexec /opt/venv/bin/python "$@"\n' > /usr/bin/python && \
            chmod 0755 /usr/bin/python && \
            /opt/venv/bin/pip install --no-cache-dir --require-hashes -r /tmp/requirements.txt && \
            rm /tmp/requirements.txt

ENV PATH="/opt/venv/bin:${PATH}"

USER 1997
