FROM avestura/walg:2.0.1-brotli1.0.9 as wal-g
FROM bitnami/postgresql:14.5.0-debian-11-r7

COPY --from=wal-g /wal-g /

# Change archive_command to "/wal-g wal-push %p"
# Change restore_command to "/wal-g wal-fetch %f %p"

# STORAGE environment variables documentation
# See: https://github.com/wal-g/wal-g#configuration
#ENV WALE_S3_PREFIX=s3://bucket/path/to/folder
#ENV AWS_ACCESS_KEY_ID=xxxx
#ENV AWS_SECRET_ACCESS_KEY=secret
#ENV AWS_REGION=us-west-2
#ENV AWS_ENDPOINT=http://s3-like-service:9000
ENV AWS_S3_FORCE_PATH_STYLE=true
ENV WALG_COMPRESSION_METHOD brotli

# POSTGRES environment variables documentation
# See: https://github.com/wal-g/wal-g/blob/master/PostgreSQL.md#configuration

ENV PGHOST=/var/run/postgresql
ENV PGUSER=postgres
#ENV PGPASSWORD=secret
ENV ARCHIVE_MODE=on
ENV ARCHIVE_TIMEOUT=0
#ENV WALG_PGP_KEY_PATH=/keys/wal-g.pub

LABEL org.opencontainers.image.source=https://github.com/avestura/walg-docker
LABEL org.opencontainers.image.description="Bitnami's Postgresql bundled with WALG and Google's Brotli"
LABEL org.opencontainers.image.licenses=MIT