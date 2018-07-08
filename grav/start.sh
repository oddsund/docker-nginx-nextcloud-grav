#!/bin/sh

GRAV_VERSION=1.4.6
GRAV_URL=https://getgrav.org/download/core/grav-admin/${GRAV_VERSION}
GRAV_FOLDER=grav-admin

mkdir -p /usr/share/nginx/grav

if [ ! -d /usr/share/nginx/grav/system ] ; then
    wget -q -O /tmp/grav.zip $GRAV_URL
    cd /tmp
    unzip -q grav.zip
    cp -r /tmp/$GRAV_FOLDER/* /usr/share/nginx/grav
    cp /usr/share/nginx/grav/webserver-configs/nginx.conf /etc/nginx/conf.d/grav.conf
    chown -R nginx:nginx /usr/share/nginx/grav
    sed -i "s/pwd_regex: .*/pwd_regex: '.{10,}'/g" /usr/share/nginx/grav/system/config/system.yaml
    sed -i 's/root \/home\/USER\/www\/html;/root \/usr\/share\/nginx\/grav;/g' /etc/nginx/conf.d/grav.conf
    sed -i 's/fastcgi_pass unix:\/var\/run\/php\/php7.0-fpm.sock;/fastcgi_pass unix:\/var\/run\/php7-fpm.sock;/g' /etc/nginx/conf.d/grav.conf
    rm /etc/nginx/conf.d/default.conf
fi

chown -R nginx:nginx /usr/share/nginx/grav

find /usr/share/nginx/grav -type f | xargs chmod 664
find /usr/share/nginx/grav -type d | xargs chmod 775
find /usr/share/nginx/grav -type d | xargs chmod +s

# start php-fpm
if [ -f /etc/php7/php-fpm.d/www.conf ] ; then
	rm /etc/php7/php-fpm.d/www.conf
fi

mkdir -p /usr/logs/php-fpm
php-fpm7

# start nginx
mkdir -p /usr/logs/nginx
mkdir -p /tmp/nginx
chown nginx /tmp/nginx
nginx -g "daemon off;"
