#/bin/bash

if [ "$2" == "70" ] ; then
    PHP_CONF_PATH="/etc/php/fpm/conf.d/"
    PHP_CONF_PATH_CLI="/etc/php/cli/conf.d/"
elif [ "$2" == "71" ]; then
    PHP_CONF_PATH="/etc/php/7.1/fpm/conf.d/"
    PHP_CONF_PATH_CLI="/etc/php/7.1/cli/conf.d/"
fi

# Enable the extension
docker exec $1 sudo rm $PHP_CONF_PATH"20-xdebug.ini"
docker exec $1 sudo rm $PHP_CONF_PATH_CLI"20-xdebug.ini"

# Restart fpm
docker-compose stop php-fpm
docker-compose up -d php-fpm

echo ""
echo "XDebug disabled !"
echo ""
