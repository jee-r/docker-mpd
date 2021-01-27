FROM alpine:3.13

LABEL name="docker-mpd" \
      maintainer="Jee jee@jeer.fr" \
      description="Music Player Daemon (MPD) is a flexible, powerful, server-side application for playing music. Through plugins and libraries it can play a variety of sound files while being controlled by its network protocol." \
      url="https://musicpd.org" \
      org.label-schema.vcs-url="https://musicpd.org/"

COPY rootfs /

ARG CHROMAPRINT_VER=1.5.0

RUN set -x && \
    apk update && \
    apk upgrade && \
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


ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
