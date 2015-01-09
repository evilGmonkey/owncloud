#!/bin/sh

#touch /var/log/nginx/access.log
#touch /var/log/nginx/error.log
#touch /var/log/cron/owncloud.log

if [ -z "$SSL_CERT" ]; then
    echo "\nCopying nginx.conf without SSL support..\n"
    cp /root/nginx.conf /etc/nginx/nginx.conf
else
    echo "\nCopying nginx.conf with SSL support..\n"
    sed -i "s#-x-replace-cert-x-#$SSL_CERT#" /root/nginx_ssl.conf
    sed -i "s#-x-replace-key-x-#$SSL_KEY#" /root/nginx_ssl.conf
    cp /root/nginx_ssl.conf /etc/nginx/nginx.conf
fi
chown -R nginx:nginx /var/www/owncloud /owncloud
echo "Starting server..\n"

tail -F /var/log/nginx/*.log /var/log/cron/owncloud.log &

#/usr/sbin/crond -f &
#/usr/sbin/php5-fpm
/usr/sbin/nginx
/bin/bash
