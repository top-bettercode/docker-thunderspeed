镜像包含wine,可使用此镜像运行其他wine程序

### 准备工作

允许所有用户访问X11服务,运行命令:

```bash
    xhost +
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
      - "/data/downloads:/迅雷下载"
    environment:
      - DISPLAY=unix$DISPLAY
      - QT_IM_MODULE=fcitx
      - XMODIFIERS=@im=fcitx
      - GTK_IM_MODULE=fcitx
      - AUDIO_GID=63 # 主机audio gid 解决声音设备访问权限问题
      - GID=1000 # 主机当前用户 gid 解决挂载目录访问权限问题
      - UID=1000 # 主机当前用户 uid 解决挂载目录访问权限问题
```
或

```bash
    docker run -d --name thunderspeed --device /dev/snd \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "/data/downloads:/迅雷下载" \
    -e DISPLAY=unix$DISPLAY \
    -e XMODIFIERS=@im=fcitx \
    -e QT_IM_MODULE=fcitx \
    -e GTK_IM_MODULE=fcitx \
    -e AUDIO_GID=63 \
    -e GID=1000 \
    -e UID=1000 \
    bestwu/thunderspeed
```