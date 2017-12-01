# We'll start from a ubuntu xenial
FROM debian:stable-slim

# Install base packages
RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  curl \
  wget \
  acl \
  apt-transport-https \
  lsb-release \
  sudo \
  locales \
  ca-certificates \
  vim \
  git \
  mysql-client

RUN apt-get install apt-transport-https lsb-release ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  nginx \
  php7.1-fpm \
  php7.1-mysql \
  php7.1-gd \
  php7.1-dev \
  php7.1-curl \
  php7.1-cli \
  php7.1-intl \
  php7.1-json \
  php7.1-common \
  php7.1-mcrypt \
  php7.1-common \
  php7.1-xml \
  php7.1-mbstring \
  php-xdebug \
  php7.1-zip


# Additional PHP config
ADD ./conf/php.ini /usr/local/etc/php/7.1/fpm/conf.d
RUN rm -rf /etc/php/7.1/fpm/pool.d/*
ADD ./conf/www.conf /etc/php/7.1/fpm/pool.d/
ADD conf/xdebug.tpl.conf  /etc/php/7.1/fpm/conf.d/xdebug.tpl.conf
ADD conf/xdebug.tpl.conf  /etc/php/7.1/cli/conf.d/xdebug.tpl.conf
RUN rm -f /etc/php/7.1/fpm/conf.d/20-xdebug.ini
RUN rm -f /etc/php/7.1/cli/conf.d/20-xdebug.ini
RUN echo 'export PHP_IDE_CONFIG="serverName=app"' >> ~/.bashrc
RUN echo 'export PHP_IDE_CONFIG="serverName=app"' >> /var/www/.bashrc
RUN mkdir /run/php

# Timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN mkdir -p /var/www/.composer
RUN chmod -Rf 777 /var/www/.composer

# Used for CMS
# this one for CLI
ENV app_ENVIRONMENT local

WORKDIR /var/www

CMD ["php-fpm7.1", "-F"]

EXPOSE 9000
