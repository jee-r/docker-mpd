#!/bin/sh

## start
if [ -e /config/mpd.conf ]
then
  exec mpd --no-daemon --stdout /config/mpd.conf "$@"
else
  exec mpd --no-daemon --stdout /etc/mpd.conf "$@"
fi
