# docker-mpd
[![Drone (cloud)](https://img.shields.io/drone/build/jee-r/docker-mpd?style=flat-square)](https://cloud.drone.io/jee-r/docker-mpd)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/j33r/mpd?style=flat-square)](https://microbadger.com/images/j33r/mpd)
[![MicroBadger Layers](https://img.shields.io/microbadger/layers/j33r/mpd?style=flat-square)](https://microbadger.com/images/j33r/mpd)
[![Docker Pulls](https://img.shields.io/docker/pulls/j33r/mpd?style=flat-square)](https://hub.docker.com/r/j33r/mpd)
[![DockerHub](https://img.shields.io/badge/Dockerhub-j33r/mpd-%232496ED?logo=docker&style=flat-square)](https://hub.docker.com/r/j33r/mpd)

A docker image for [mpd](https://mpd-torrent.org/) ![mpd's logo](https://imgur.com/Ke0wBtA.png)

## docker-compose

```
version: '3.8'
services:
  mpd:
    #build: .
    image: j33r/mpd:latest
    container_name: mpd
    user: ${UID}:${GID}
    restart: unless-stopped
    ports:
      - 6600:6600
      #- 8000:8000
    volumes:
      - ${PWD}/config:/config
      - ${HOME}/Music:/Music:ro
      - /etc/localtime:/etc/localtime:ro
```
