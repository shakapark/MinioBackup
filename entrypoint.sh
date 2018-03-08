#!/bin/bash
set -e

function backupMinioToMinio() {
  echo "Starting Backup"

  DATE=$(date +"%d-%m-%Y")
  mc mb $DST/$DATE

  BUCKETS=$(mc --json ls $SRC | grep -Eo '"key":.*?[^\\]",'|awk -F':' '{print $2}' | cut -d \" -f2 | cut -d / -f1 | tr " " "\n")
  for BUCKET in $BUCKETS
  do
    mc cp -r $SRC/$BUCKET $DST/$DATE
  done

  DATE=$(date -d "$RETENTION days ago" +"%d-%m-%Y")
  mc rm --recursive --force $DST/$DATE

  echo "Backup Done"
}

#backupMinioToMinio
exit 0
