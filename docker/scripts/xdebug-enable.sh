#/bin/bash

# Create an alias on mac ip
sudo ifconfig lo0 alias 10.254.254.254
HOST_IP=10.254.254.254

# Enable the extension
docker exec symfony_app cp /etc/php/7.0/fpm/conf.d/xdebug.tpl.conf /etc/php/7.0/fpm/conf.d/20-xdebug.ini
docker exec symfony_app sed -i "s/%HOST_IP%/$HOST_IP/g" /etc/php/7.0/fpm/conf.d/20-xdebug.ini
docker exec symfony_app cp /etc/php/7.0/cli/conf.d/xdebug.tpl.conf /etc/php/7.0/cli/conf.d/20-xdebug.ini
docker exec symfony_app sed -i "s/%HOST_IP%/$HOST_IP/g" /etc/php/7.0/cli/conf.d/20-xdebug.ini

# Restart fpm
docker exec symfony_app sudo /etc/init.d/php7.0-fpm restart

echo ""
echo "XDebug enabled !"
echo ""
echo "To use it with PHPStorm:"
echo " menu -> run -> edit configuration"
echo "   button '+' -> php remote debug"
echo "     name: whatever, server: click on '...'"
echo "       servers: new"
echo "         name: robin (important !)"
echo "         host: 127.0.0.1, port: 9000"
echo "         then apply the path mapping:"
echo "           .../user -> /var/www/user"
echo "           .../cms -> /var/www/cms"
echo "           etc..."
echo "Now in PHPStorm, click Run/Start listening"
echo ""

