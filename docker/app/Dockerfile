# We'll start from a ubuntu xenial
FROM ubuntu:xenial

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

RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  nginx \
  php7.0-fpm \
  php7.0-mysql \
  php7.0-gd \
  php7.0-dev \
  php7.0-curl \
  php7.0-cli \
  php7.0-intl \
  php7.0-json \
  php7.0-common \
  php7.0-mcrypt \
  php7.0-common \
  php7.0-xml \
  php7.0-mbstring \
  php-xdebug \
  php7.0-zip


# Additional PHP config
RUN sed -i  's/;realpath_cache_size =.*$/realpath_cache_size = 8192K/g' /etc/php/7.0/fpm/php.ini
RUN sed -i  's/;realpath_cache_size =.*$/realpath_cache_size = 8192K/g' /etc/php/7.0/cli/php.ini
RUN sed -i  's/;realpath_cache_ttl =.*$/realpath_cache_ttl = 600/g' /etc/php/7.0/fpm/php.ini
RUN sed -i  's/;realpath_cache_ttl =.*$/realpath_cache_ttl = 600/g' /etc/php/7.0/cli/php.ini
ADD conf/xdebug.tpl.conf  /etc/php/7.0/fpm/conf.d/xdebug.tpl.conf
ADD conf/xdebug.tpl.conf  /etc/php/7.0/cli/conf.d/xdebug.tpl.conf
RUN rm -f /etc/php/7.0/fpm/conf.d/20-xdebug.ini
RUN rm -f /etc/php/7.0/cli/conf.d/20-xdebug.ini
RUN echo 'export PHP_IDE_CONFIG="serverName=app"' >> ~/.bashrc
RUN echo 'export PHP_IDE_CONFIG="serverName=app"' >> /var/www/.bashrc

# Timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN mkdir -p /var/www/.composer
RUN chmod -Rf 777 /var/www/.composer

# Install Drush
ENV DRUSH_VERSION 8.1.2
RUN curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar" && \
  chmod +x /usr/local/bin/drush

# Nginx conf
ADD conf/sites-available/*.conf /etc/nginx/sites-available/
ADD conf/snippets/*.conf /etc/nginx/snippets/
RUN ln -s /etc/nginx/sites-available/*.conf /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default
RUN mkdir "/run/php"


RUN wget -O - https://packagecloud.io/gpg.key | sudo apt-key add -
RUN echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list
RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y blackfire-agent

# Used for CMS
# this one for CLI
ENV app_ENVIRONMENT local
# this one for nginx
RUN echo "env[app_ENVIRONMENT] = 'local'" >> /etc/php/7.0/fpm/pool.d/www.conf

# nginx must run in foreground
RUN   echo "daemon off;" >> /etc/nginx/nginx.conf

WORKDIR /var/www

# chown must be done here because before this line, volumes are not mounted yet.
ENTRYPOINT sudo chown -Rf $(whoami):www-data /var/www \
    && sudo chmod -R 777 /var/www/var \
    && sudo /etc/init.d/php7.0-fpm start \
    && sudo nginx

EXPOSE 80 443
