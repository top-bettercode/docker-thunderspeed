#!/bin/bash

user="$USER"  
group="$USER"
logfile="/root/app.log"
#create group if not exists  
egrep "^$group" /etc/group >& /dev/null  
if [ $? -ne 0 ]  
then  
    groupadd -g 1000 $group  
fi  
  
#create user if not exists  
egrep "^$user" /etc/passwd >& /dev/null  
if [ $? -ne 0 ]  
then  
    useradd -d "/home/$user" -m -u 1000 -g $group $user
fi

if [ "$user"x != "root"x ]; then
    logfile="/home/$user/app.log"
fi

echo "use:$group $user"
su - "$user" <<EOF
if [ "$1" ]; then
    echo "deepin-wine $1"
    deepin-wine $1
else
    echo "启动 ThunderSpeed"
    nohup /opt/deepinwine/apps/Deepin-ThunderSpeed/run.sh >"$logfile" &
    tail -fn 0 "$logfile"
fi

exit 0
EOF