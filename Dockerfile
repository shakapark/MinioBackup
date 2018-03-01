FROM minio/mc:RELEASE.2018-02-09T23-07-36Z

ENV MINIO_ENDPOINT=minio_needed_to_be_backup
ENV MINIO_BACKUP=minio_backup
ENV MINIO_ACCESS_KEY=access_key
ENV MINIO_SECRET_KEY=secret_key
ENV MINIO_BACKUP_ACCESS_KEY=access_key
ENV MINIO_BACKUP_SECRET_KEY=secret_key

RUN apk add --no-cache bash perl

COPY entrypoint.sh .

CMD ["bash","entrypoint.sh"]
