#!/bin/sh

/usr/local/sbin/xrdp-sesman --no-daemon >> /dev/sdtout 2>&1 &

exec /usr/local/sbin/xrdp --no-daemon >> /dev/sdtout 2>&1
