FROM		uhurunet/fedora21
MAINTAINER	Frederick Mbuya "freddie@uhurunet.com"

ADD         bootstrap.sh /usr/bin/
ADD         nginx_ssl.conf /root/
ADD         nginx.conf /root/
ADD			owncloud-7.0.4-2.fc21.noarch.rpm /tmp/
ADD			owncloud-mysql-7.0.4-2.fc21.noarch.rpm /tmp/
ADD			owncloud-nginx-7.0.4-2.fc21.noarch.rpm  /tmp/

RUN         yum update && \
            yum install -y /tmp/owncloud-7.0.4-2.fc21.noarch.rpm /tmp/owncloud-mysql-7.0.4-2.fc21.noarch.rpm /tmp/owncloud-nginx-7.0.4-2.fc21.noarch.rpm
RUN			chown -R www-data:www-data /var/www/owncloud && \
			rm -rf /etc/owncloud && ln -sf /owncloud /etc/owncloud && \

ADD         php.ini /etc/php-fpm.d/
ADD         cron.conf /etc/oc-cron.conf
RUN         crontab /etc/oc-cron.conf

EXPOSE      80
EXPOSE      443

ENTRYPOINT  ["bootstrap.sh"]
