#!/bin/bash
set -e

function backupMinioToMinio() {

  mc config host add minio http://${MINIO_ENDPOINT} ${MINIO_ACCESS_KEY} ${MINIO_SECRET_KEY}
  echo "Adding host minio : ${MINIO_ENDPOINT}"
  
  mc config host add minioBackup http://${MINIO_BACKUP} ${MINIO_BACKUP_ACCESS_KEY} ${MINIO_BACKUP_SECRET_KEY}
  echo "Adding host minioBackup : ${MINIO_BACKUP}"
  
  date=$(date +"%d-%m-%Y")
  
  mc mb minioBackup/backup${date}
  echo "Create new bucket on ${MINIO_BACKUP}: backup${date}"
  
  BUCKETS=$(mc --json ls minio | grep -Eo '"key":.*?[^\\]",'|awk -F':' '{print $2}' | cut -d \" -f2 | cut -d / -f1 | tr " " "\n")
  for BUCKET in ${BUCKETS}
  do
    mc cp -r minio/${BUCKET} minioBackup/backup${date}
    echo "Copy ${MINIO_ENDPOINT}/${BUCKET} to ${MINIO_BACKUP}/backup${date}"
  done
  
  exit 0
}

echo "Start Backup"
backupMinioToMinio
