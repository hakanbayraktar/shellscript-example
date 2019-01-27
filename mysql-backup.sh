#!/bin/bash
 
################################################################
##
##   MySQL Database Backup Script 
##   Written By: Hakan Bayraktar
##
################################################################
 
export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`

BACKUP_PATH='/dbbackup'
HOST='localhost'
DB_USER='backup'
PASSWORD='mysecret'
DATABASE='mydatabase'
RETAIN_DAYS=20   

mysqldump -h ${HOST} \
   -u ${DB_USER} \
   -p${PASSWORD} \
   ${DATABASE} | gzip > ${BACKUP_PATH}/${TODAY}/${DATABASE}-${TODAY}.sql.gz

 
DBDELDATE=`date +"%d%b%Y" --date="${RETAIN_DAYS} days ago"`
 
if [ ! -z ${BACKUP_PATH} ]; then
      cd ${BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi
 
