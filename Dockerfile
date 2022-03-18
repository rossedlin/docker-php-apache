FROM php:5.5-apache

#
# Install ZIP
#
RUN apt-get update && \
    apt-get install -y \
    libzip-dev \
    zip; \
    docker-php-ext-install zip; \
    rm -rf /var/lib/apt/lists/*;

#
# Install MySQL
#
RUN docker-php-ext-install mysqli pdo pdo_mysql;

#
# Tweak Apache
#
RUN a2enmod rewrite;
COPY ./apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
#RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
COPY public /var/www/public
RUN rm -R /var/www/html
#RUN mkdir /tmp/file_upload

#
# Perms
#
RUN chmod 777 -R /tmp
RUN chmod 777 -R /var/www

#
# Finish
#
WORKDIR /var/www
