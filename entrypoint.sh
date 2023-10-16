#!/bin/sh

/usr/local/sbin/xrdp-sesman --nodaemon &

exec /usr/local/sbin/xrdp --nodaemon 
