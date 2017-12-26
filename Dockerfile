FROM ubuntu:14.04
MAINTAINER MACROMIND Online <idc@macromind.online>
LABEL description="MACROMIND Online Dev - Ubuntu + Apache2 + PHP 5.5"

RUN apt-get update && apt-get -y install git curl apache2 php5 php5-mysql php5-mcrypt php5-json php5-imap libapache2-mod-php5 && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork
RUN /usr/sbin/a2enmod rewrite
RUN chown www-data:www-data /usr/sbin/apachectl && chown www-data:www-data /var/www/html/
RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl
RUN /usr/bin/curl -sS https://getcomposer.org/installer |/usr/bin/php
RUN /bin/mv composer.phar /usr/local/bin/composer
RUN chown www-data:www-data /usr/sbin/apachectl && chown www-data:www-data /var/www/html/

COPY apache2-foreground /usr/local/bin/

ENV APACHE_LOCK_DIR "/var/lock"
ENV APACHE_RUN_DIR "/var/run/apache2"
ENV APACHE_PID_FILE "/var/run/apache2/apache2.pid"
ENV APACHE_RUN_USER "www-data"
ENV APACHE_RUN_GROUP "www-data"
ENV APACHE_LOG_DIR "/var/log/apache2"

EXPOSE 80
EXPOSE 443

WORKDIR /var/www/html/

CMD ["apache2-foreground"]
