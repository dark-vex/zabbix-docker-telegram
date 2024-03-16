FROM zabbix/zabbix-server-mysql:ubuntu-6.0-latest

USER root

RUN DEBIAN_FRONTEND=noninteractive apt update && apt-get -y \
            --no-install-recommends install \
            python3 python3-pip && \
            apt-get -y clean && \
            rm -rf /var/lib/apt/lists/* && \
            ln -s /usr/bin/python3.8 /usr/bin/python

USER 1997

COPY ./requirements.txt /tmp/

RUN pip3 install -r /tmp/requirements.txt
