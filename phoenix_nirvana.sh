#!/bin/bash
# Running status check process
#
# Crontab to run this script
# */1 * * * * /path/to/the/script/phoenix_nirvana.sh threadName app_path

#判断日志目录是否存在，不存在创建目录
if [ ! -d "/home/deathlog/$1" ]; then
    mkdir -p "/home/deathlog/$1"
fi
#打印出当前的threadName进程：grep threadName查询的threadName进程，grep -v grep 去掉grep进程
thread=`ps aux | grep '\/'$1'$' | grep -v grep | grep -v /bin/bash`
echo [`date '+%F %T'`] $thread >> /home/deathlog/$1/crontab_`date '+%Y%m%d'`.log

#查询threadName进程个数：wc -l 返回行数
count=`ps aux | grep '\/'$1'$' | grep -v /bin/bash | grep -v grep | wc -l`
if [ $count -gt 0 ]; then
    #若进程还未关闭，则输出当前存在的进程数
    echo [`date '+%F %T'`] the thread $1 is still alive. alive count: $count >> /home/deathlog/$1/crontab_`date '+%Y%m%d'`.log
else
    #若进程已经关闭，则重启服务
    echo [`date '+%F %T'`] the thread $1 is restarting >> /home/deathlog/$1/crontab_`date '+%Y%m%d'`.log
    cd $2
    ./$1 &
fi
