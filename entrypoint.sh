#!/bin/sh

/usr/local/sbin/xrdp-sesman --no-daemon &

exec /usr/local/sbin/xrdp --no-daemon 
