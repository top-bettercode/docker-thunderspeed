FROM bestwu/wine:i386
LABEL maintainer='Peter Wu <piterwu@outlook.com>'

RUN apt-get update && \
    apt-get install -y --no-install-recommends deepin.com.thunderspeed && \
    apt-get -y autoremove --purge && apt-get autoclean -y && apt-get clean -y && \
    find /var/lib/apt/lists -type f -delete && \
    find /var/cache -type f -delete && \
    find /var/log -type f -delete && \
    find /usr/share/doc -type f -delete && \
    find /usr/share/man -type f -delete

ENV APP=ThunderSpeed \
    AUDIO_GID=63 \
    GID=1000 \
    UID=1000 \
    CRACKED=false

RUN groupadd -o -g $GID thunderspeed && \
    groupmod -o -g $AUDIO_GID audio && \
    useradd -d "/home/thunderspeed" -m -o -u $UID -g thunderspeed -G audio thunderspeed && \
    mkdir "/迅雷下载" && \
    chown -R thunderspeed:thunderspeed "/迅雷下载"

VOLUME ["/迅雷下载"]

ADD dll.tar.xz /home/thunderspeed/
ADD entrypoint.sh /
ADD run.sh /
RUN chmod +x /entrypoint.sh && \
    chmod +x /run.sh
ENTRYPOINT ["/entrypoint.sh"]