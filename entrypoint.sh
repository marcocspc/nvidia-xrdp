#!/bin/sh

/usr/local/sbin/xrdp-sesman  >> /dev/sdtout 2>&1 &

exec /usr/local/sbin/xrdp  >> /dev/sdtout 2>&1
