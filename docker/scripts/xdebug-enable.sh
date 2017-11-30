#/bin/bash

#Mac
if [ "$(uname)" == "Darwin" ]; then
  #Create an alias on mac
  sudo ifconfig lo0 alias 10.254.254.254
  HOST_IP=10.254.254.254
#Linux
else
  HOST_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.Gateway}}{{end}}' infotbm_nginx)
fi



# Enable the extension
docker exec infotbm_nginx cp /etc/php/7.1/fpm/conf.d/xdebug.tpl.conf /etc/php/7.1/fpm/conf.d/20-xdebug.ini
docker exec infotbm_nginx sed -i "s/%HOST_IP%/$HOST_IP/g" /etc/php/7.1/fpm/conf.d/20-xdebug.ini
docker exec infotbm_nginx cp /etc/php/7.1/cli/conf.d/xdebug.tpl.conf /etc/php/7.1/cli/conf.d/20-xdebug.ini
docker exec infotbm_nginx sed -i "s/%HOST_IP%/$HOST_IP/g" /etc/php/7.1/cli/conf.d/20-xdebug.ini

# Restart fpm
docker exec infotbm_nginx sudo /etc/init.d/php7.1-fpm restart

echo ""
echo "XDebug enabled !"
echo ""
echo "To use it with PHPStorm:"
echo " menu -> run -> edit configuration"
echo "   button '+' -> php remote debug"
echo "     name: whatever, server: click on '...'"
echo "       servers: new"
echo "         name: infotbm (important !)"
echo "         host: admin.local.infotbm.fr, port: 80"
echo "         then apply the path mapping:"
echo "           .../admin -> /var/www/admin"
echo "           .../cms -> /var/www/cms"
echo "           etc..."
echo "Now in PHPStorm, click Run/Start listening"
echo ""
