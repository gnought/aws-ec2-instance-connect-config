# syntax=docker/dockerfile:1

FROM amazonlinux:latest AS build

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked \
    --mount=type=cache,target=/var/cache/yum,sharing=locked \
    dnf install -y rpm-build rpmdevtools make systemd

COPY --from=project --link src /build/src
COPY --from=project --link bin /build/bin
COPY --from=project --link rpmsrc /build/rpmsrc
COPY --from=project --link Makefile VERSION /build/

WORKDIR /build
RUN make rpm

FROM scratch AS rpm
COPY --from=build /build/*.rpm /
