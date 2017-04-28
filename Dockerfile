FROM armhf/ubuntu:latest

ENV TERM="xterm"
ENV PB_VERSION="2.3.6"
ENV HOMEDIR="/PhantomBot"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
  openjdk-8-jre-headless \
  unzip \
  curl \
  wget \
  && apt-get clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/*

RUN mkdir -p /PhantomBot /scripts

WORKDIR /PhantomBot

COPY ./botlogin.txt /
COPY ./entrypoint.sh /

RUN chmod 755 /entrypoint.sh

EXPOSE 25003-25005
VOLUME /PhantomBot
ENTRYPOINT ["/entrypoint.sh"]
