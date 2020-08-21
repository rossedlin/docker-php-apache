FROM php:7.3-apache

##
## Install Libraries
##
#RUN apt-get update && apt-get install -y \
#    git; \
#    rm -rf /var/lib/apt/lists/*;


#
# Update PHP v7.3
#
RUN docker-php-ext-install mysqli;

#RUN yum -y update; \
#    yum-config-manager --enable remi-php73; \
#    yum install -y php \
#    php-mbstring \
#    php-mcrypt \
#    php-dom \
#    php-cli \
#    php-gd \
#    php-curl \
#    php-mysql \
#    php-ldap \
#    php-zip \
#    php-unzip \
#    php-fileinfo; \
#    yum clean all; \
#    rm -rf /var/cache/yum;

##
## Install Composer
##
#RUN curl -sS https://getcomposer.org/installer | php; \
#    mv composer.phar /usr/local/bin/composer;
#
##
## Install NodeJS & NPM
##
#RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -; \
#    yum -y update; \
#    yum -y install nodejs; \
#    yum clean all; \
#    rm -rf /var/cache/yum;
#
##
## Cleanup
##
#RUN rm -Rf /tmp; \
#    mkdir /tmp;
#
##
## Setup Httpd & PHP
##
#RUN rm -R /var/www; \
#    rm /etc/httpd/conf.d/welcome.conf;
#
#COPY ./httpd/httpd.conf /etc/httpd/conf/httpd.conf
#COPY ./php/php-production.ini /etc/php.ini
COPY html /var/www/html
#RUN mkdir /tmp/file_upload
#
##
## Perms
##
#RUN chmod 777 -R /tmp
#RUN chmod 777 -R /var/www

#
# Finish
#
#WORKDIR /var/www
#EXPOSE 80
#CMD apachectl -D FOREGROUND