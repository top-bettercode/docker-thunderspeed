[![Docker Image](https://img.shields.io/badge/docker%20image-available-green.svg)](https://hub.docker.com/r/bestwu/thunderspeed/)

相关：[迅雷远程下载 docker 镜像](https://hub.docker.com/r/bestwu/xware/)

本镜像基于[深度操作系统](https://www.deepin.org/download/)

迅雷版本：7.10.35

### 准备工作

允许所有用户访问X11服务,运行命令:

```bash
    xhost +
```

## 查看系统audio gid

```bash
  cat /etc/group | grep audio
```

fedora 26 结果：

```bash
audio:x:63:
```

### 运行

### docker-compose

```yml
version: '2'
services:
  thunderspeed:
    image: bestwu/thunderspeed
    container_name: thunderspeed
    devices:
      - /dev/snd
    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix
      - $HOME/.thunderspeed:/home/thunderspeed/.thunderspeed
      - "/data/downloads:/迅雷下载"
    environment:
      - DISPLAY=unix$DISPLAY
      - QT_IM_MODULE=fcitx
      - XMODIFIERS=@im=fcitx
      - GTK_IM_MODULE=fcitx
      - AUDIO_GID=63 # 可选 默认63（fedora） 主机audio gid 解决声音设备访问权限问题
      - GID=1000 # 可选 默认1000 主机当前用户 gid 解决挂载目录访问权限问题
      - UID=1000 # 可选 默认1000 主机当前用户 uid 解决挂载目录访问权限问题
```

或

```bash
    docker run -d --name thunderspeed --device /dev/snd \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$HOME/.thunderspeed:/home/thunderspeed/.thunderspeed" \
    -v "/data/downloads:/迅雷下载" \
    -e DISPLAY=unix$DISPLAY \
    -e XMODIFIERS=@im=fcitx \
    -e QT_IM_MODULE=fcitx \
    -e GTK_IM_MODULE=fcitx \
    -e AUDIO_GID=`getent group audio | cut -d: -f3` \
    -e GID=`id -g` \
    -e UID=`id -u` \
    bestwu/thunderspeed
```

<sub><sup>Special environment variable: CRACKED=true</sup></sub>
