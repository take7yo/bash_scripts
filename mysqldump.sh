#!/bin/bash
# Crontab to run this script
# 0 12,18,22 * * * /path/to/this/script
# DB_USERNAME, DB_PASSWORD, DB_DATABASE, SAVE_DIR, REMOTE_PATH must be reconfig.

# mysql connection setting
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=username
DB_PASSWORD=password
DB_DATABASE=database_name

# filename format
SAVE_DIR=save_dir
SQL_FILENAME="${DB_DATABASE}_`date +%Y%m%d%H%M%S`.sql"
GZ_FILENAME="${SQL_FILENAME}.gz"

# remove backup files setting
REMOVE_NAME="${DB_DATABASE}_`date -d'5 days ago' +%Y%m%d*.sql.gz`"

# rsync to synchronize
# example: REMOTE_PATH=192.168.1.178::dbbackup
REMOTE_PATH="remote_host::rsync_name"

# mysqldump arguments
# if all table is innodb engine, use "--single-transaction"
#EXTRA_ARGS='--lock-tables'
EXTRA_ARGS='--single-transaction'

# check if the SAVE_DIR is exists
if [ ! -d $SAVE_DIR ]; then
    mkdir -p $SAVE_DIR
fi
cd $SAVE_DIR
mysqldump -u$DB_USERNAME -p$DB_PASSWORD -h$DB_HOST -P$DB_PORT --flush-logs $EXTRA_ARGS $DB_DATABASE > $SQL_FILENAME
gzip -f $GZ_FILENAME
rm -f $REMOVE_NAME

# synchronize
# Need to configure the remote server rsync
/usr/bin/rsync -vazrtoLPg ${SAVE_DIR}/${GZ_FILENAME} $REMOTE_PATH
