#/bin/bash
export GOPATH=$GOPATH:$PWD
/usr/local/go/bin/go install $1
cd ./bin
mv $1 weixin
./weixin
