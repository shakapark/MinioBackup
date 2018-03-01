#!/bin/bash
set -e

function backupMinioToMinio() {

  mc config host add minio http://${MINIO_ENDPOINT} ${MINIO_ACCESS_KEY} ${MINIO_SECRET_KEY}
  mc config host add minioBackup http://${MINIO_BACKUP} ${MINIO_BACKUP_ACCESS_KEY} ${MINIO_BACKUP_SECRET_KEY}
  
  date=$(date +"%d-%m-%Y")
  mc mb minioBackup/backup${date}
  
  BUCKETS=$(mc --json ls minio | grep -Eo '"key":.*?[^\\]",'|awk -F':' '{print $2}' | cut -d \" -f2 | cut -d / -f1 | tr " " "\n")
  for BUCKET in ${BUCKETS}
  do
    mc cp -r minio/${BUCKET} minioBackup/backup${date}
  done
}

echo "Start Backup"
backupMinioToMinio
exit 0
