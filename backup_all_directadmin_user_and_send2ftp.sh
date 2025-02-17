#!/bin/bash

FTP_SERVER="your ftp server address"
FTP_USER="your ftp username"
FTP_PASS="your ftp password"

LOCAL_BACKUP_DIR="/backup-temp"
FTP_BASE_DIR="/full-daily"
LOG_FILE="/root/scripts/backup-full-to-ftp.log"
CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
DAY_OF_WEEK=$(date +%A)
FTP_TARGET_DIR="$FTP_BASE_DIR/$DAY_OF_WEEK"

echo "-----------------------------"
echo "[$CURRENT_TIME] Backup process started" | tee -a "$LOG_FILE"
echo "[$CURRENT_TIME] Backup for day: $DAY_OF_WEEK in ftp directory $FTP_TARGET_DIR" | tee -a "$LOG_FILE"

/usr/local/directadmin/directadmin admin-backup --destination=$LOCAL_BACKUP_DIR

{
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] Connecting to FTP server $FTP_SERVER"

    ftp -inv $FTP_SERVER <<EOF
    user $FTP_USER $FTP_PASS
    cd $FTP_TARGET_DIR
    mdelete *
    lcd $LOCAL_BACKUP_DIR
    mput *
    bye
EOF

    echo "[$(date "+%Y-%m-%d %H:%M:%S")] File transfer to FTP completed"

    # Delete local backup files after successful transfer
    rm -rf $LOCAL_BACKUP_DIR/*
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] Local backup files deleted"
} | tee -a "$LOG_FILE"


CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "[$CURRENT_TIME] Backup process completed" | tee -a "$LOG_FILE"
