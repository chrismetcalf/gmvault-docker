FROM ubuntu:latest
LABEL org.freenas.autostart="false"       \
  org.freenas.interactive="false"         \
  org.freenas.version="Latest"            \
  org.freenas.upgradeable="true"          \
  org.freenas.volumes="[                  \
    {                                     \
      \"name\": \"/data\",                \
      \"descr\": \"Data storage space\"   \
    }                                     \
  ]"

ENV GMVAULT_DIR /data
ENV GMVAULT_EMAIL_ADDR test@example.com

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y python-pip
RUN pip install --upgrade pip \
    && pip install gmvault

VOLUME /data

RUN mkdir /app
COPY gmvault.sh /app/gmvault.sh
RUN adduser --system abc --shell /bin/bash

WORKDIR /app

CMD ["/app/gmvault.sh"]
