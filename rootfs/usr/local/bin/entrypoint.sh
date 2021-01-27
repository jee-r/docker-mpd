#!/bin/sh


## expect music passed in from mount, fail otherwise (mount not available?)
#[[ "$(ls -A /mpd/music)" ]] ||  exit

#touch \
#  /mpd/cache/tag_cache \
#  /mpd/cache/state \
#  /mpd/cache/sticker.sql
#
#chown -R mpd /mpd/cache

## start
if [ -e /config/mpd.conf ]
then
  exec mpd --no-daemon --stdout /config/mpd.conf "$@"
else
  exec mpd --no-daemon --stdout /etc/mpd.conf "$@"
fi


