FROM minio/mc:RELEASE.2018-02-09T23-07-36Z

ENV MINIO_ENDPOINT=minio_needed_to_be_backup
ENV MINIO_BACKUP=minio_backup
ENV MINIO_ACCESS_KEY_FILE=access_key
ENV MINIO_ACCESS_KEY_FILE=access_key
ENV MINIO_BACKUP_SECRET_KEY_FILE=secret_key
ENV MINIO_BACKUP_SECRET_KEY_FILE=secret_key

RUN apk add --no-cache bash

COPY entrypoint.sh .

ENTRYPOINT ["entrypoint.sh"]
