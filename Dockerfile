FROM golang:1.18-buster AS builder

# Configuration

ENV WALG_VERSION=2.0.1
ENV BROTLI_VERSION=1.0.9

# OS Packages

RUN apt-get update
RUN apt-get install -y build-essential cmake

# Brotli

WORKDIR /tmp
RUN wget -qO - https://github.com/google/brotli/archive/v${BROTLI_VERSION}.tar.gz | tar -xvzf '-'
WORKDIR /tmp/brotli-${BROTLI_VERSION}/out
RUN ../configure-cmake --disable-debug
RUN make
RUN make install

# WAL-G

WORKDIR $GOPATH/src
RUN git clone --depth 1 -b "v$WALG_VERSION" --single-branch https://github.com/wal-g/wal-g/
WORKDIR $GOPATH/src/wal-g/
RUN make install
RUN git submodule update --init
RUN make deps
RUN make pg_build
RUN make link_brotli
RUN install main/pg/wal-g /
RUN /wal-g --help

# Alpine container

FROM alpine:3.16.2
COPY --from=builder /wal-g /
