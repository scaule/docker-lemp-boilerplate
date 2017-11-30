#/bin/bash

# Enable the extension
docker exec robin_nginx sudo rm /etc/php/7.1/fpm/conf.d/20-xdebug.ini
docker exec robin_nginx sudo rm /etc/php/7.1/cli/conf.d/20-xdebug.ini

# Restart fpm
docker exec robin_nginx sudo /etc/init.d/php7.1-fpm restart

echo ""
echo "XDebug disabled !"
echo ""
