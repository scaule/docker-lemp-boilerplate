# Local installation for development

## Prerequisites

Install Docker

Install docker-compose

### Mac

Install Docker for Mac : https://store.docker.com/editions/community/docker-ce-desktop-mac

Install Docker Sync : ```gem install docker-sync```

## Installation
##On mac install docker-sync : 
```
chmod a+x docker.sh && ./docker.sh install
```
##Set configuration parameter of your project :
 Update file env-conf and replace default by your application name and list plugins you want to use like :
 ```
APPLICATION_NAME=my_application
PLUGINS=mailcatcher/elk
 ```
##Execute init script : 
```
chmod a+x docker.sh && ./docker.sh init
```

Copy your project in app folder 

Check nginx config in docker/app/conf/site-available

## Hosts

Add in your hosts file:
```
127.0.0.1 local.default.fr
```

Run the docker stack:

```
./docker.sh start
```
