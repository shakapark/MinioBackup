#!/bin/bash
set -e

function backupMinioToMinio() {

  DATE=$(date +"%d-%m-%Y")
  mc mb $DST/backup$DATE

  BUCKETS=$(mc --json ls $SRC | grep -Eo '"key":.*?[^\\]",'|awk -F':' '{print $2}' | cut -d \" -f2 | cut -d / -f1 | tr " " "\n")
  for BUCKET in $BUCKETS
  do
    mc cp -r $SRC/$BUCKET $DST/$DATE
  done

  DATE=$(date -d $DATE - $RETENTION +"%d-%m-%Y")
  echo $DATE
}

echo "Start Backup"
backupMinioToMinio
exit 0
