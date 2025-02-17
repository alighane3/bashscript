#!/bin/bash

FTP_SERVER="your ftp server address"
FTP_USER="your ftp username"
FTP_PASS="your ftp password"

LOCAL_BACKUP_DIR="/backup-temp"
FTP_BASE_DIR="/full-daily"

DAY_OF_WEEK=$(date +%A)
FTP_TARGET_DIR="$FTP_BASE_DIR/$DAY_OF_WEEK"

/usr/local/directadmin/directadmin admin-backup --destination=$LOCAL_BACKUP_DIR

ftp -inv $FTP_SERVER <<EOF
user $FTP_USER $FTP_PASS
cd $FTP_TARGET_DIR
mdelete *
lcd $LOCAL_BACKUP_DIR
mput *
bye
EOF

rm -rf $LOCAL_BACKUP_DIR/*
