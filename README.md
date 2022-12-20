# docker-mpd

[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/j33r/mpd?style=flat-square)](https://microbadger.com/images/j33r/mpd)
![GitHub Workflow Status (branch)](https://img.shields.io/github/actions/workflow/status/jee-r/docker-mpd/deploy.yaml?branch=main&style=flat-square)
[![Docker Pulls](https://img.shields.io/docker/pulls/j33r/mpd?style=flat-square)](https://hub.docker.com/r/j33r/mpd)
[![DockerHub](https://img.shields.io/badge/Dockerhub-j33r/mpd-%232496ED?logo=docker&style=flat-square)](https://hub.docker.com/r/j33r/mpd)
[![ghcr.io](https://img.shields.io/badge/ghrc%2Eio-jee%2D-r/mpd-%232496ED?logo=github&style=flat-square)](https://ghcr.io/jee-r/mpd)

A docker image for [**M**usic **P**layer **D**aemon](https://www.musicpd.org) based on [Alpine Linux](https://alpinelinux.org) and **[without root process](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user)**

## What is MPD?

From [musicpd.org](https://www.musicpd.org):

> Music Player Daemon (MPD) is a flexible, powerful, server-side application for playing music. Through plugins and libraries it can play a variety of sound files while being controlled by its network protocol.

- Source Code : https://github.com/MusicPlayerDaemon/MPD
- Documentation : https://mpd.readthedocs.io/en/latest/ 
- Official Website : https://musicpd.org/

## How to use these images

### Docker
```bash
docker run \
    --detach \
    --interactive \
    --name mpd \
    --user $(id -u):$(id -g) \
    --env TZ=Europe/Paris \
    --volume `pwd`/config:/config \
    --volume `pwd`/Music:/Music:ro \
    --volume /etc/localtime:/etc/localtime:ro \
    --publish 6600:6600 \
    --publish 6868:6868 \
    ghcr.io/jee-r/mpd:latest
```    

### Docker Compose

[`docker-compose`](https://docs.docker.com/compose/) can help with defining the `docker run` config in a repeatable way rather than ensuring you always pass the same CLI arguments.

```
version: '3'
services:
    mpd:
        image: j33r/mpd:latest
        container_name: mpd
        user: "${UID:-1000}:${GID:-1000}"
        restart: unless-stopped
        environment:
            - HOME=/config
            - TZ=Europe/Paris
        volumes:
            - ${PWD}/config:/config
            - ${HOME}/Music:/Music:ro
            - /etc/localtime:/etc/localtime:ro
        ports:
            - 6600:6600
            - 6868:6868
```

### Volumes

* `/config` directory containing your `.conf`, `.db`, `.log`, `.pid`, `.socket`, `.state` and `sticker.sql`. See [Doc](https://www.musicpd.org/doc/html/user.html#configuration) or/and default config file [mpd.conf](https://github.com/jee-r/docker-mpd/blob/master/rootfs/etc/mpd.conf) for more informations.
* `/Music` directory containing your music (read-only). [Doc](https://www.musicpd.org/doc/html/user.html#configuring-the-music-directory)


### Ports

* `6600` port that MPD listens on for connections from clients. [Doc](https://www.musicpd.org/doc/html/user.html#listeners)
* `6868` httpd audio output port [Doc](https://www.musicpd.org/doc/html/plugins.html#httpd)


### Environment variables

To change the timezone of the container set the `TZ` environment variable. The full list of available options can be found on [Wikipedia](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

You can also set the `HOME` environment variable this is usefull to get in the right directory when you attach a shell in your docker container.


## Contributions

### Questions

We would like to have discussions and general queries related to this repository.
you can reach me on [Libera irc server](https://libera.chat/) `/query jee`

### Pull requests

Before submitting a pull request, ensure that you go through the following:
- Ensure that there is no open or closed Pull Request corresponding to your submission to avoid duplication of effort.
- Create a new branch on your forked repo based on the **main branch** (be sure that your fork is up to date with the upstream) and make the changes in it. Example:
```
    git clone https://your_fork
    git checkout -B patch-N main
```
- Submit the pull request, provide informations (why/where/how) in the comments section

## License

This project is under the [GNU Generic Public License v3](/LICENSE) to allow free use while ensuring it stays open.
