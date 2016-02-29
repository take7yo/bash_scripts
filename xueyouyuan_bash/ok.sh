#! /bin/bash 
sourcePath=/home/goProjects/src
cd $sourcePath/cn.jinseyulin.evaluation 
export GOPATH=/home/goProjects:$GOPATH
go build main.go
setsid ./main 
