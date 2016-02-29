#!/bin/bash
export GOPATH=$GOPATH:$PWD
cd src/$1
bee run -downdoc=true -gendoc=true
