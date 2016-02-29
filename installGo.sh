#!/bin/bash
export GOPATH=$GOPATH:$PWD
/usr/local/go/bin/go install $1
cd ./bin
./$1
