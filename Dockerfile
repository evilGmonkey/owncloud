FROM		uhurunet/fedora21
MAINTAINER	Frederick Mbuya "freddie@uhurunet.com"

ADD         bootstrap.sh /usr/bin/
ADD         nginx_ssl.conf /root/
ADD         nginx.conf /root/
ADD			owncloud-7.0.4-2.fc21.noarch.rpm /tmp/
ADD			owncloud-mysql-7.0.4-2.fc21.noarch.rpm /tmp/
ADD			owncloud-nginx-7.0.4-2.fc21.noarch.rpm  /tmp/
ADD			php-google-apiclient-1.0.6-0.3.beta.fc21.noarch.rpm /tmp/
RUN         yum -y update
RUN         yum install -y cronie /tmp/owncloud-7.0.4-2.fc21.noarch.rpm /tmp/owncloud-mysql-7.0.4-2.fc21.noarch.rpm /tmp/owncloud-nginx-7.0.4-2.fc21.noarch.rpm /tmp/php-google-apiclient-1.0.6-0.3.beta.fc21.noarch.rpm
RUN	    rm -rf /etc/owncloud 
RUN	    ln -sf /owncloud /etc/owncloud 

ADD         php.ini /etc/php-fpm.conf
ADD         cron.conf /etc/oc-cron.conf
RUN         crontab /etc/oc-cron.conf

EXPOSE      80
EXPOSE      443

ENTRYPOINT  ["bootstrap.sh"]
