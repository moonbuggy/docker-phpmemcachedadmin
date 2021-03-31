ARG PHP_VERSION="7.4"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx-php-fpm:php${PHP_VERSION}"

ARG PMCA_VERSION="1.3.0"

ARG WEB_ROOT="/var/www/html"

## get the files we need
#
FROM moonbuggy2000/fetcher:latest AS fetcher

ARG WEB_ROOT
WORKDIR "${WEB_ROOT}"

ARG PMCA_VERSION
RUN wget -qO- "https://github.com/elijaa/phpmemcachedadmin/archive/${PMCA_VERSION}.tar.gz" | tar -xz --strip 1 \
	&& rm -f Config/Memcache.sample.php

## build the final image
#
FROM "${FROM_IMAGE}"

ARG WEB_ROOT
COPY --from=fetcher "${WEB_ROOT}" "${WEB_ROOT}"

ARG PHP_VERSION
RUN apk -U add --no-cache \
		"php${PHP_VERSION%%.*}-xml"=~"${PHP_VERSION}"

VOLUME "${WEB_ROOT}/Config"
