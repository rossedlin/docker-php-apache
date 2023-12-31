FROM php:8.3-apache

#
# Install SSH Client
#
RUN apt-get update; \
    apt-get install -y openssh-client; \
    rm -rf /var/lib/apt/lists/*;

#
# Install ZIP
#
RUN apt-get update; \
    apt-get install -y libzip-dev zip; \
    docker-php-ext-install zip; \
    rm -rf /var/lib/apt/lists/*;

##
## Install Vim
##
#RUN apt-get update && \
#    apt-get install -y vim; \
#    rm -rf /var/lib/apt/lists/*;

#
# Install MySQL Client
#
#RUN apt-get update && \
#    apt-get install -y \
#    default-mysql-client; \
#    rm -rf /var/lib/apt/lists/*;

#
# Install Composer
#
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#
# Install MySQL
#
RUN apt-get update; \
    docker-php-ext-install mysqli pdo pdo_mysql; \
    rm -rf /var/lib/apt/lists/*;

#
# Install Imagick
#
RUN apt-get update; \
    apt-get install -y libmagickwand-dev --no-install-recommends; \
    pecl install imagick; \
	docker-php-ext-enable imagick; \
	rm -rf /var/lib/apt/lists/*;

#
# Install Intl
#
RUN apt-get -y update; \
    apt-get install -y libicu-dev; \
    docker-php-ext-configure intl; \
    docker-php-ext-install intl; \
    rm -rf /var/lib/apt/lists/*;

#
# Install mbstring
#
RUN apt-get update; \
    apt-get install -y libonig-dev; \
    docker-php-ext-install mbstring; \
    rm -rf /var/lib/apt/lists/*;

#
# Install GD
#
RUN apt-get update; \
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libgd-dev libpng12-dev; \
    docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/; \
    docker-php-ext-install gd; \
    rm -rf /var/lib/apt/lists/*;

#
# Install BC Math
#
#RUN apt-get update; \
#    docker-php-ext-install bcmath; \
#    rm -rf /var/lib/apt/lists/*; \

#
# Install exif
#
RUN apt-get update; \
    docker-php-ext-install exif; \
    rm -rf /var/lib/apt/lists/*;

##
## Install SSL
##
#RUN apt-get update; \
#    apt install certbot python3-certbot-apache; \
#    docker-php-ext-install sockets; \
#    a2enmod ssl; \
#    rm -rf /var/lib/apt/lists/*;

#
# Install X-Debug - todo: fix x-debug, failed because of v8.3 not yet supported
#
#RUN pecl install xdebug; docker-php-ext-enable xdebug;

#
# Install NodeJS v18
#
RUN cd ~; \
    curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.shapt-get update; \
    chmod +x nodesource_setup.shapt-get; \
    ./nodesource_setup.shapt-get; \
    apt update; \
    apt install -y nodejs build-essential; \
    rm nodesource_setup.shapt-get; \
    rm -rf /var/lib/apt/lists/*;

#
# Install Yarn
#
RUN npm install -g yarn;

#
# Install Firebase Globally
#
RUN npm install -g firebase-tools;

#
# Install JQ - https://stedolan.github.io/jq/
#
RUN apt-get update; \
    apt-get install jq; \
    rm -rf /var/lib/apt/lists/*;

#
# Tweak Apache
#
COPY apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf
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
