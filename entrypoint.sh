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
    chown thunderspeed:thunderspeed  /home/thunderspeed/.thunderspeed
fi

su thunderspeed <<EOF
echo "启动 $APP"
if [ ! -d "/home/thunderspeed/.deepinwine/Deepin-ThunderSpeed/" ]; then
    "/opt/deepinwine/apps/Deepin-$APP/run.sh" -c
    if [ "$CRACKED" == "true" ]; then
        echo 'crack thunderspeed'
        cp /home/thunderspeed/dll/* "/home/thunderspeed/.deepinwine/Deepin-ThunderSpeed/drive_c/Program Files/Thunder Network/Thunder/Program/"
    fi
    if [ -d "/home/thunderspeed/.deepinwine/Deepin-ThunderSpeed/drive_c/Program Files/Thunder Network/Thunder/Profiles" ]; then
        if [ ! -d "/home/thunderspeed/.thunderspeed/Community" ]; then
            mv "/home/thunderspeed/.deepinwine/Deepin-ThunderSpeed/drive_c/Program Files/Thunder Network/Thunder/Profiles/*" "/home/thunderspeed/.thunderspeed/"
        fi
        rm -rf "/home/thunderspeed/.deepinwine/Deepin-ThunderSpeed/drive_c/Program Files/Thunder Network/Thunder/Profiles"
    else
        mkdir -p "/home/thunderspeed/.deepinwine/Deepin-ThunderSpeed/drive_c/Program Files/Thunder Network/Thunder"
    fi
    ln -s /home/thunderspeed/.thunderspeed   "/home/thunderspeed/.deepinwine/Deepin-ThunderSpeed/drive_c/Program Files/Thunder Network/Thunder/Profiles"
fi
"/opt/deepinwine/apps/Deepin-$APP/run.sh"
EOF
