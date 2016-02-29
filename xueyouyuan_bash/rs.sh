#! /bin/bash 
cd /home/goProjects/src/evaluation 
echo `ps aux | grep service | sed 's/ \{1,\}/ /g'`
pid=`ps aux | grep service | grep -v grep | sed 's/ \{1,\}/ /g' | cut -d' ' -f2`
echo "pid is $pid"
if [[ $pid ]]; then
	kill -9 $pid
	echo "kill pid($pid) success."
else
	echo 'pid no exist'
fi
echo "current path: $PWD"
setsid ./service
echo "service start."
