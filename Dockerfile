FROM alpine:3.11
MAINTAINER Jee <jee@jeer.fr>

ENV CHROMAPRINT_VER=1.5.0

RUN set -x && \
    apk update && \
    apk upgrade && \
# Chromaprint #
    apk add --no-cache \
      wget \
      tar \
      xz \
      shadow \
      binutils && \
    cd /tmp && \
    wget https://github.com/acoustid/chromaprint/releases/download/v${CHROMAPRINT_VER}/chromaprint-fpcalc-${CHROMAPRINT_VER}-linux-x86_64.tar.gz && \
    tar xvf chromaprint-fpcalc-$CHROMAPRINT_VER-linux-x86_64.tar.gz && \
    mv chromaprint-fpcalc-$CHROMAPRINT_VER-linux-x86_64/fpcalc /usr/local/bin && \
    strip -s /usr/local/bin/fpcalc && \
    apk del --no-cache \
      wget \
      tar \
      xz \
      binutils && \
    apk add --no-cache \
      mpd \
      mpc && \
    rm -rf /tmp/* \
      /var/cache/apk/*

EXPOSE 8000 6600

COPY mpd.conf /etc/mpd.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
