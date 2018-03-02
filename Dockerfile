FROM minio/mc:RELEASE.2018-02-09T23-07-36Z

ENV SRC=minio_needed_to_be_backup
ENV DST=minio_backup

RUN apk add --no-cache bash perl

COPY entrypoint.sh .
RUN chmod a+x /entrypoint.sh

CMD ["./entrypoint.sh"]
