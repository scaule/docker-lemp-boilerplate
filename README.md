# Local installation for development

## Prerequisites

Install Docker

Install docker-compose

### Mac

Install Docker for Mac : https://store.docker.com/editions/community/docker-ce-desktop-mac

Install Docker Sync : ```gem install docker-sync```


## Source code

Clone docker repository where you want to work.

```bash
mkdir infotbm
cd infotbm

# needed
git clone  git@git.clever-age.net:keolis/infotbm-tools.git .

# Clone Drupal in infotbm/app

```bash
mkdir app/cms
cd app/cms
git clone https://git.clever-age.net/keolis/infotbm .

# Clone Symfony in infotbm/app

```bash
mkdir app/ws
cd app/ws
git clone https://git.clever-age.net/keolis/infotbm-ws .

## Stack

Add in your hosts file:

127.0.0.1 local.infotbm.fr
```

Run the docker stack:

For Unix users :

```
docker-compose up
```

For Mac users:

```bash
docker-sync-stack start
```

## Applications

Check this URL:

http://local.infotbm.fr

If you need to open a bash on one of the containers:

```bash
# Nginx server
docker exec -i -t infotbm_app  /bin/bash

```

# Local installation for development

Note: this Drupal has been setup using the [drupal-composer project](https://github.com/drupal-composer/drupal-project). Documentation about upgrade, patches, modules, ... is [here](README-COMPOSER.md)


## Installation

Connect to the nginx container and composer install:

```bash
docker exec -it infotbm_app bash
```

```bash
cd /var/www/ws
composer install

cd /var/www/cms
composer install
```

## Development workflow

[Usefull scripts](scripts/)