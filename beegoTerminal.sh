#!/bin/bash
export GOPATH=$GOPATH:$PWD
if [ -d "$1" ]; then
    cd "$1"
    bee run -downdoc=true -gendoc=true
else
    echo '$1 目录不存在'
fi
