ARG PHP_VERSION="7.4"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx-php-fpm:php${PHP_VERSION}"
ARG WEB_ROOT="/var/www/html"
ARG TARGET_ARCH_TAG

## get the files we need
#
FROM moonbuggy2000/fetcher:latest AS fetcher

ARG WEB_ROOT
WORKDIR "${WEB_ROOT}"

ARG PMCA_VERSION="1.3.0"
RUN wget -qO- "https://github.com/elijaa/phpmemcachedadmin/archive/${PMCA_VERSION}.tar.gz" | tar -xz --strip 1 \
	&& rm -f Config/Memcache.sample.php

## build the image
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR
ARG QEMU_ARCH=""
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

ARG WEB_ROOT
COPY --from=fetcher "${WEB_ROOT}" "${WEB_ROOT}"

ARG PHP_VERSION
RUN apk -U add --no-cache \
		"php${PHP_VERSION%%.*}-xml"=~"${PHP_VERSION}"

RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" >/dev/null 2>&1

## drop the QEMU binaries
#
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

VOLUME "${WEB_ROOT}/Config"

ARG NGINX_PORT="8080"
EXPOSE "${NGINX_PORT}"

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s \
	CMD wget --quiet --tries=1 --spider http://127.0.0.1:8080/fpm-ping && echo 'okay' || exit 1
