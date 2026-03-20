# syntax=docker/dockerfile:1
# hadolint global ignore=DL3007,DL3022,DL3032,DL3033

ARG OS_VERSION=latest

FROM public.ecr.aws/amazonlinux/amazonlinux:${OS_VERSION} AS env

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked \
    --mount=type=cache,target=/var/cache/yum,sharing=locked <<EOF
    yum install -y rpm-build rpmdevtools make systemd
    yum install -y openssl openssh-server vim
EOF

FROM env AS test
COPY --from=project --link src /build/src
COPY --from=project --link bin /build/bin
COPY --from=project --link unit-test /build/unit-test
COPY --from=project --link rpmsrc /build/rpmsrc
COPY --from=project --link Makefile VERSION /build/

WORKDIR /build
RUN bin/unit_test_suite.sh

FROM test AS build
RUN make rpm && rpm -i --test ec2-instance-connect*.rpm


FROM scratch AS rpm
COPY --from=build /build/*.rpm /
