FROM php:7.3-apache

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

##
## Install Libraries
##
#RUN apt-get update && apt-get install -y \
#    git; \
#    rm -rf /var/lib/apt/lists/*;

#RUN apt-get update -y && apt-get install -y \
#    sendmail \
#    libpng-dev; \
#    rm -rf /var/lib/apt/lists/*;
#
#RUN apt-get update && \
#    apt-get install -y \
#    zlib1g-dev; \
#    rm -rf /var/lib/apt/lists/*;

#
#
#
#RUN docker-php-ext-install exif




#
# Tweak Apache
#
RUN a2enmod rewrite;
COPY ./apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
COPY public /var/www/public
RUN rm -R /var/www/html
#RUN mkdir /tmp/file_upload

#
# Perms
#
#RUN chmod 777 -R /tmp
RUN chmod 777 -R /var/www

#
# Finish
#
WORKDIR /var/www
