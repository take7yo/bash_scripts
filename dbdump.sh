#!/bin/bash
dbname=$1
dbhost=$2
backupFolder=$3
## 检查是否传入数据库名称，如果未传入，退出程序
if [ -z "${dbname}" ]; then
    echo "please input the db name as the first parameter."
    exit 0
fi
## 检查是否设置备份文件夹，如果未设置，则使用默认文件夹
if [ -z "${backupFolder}" ]; then
    backupFolder=/data/dbbackup/${dbname}
    echo "backup folder is set as default: ${backupFolder}."
else
    echo "backup folder is set as custom: ${backupFolder}."
fi
## 检查数据库主机名，如果未设置，则使用默认的主机名
if [ -z "${dbhost}"]; then
    dbhost="10.6.31.149"
    echo "db host is set as default: ${dbhost}."
else
    echo "db host is set as custom: ${dbhost}."
fi
## 如果备份目录不存在，则创建备份目录
if [ ! -d "${backupFolder}" ]; then
    mkdir -p ${backupFolder}
fi

echo "进入备份目录：${backupFolder}."
cd ${backupFolder}
filename=${dbname}-`date +%Y%m%d%H`.sql
##echo $filename >> dump.log
echo "执行备份脚本：mysqldump -h${dbhost} -uroot -pibignose12345 ${dbname} > ${filename}"
mysqldump -h${dbhost} -uroot -pibignose12345 ${dbname} > ${filename}
echo "压缩备份文件：gzip -f ${filename}"
gzip -f ${filename}
echo "删除5天前的备份数据：rm -f ${dbname}-`date -d'5 days ago' +%Y%m%d*.sql.gz`"
rm -f ${dbname}-`date -d'5 days ago' +%Y%m%d*.sql.gz`
echo "rsync同步数据到备份机。/usr/bin/rsync -vazrtoLPg ${backupFolder}/${filename}.gz 117.29.168.34::dbbackup"
##/usr/bin/rsync -vazrtoLPg ${backupFolder}/${filename}.gz 117.29.168.34::dbbackup
