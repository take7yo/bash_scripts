#!/bin/bash
cd /data/wooyoudb
filename=wooyou-`date +%Y%m%d%H`
##echo $filename >> dump.log
mysqldump -uroot -pibignose12345 wooyou_new > $filename.sql
gzip -f $filename.sql
rm -f wooyou-`date -d'5 days ago' +%Y%m%d*.sql.gz`
/usr/bin/rsync -vazrtoLPg /data/wooyoudb/$filename.sql.gz 117.29.168.34::dbbackup
