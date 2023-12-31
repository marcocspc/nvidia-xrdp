#!/bin/sh

if ! [ -f /etc/user_created ] ; then
    mkdir -p /home/$XRDPUSER \
    \
    && groupadd $XRDPUSER \
    \
    && useradd --system \
   --shell /bin/bash \
   -g $XRDPUSER \
   --home /home/$XRDPUSER \
   $XRDPUSER \
   \
   && touch /etc/user_created \
   \
   && echo "User $XRDPUSER created. Now run passwd to set it's password and then run the container again!"
fi

echo "Starting xrdp-sesman"
/usr/local/sbin/xrdp-sesman --nodaemon &

echo "Starting xrdp"
exec /usr/local/sbin/xrdp --nodaemon 
