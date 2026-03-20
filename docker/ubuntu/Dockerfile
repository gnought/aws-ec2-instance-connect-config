# syntax=docker/dockerfile:1
# hadolint global ignore=DL3008,DL3015,DL3022

FROM ubuntu:latest AS build
ARG DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked <<EOF
    apt-get update
    apt-get install -y devscripts debhelper
    apt-get install -y dh-systemd || true # for ubuntu < 20.04
EOF

COPY --from=project --link src /build/src
COPY --from=project --link bin /build/bin
COPY --from=project --link debian /build/debian
COPY --from=project --link Makefile VERSION /build/

WORKDIR /build
RUN make deb

FROM scratch AS deb
COPY --from=build /build/*.deb /
