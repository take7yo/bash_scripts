#!/bin/bash
./mp3.sh http://sc.chinaz.com/yinxiao/ 音效1
for (( i=2; i<=433; i++ ))
	do		
	./mp3.sh http://sc.chinaz.com/yinxiao/index_${i}.html 音效${i}
done