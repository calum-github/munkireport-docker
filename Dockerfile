# Dockerfile for MunkiReport-PHP v3


# Version 2.0 - 31-08-2018
# MR-PHP Version 3.2.2 (March 24, 2018)
FROM debian:stretch

MAINTAINER Calum Hunter <calum.h@gmail.com>

# The version of Munki report to download
ENV MR_VERS v3.2.2.tar.gz

# Set Environmental variables
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV TZ Australia/Melbourne

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

# Install base packages for MR
RUN apt-get update && \
	apt-get -y install \
	apt-transport-https \
	lsb-release \
	ca-certificates \
	wget && \
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list && \
	apt-get update && \
	apt-get -y install \
	nginx \
	nano \
	curl \
	vim \
	git \
	zip \
	unzip \
	php-pear \
	libmcrypt-dev \
	libreadline-dev \
	php7.2 \
	php7.2-dev \
	php7.2-cli \
	php7.2-common \
	php7.2-curl \
	php7.2-fpm \
	php7.2-gd \
	php7.2-json \
	php7.2-ldap \
	php7.2-mbstring \
	php7.2-mysql \
	php7.2-opcache \
	php7.2-readline \
	php7.2-soap \
	php7.2-xml \
	php7.2-zip \
	libcurl4-openssl-dev \
	zlib1g-dev \
	libxml2-dev \
	libcurl3-dev && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN pecl channel-update pecl.php.net && \
	pecl install mcrypt-1.0.1

# Make folder for enabled sites in nginx
# Add line to php config to prevent blank page, fix PHP CGI pathinfo
RUN mkdir -p /www/munkireport && \
	mkdir -p /etc/nginx/sites-enabled/ && \
	rm -rf /etc/nginx/sites-enabled/* && \
	rm -rf /etc/nginx/nginx.conf 
#&& sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini

# Grab our Munki Report Release defined in MR_VERS from Github, unpack it and remove the tarball
ADD https://github.com/munkireport/munkireport-php/archive/$MR_VERS /www/munkireport/$MR_VERS
RUN tar -zxvf /www/munkireport/$MR_VERS --strip-components=1 -C /www/munkireport && \
	rm /www/munkireport/$MR_VERS

# Install dependencies
RUN cd /www/munkireport && \
	/usr/local/bin/composer install --no-plugins --no-scripts

# Add our config.php file and nginx configs
#ADD config.php /www/munkireport/config.php
ADD munki-report.conf /etc/nginx/sites-enabled/munki-report.conf
ADD nginx.conf /etc/nginx/nginx.conf

# Set up logs to output to stout and stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Add our startup script
ADD start.sh /start.sh
RUN chmod +x /start.sh

# Expose Ports
EXPOSE 80 443

# Run our startup script
CMD ["/start.sh"]