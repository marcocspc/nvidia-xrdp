#!/bin/sh

if ! [ -f /etc/user_created ] ; then
    mkdir -p /home/$XRDPUSER \
    \
    && groupadd $XRDPUSER \
    \
    && useradd --system \
   --shell /bin/bash \
   --group $XRDPUSER \
   --home /home/$XRDPUSER \
   $XRDPUSER \
   \
   && touch /etc/user_created \
   \
   && echo "User $XRDPUSER created. Now run passwd to set it's password and then run the container again!"
   exit 
fi

/usr/local/sbin/xrdp-sesman --nodaemon &

exec /usr/local/sbin/xrdp --nodaemon 
