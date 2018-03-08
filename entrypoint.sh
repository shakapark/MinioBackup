#!/bin/bash

function backupMinioToMinio() {
  echo "Starting Backup"

  DATE=$(date -d "$RETENTION days ago" +"%d-%m-%Y")
  mc rm --recursive --force $DST/$DATE

  DATE=$(date +"%d-%m-%Y")
  mc mb $DST/$DATE
  echo $?


  BUCKETS=$(mc --json ls $SRC | grep -Eo '"key":.*?[^\\]",'|awk -F':' '{print $2}' | cut -d \" -f2 | cut -d / -f1 | tr " " "\n")
  for BUCKET in $BUCKETS
  do
    mc cp -r $SRC/$BUCKET $DST/$DATE
    echo $?
    if [ $? != 0 ]
    then
      exit 1
    fi
  done

  echo "Backup Done"
}

backupMinioToMinio
exit 0
