# Local installation for development

## Prerequisites

Install Docker

Install docker-compose

### Mac

Install Docker for Mac : https://store.docker.com/editions/community/docker-ce-desktop-mac

Install Docker Sync : ```gem install docker-sync```

## Installation
Execute init script : 
```
chmod a+x init-docker.sh && ./init-docker.sh
```
## Hosts

Add in your hosts file:

127.0.0.1 local.symfony.fr
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







[Usefull scripts](scripts/)