#!/bin/bash

groupmod -o -g $AUDIO_GID audio
if [ $GID != $(echo `id -g thunderspeed`) ]; then
    groupmod -o -g $GID thunderspeed
fi
if [ $UID != $(echo `id -u thunderspeed`) ]; then
    usermod -o -u $UID thunderspeed
fi
chown thunderspeed:thunderspeed "/迅雷下载"


su thunderspeed <<EOF
if [ "$1" ]; then
    echo "deepin-wine $1"
    deepin-wine $1
else
    echo "启动 $APP"
    /run.sh
fi

exit 0
EOF