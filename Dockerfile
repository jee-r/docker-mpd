FROM alpine:3.16

LABEL name="docker-mpd" \
      maintainer="Jee jee@jeer.fr" \
      description="Music Player Daemon (MPD) is a flexible, powerful, server-side application for playing music. Through plugins and libraries it can play a variety of sound files while being controlled by its network protocol." \
      url="https://musicpd.org" \
      org.label-schema.vcs-url="https://github.com/jee-r/docker-mpd" \
      org.opencontainers.image.source="https://github.com/jee-r/docker-mpd"

COPY rootfs /
ENV HOME=/config

# renovate: datasource=github-releases depName=acoustid/chromaprint extractVersion=^v(?<version>.*)$
ARG CHROMAPRINT_VERSION=1.5.0

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
    wget https://github.com/acoustid/chromaprint/releases/download/v${CHROMAPRINT_VERSION}/chromaprint-fpcalc-${CHROMAPRINT_VERSION}-linux-x86_64.tar.gz && \
    tar xvf chromaprint-fpcalc-$CHROMAPRINT_VERSION-linux-x86_64.tar.gz && \
    mv chromaprint-fpcalc-$CHROMAPRINT_VERSION-linux-x86_64/fpcalc /usr/local/bin && \
    strip -s /usr/local/bin/fpcalc && \
    apk del --no-cache \
      wget \
      tar \
      xz \
      binutils && \
    apk add --no-cache \
      mpd \
      mpc && \
    setcap -r /usr/bin/mpd && \
    sed -e '/user\t\t\"mpd\"/ s/^#*/#/' -i /etc/mpd.conf && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE 8000 6600

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
