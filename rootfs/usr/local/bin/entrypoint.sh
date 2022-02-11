#!/bin/sh

## start
if [ -e /config/mpd.conf ]
then
  exec mpd --no-daemon --stdout /config/mpd.conf "$@"
else
  cp /etc/mpd.conf /config/mpd.conf
  exec mpd --no-daemon --stdout /etc/mpd.conf "$@"
fi
