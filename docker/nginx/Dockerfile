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

RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  nginx

# Timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Nginx conf
ADD conf/sites-available/*.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/*.conf /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default

# nginx must run in foreground
RUN   echo "daemon off;" >> /etc/nginx/nginx.conf

# chown must be done here because before this line, volumes are not mounted yet.
ENTRYPOINT sudo nginx

EXPOSE 80 443