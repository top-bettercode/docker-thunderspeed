FROM bestwu/wine:i386
MAINTAINER Peter Wu <piterwu@outlook.com>

RUN apt-get update && \
    apt-get install -y deepin.com.thunderspeed && \
    apt-get -y autoremove && apt-get clean -y && apt-get autoclean -y && \
    rm -rf var/lib/apt/lists/* var/cache/apt/* var/log/*

ENV APP=ThunderSpeed \
    AUDIO_GID=63 \
    VIDEO_GID=39 \
    GID=1000 \
    UID=1000

ADD entrypoint.sh /
ADD run.sh /
RUN chmod +x /entrypoint.sh && \
    chmod +x /run.sh && \
    groupadd -o -g $GID thunderspeed && \
    groupmod -o -g $AUDIO_GID audio && \
    groupmod -o -g $VIDEO_GID video && \
    useradd -d "/home/thunderspeed" -m -o -u $UID -g thunderspeed -G audio,video thunderspeed && \
    mkdir "/迅雷下载" && \
    chown -R thunderspeed:thunderspeed "/迅雷下载"

VOLUME ["/迅雷下载"]

ENTRYPOINT ["/entrypoint.sh"]