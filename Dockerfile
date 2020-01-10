ARG PHP_VERSION=7.3

FROM moonbuggy2000/alpine-s6-nginx-php-fpm:php${PHP_VERSION}

ARG PMCA_VERSION=1.3.0

RUN . /etc/contenv_extra \
	&& add-contenv PMCA_VERSION=${PMCA_VERSION} \
	&& apk --update add --no-cache --virtual .build-deps \
		curl \
		tar \
	&& mkdir -p ${WEB_ROOT} \
	&& curl -o PHPMemcachedAdmin.tar.gz -L https://github.com/elijaa/phpmemcachedadmin/archive/${PMCA_VERSION}.tar.gz \
	&& tar -xf PHPMemcachedAdmin.tar.gz -C ${WEB_ROOT} --strip 1 \
	&& rm -f PHPMemcachedAdmin.tar.gz \
	&& rm -f ${WEB_ROOT}/Config/Memcache.sample.php \
	&& apk add --no-cache \
		${PHP_PACKAGE}-xml=~${PHP_VERSION} \
	&& apk del .build-deps

VOLUME ${WEB_ROOT}/Config
