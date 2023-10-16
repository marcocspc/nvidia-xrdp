#!/bin/sh

/usr/local/sbin/xrdp-sesman --nodaemon >> /dev/sdtout 2>&1 &

exec /usr/local/sbin/xrdp --nodaemon >> /dev/sdtout 2>&1
