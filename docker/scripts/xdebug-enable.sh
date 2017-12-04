#/bin/bash

# get conf path per php version

if [ "$2" == "70" ] ; then
    PHP_CONF_PATH="/etc/php/fpm/conf.d/"
    PHP_CONF_PATH_CLI="/etc/php/cli/conf.d/"
elif [ "$2" == "71" ]; then
    PHP_CONF_PATH="/etc/php/7.1/fpm/conf.d/"
    PHP_CONF_PATH_CLI="/etc/php/7.1/cli/conf.d/"
fi

#Mac
if [ "$(uname)" == "Darwin" ]; then
  #Create an alias on mac
  sudo ifconfig lo0 alias 10.254.254.254
  HOST_IP=10.254.254.254
else
  #Linux
  HOST_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.Gateway}}{{end}}' $1)
fi



# Enable the extension for fpm
docker exec $1 cp $PHP_CONF_PATH"xdebug.tpl.conf" $PHP_CONF_PATH"20-xdebug.ini"
docker exec $1 sed -i "s/%HOST_IP%/$HOST_IP/g" $PHP_CONF_PATH"20-xdebug.ini"

# Enable the extension for cli
docker exec $1 cp $PHP_CONF_PATH"xdebug.tpl.conf" $PHP_CONF_PATH_CLI"20-xdebug.ini"
docker exec $1 sed -i "s/%HOST_IP%/$HOST_IP/g" $PHP_CONF_PATH_CLI"20-xdebug.ini"

# Restart fpm
docker-compose stop php-fpm
docker-compose up -d php-fpm

echo ""
echo "XDebug enabled !"
echo ""
echo "To use it with PHPStorm:"
echo " menu -> run -> edit configuration"
echo "   button '+' -> php remote debug"
echo "     name: whatever, server: click on '...'"
echo "       servers: new"
echo "         name: app (important !)"
echo "         host: your host, port: 80"
echo "         then apply the path mapping:"
echo "           ../ -> /var/www/"
echo "           etc..."
echo "Now in PHPStorm, click Run/Start listening"
echo ""
