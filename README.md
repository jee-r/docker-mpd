# docker-mpd
[![Drone (cloud)](https://img.shields.io/drone/build/jee-r/docker-mpd?&style=flat-square)](https://cloud.drone.io/jee-r/docker-mpd)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/j33r/mpd?style=flat-square)](https://microbadger.com/images/j33r/mpd)
[![MicroBadger Layers](https://img.shields.io/microbadger/layers/j33r/mpd?style=flat-square)](https://microbadger.com/images/j33r/mpd)
[![Docker Pulls](https://img.shields.io/docker/pulls/j33r/mpd?style=flat-square)](https://hub.docker.com/r/j33r/mpd)
[![DockerHub](https://shields.io/badge/Dockerhub-j33r/php%E2%88%92fpm-%232496ED?logo=docker&style=flat-square)](https://hub.docker.com/r/j33r/mpd)


A docker image for [**M**usic **P**layer **D**aemon](https://www.musicpd.org) based on [Alpine Linux](https://alpinelinux.org) and **[without root process](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user)**

# Supported tags

| Tags | Alpine | MPD | Size | Layers |
|-|-|-|-|-|
| `latest`, `stable`, `master` | 3.11 | 0.21.16-r1 | ![](https://img.shields.io/docker/image-size/j33r/mpd/latest?style=flat-square) | ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/j33r/mpd/latest?style=flat-square) |
| `dev` | 3.14 | 0.22.8-r2 | ![](https://img.shields.io/docker/image-size/j33r/dev/dev?style=flat-square) | ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/j33r/mpd/dev?style=flat-square) |

# What is MPD?

From [musicpd.org](https://www.musicpd.org):

> Music Player Daemon (MPD) is a flexible, powerful, server-side application for playing music. Through plugins and libraries it can play a variety of sound files while being controlled by its network protocol.

# How to use these images

## Docker
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
    j33r/mpd:latest
```    

## Docker Compose

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

## Volumes

* `/config` directory containing your `.conf`, `.db`, `.log`, `.pid`, `.socket`, `.state` and `sticker.sql`. See [Doc](https://www.musicpd.org/doc/html/user.html#configuration) or/and default config file [mpd.conf](https://github.com/jee-r/docker-mpd/blob/master/rootfs/etc/mpd.conf) for more informations.
* `/Music` directory containing your music (read-only). [Doc](https://www.musicpd.org/doc/html/user.html#configuring-the-music-directory)


## Ports

* `6600` port that MPD listens on for connections from clients. [Doc](https://www.musicpd.org/doc/html/user.html#listeners)
* `6868` httpd audio output port [Doc](https://www.musicpd.org/doc/html/plugins.html#httpd)


## Environment variables

To change the timezone of the container set the `TZ` environment variable. The full list of available options can be found on [Wikipedia](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

You can also set the `HOME` environment variable this is usefull to get in the right directory when you attach a shell in your docker container.


# Contributions

### Short Story
```bash
# fork this repo then :
git clone https://github/<YourName>/docker-mpd.git
cd docker-mpd
git checkout dev
git pull origin dev
# Do what you need to do, when you'r done then
git add <modified.file> <second.modified.file> <whatever>
git commit -m 'Your message that describe your change'
git push origin dev
# Submit a pull-request
```
### Long Story
* [Fork this repo](https://duckduckgo.com/?q=how+fork+a+git+repository)

* Clone your fork of this repo \
  `git clone https://github/<YourName>/docker-mpd.git`

* **Always work on the `dev`  branch** \
    `cd docker-mpd` \
    `git checkout dev`

* be sure your fork's dev branch is up to database \
  `cd docker-mpd` \
  `git pull origin dev`

* Do what you need to do and when you'r done then \
  For typo please try to make less commits as possible.

* Add and commit your modifications \
  `git add <modified.file> <second.modified.file> <whatever>` \
  `git commit -m 'Your message that describe your change'`

* push on your fork \
  ` git push origin dev` \

* And finaly [open a pull request](https://github.com/jee-r/docker-mpd/compare) comparing your dev branch with mine

If you find a vulnerability please contact me by mail  

# License

This project is under the [GNU Generic Public License v3](https://github.com/jee-r/docker-mpd/blob/master/LICENSE) to allow free use while ensuring it stays open.
