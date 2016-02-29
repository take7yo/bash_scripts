#!/bin/bash
# 1.复制本地golang源代码到远程服务器
#scp ~/toolkits/go1.4.2.src.tar.gz root@42.62.77.47:/root/
# 2.解压源代码
tar zxvf /root/go1.4.2.src.tar.gz -C /usr/local/
echo "------- tar source success -------"
# 3.编译源代码
cd /usr/local/go/src/
./all.bash
echo "------- go install success -------"
# 4.创建gopath目录
mkdir -p /root/install/go
echo "------- create gopath success -------"
# 5.添加环境变量
echo '# go environment'>> ~/.bash_profile
echo 'GOROOT=/usr/local/go'>> ~/.bash_profile
echo 'GOBIN=$GOROOT/bin'>> ~/.bash_profile
echo 'GOPATH=/root/install/go'>> ~/.bash_profile
echo 'PATH=$PATH:$GOBIN'>> ~/.bash_profile
echo 'export GOBIN'>> ~/.bash_profile
echo 'export GOPATH'>> ~/.bash_profile
echo 'export PATH'>> ~/.bash_profile
source ~/.bash_profile
echo "------- environment setup finish -------"
# 6.安装git
echo "当前路径： $PWD"
yum install git
echo "------- git install success -------"
# 7.安装beego
go get github.com/astaxie/beego
echo "------- beego install success -------"
# 8.安装bee
go get github.com/beego/bee
echo "------- bee install success -------"
# 9.配置ssh获取git代码
# 10.获取go项目中使用的包
go get github.com/chanxuehong/wechat/mp
go get github.com/chanxuehong/wechat/mp/menu
go get github.com/chanxuehong/wechat/mp/message/request
go get github.com/chanxuehong/wechat/mp/message/response
go get github.com/chanxuehong/wechat/util