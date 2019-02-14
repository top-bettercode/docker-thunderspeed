#!/bin/bash

groupmod -o -g $AUDIO_GID audio
if [ $GID != $(echo `id -g thunderspeed`) ]; then
    groupmod -o -g $GID thunderspeed
fi
if [ $UID != $(echo `id -u thunderspeed`) ]; then
    usermod -o -u $UID thunderspeed
fi
chown thunderspeed:thunderspeed "/迅雷下载"
if [ -d "/home/thunderspeed/.thunderspeed" ]; then
    chown thunderspeed:thunderspeed /home/thunderspeed/.thunderspeed
fi

su thunderspeed <<EOF
echo "启动 $APP"
"/opt/deepinwine/apps/Deepin-$APP/run.sh"
EOF
