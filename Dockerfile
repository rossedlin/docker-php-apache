FROM php:7.1-apache

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
# Install Imagick
#
RUN apt-get update; \
    apt-get install -y libmagickwand-dev --no-install-recommends; \
    pecl install imagick; \
	docker-php-ext-enable imagick; \
	rm -rf /var/lib/apt/lists/*;

#
# Install mbstring
#
RUN docker-php-ext-install mbstring

#
# Install GD
#
RUN docker-php-ext-install gd

#
# Tweak Apache
#
COPY apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY php/php.ini-development /usr/local/etc/php/php.ini
COPY public /var/www/public

RUN a2enmod rewrite;
RUN rm -R /var/www/html
RUN mkdir /tmp/file_upload

#
# Perms
#
RUN chmod 777 -R /tmp
RUN chmod 777 -R /tmp/file_upload
RUN chmod 777 -R /var/www

#
# Finish
#
WORKDIR /var/www
