FROM php:8.1-apache

#
# Install SSH Client
#
RUN apt update; \
    apt --no-install-recommends install -y openssh-client; \
    rm -rf /var/lib/apt/lists/*;

#
# Install ZIP
#
RUN apt update; \
    apt --no-install-recommends install -y libzip-dev zip unzip; \
    docker-php-ext-install zip; \
    rm -rf /var/lib/apt/lists/*;

#
# Install Vim
#
RUN apt update && \
    apt --no-install-recommends install -y vim; \
    rm -rf /var/lib/apt/lists/*;

#
# Install MySQL Client
#
RUN apt update && \
    apt --no-install-recommends install -y \
    default-mysql-client; \
    rm -rf /var/lib/apt/lists/*;

#
# Install Composer
#
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#
# Install MySQL
#
RUN apt update && docker-php-ext-install mysqli pdo pdo_mysql && rm -rf /var/lib/apt/lists/*;

#
# Install Imagick
#
RUN apt update; \
    apt --no-install-recommends install -y libmagickwand-dev --no-install-recommends; \
    pecl install imagick; \
	docker-php-ext-enable imagick; \
	rm -rf /var/lib/apt/lists/*;

#
# Install Intl
#
RUN apt -y update; \
    apt --no-install-recommends install -y libicu-dev; \
    docker-php-ext-configure intl; \
    docker-php-ext-install intl; \
    rm -rf /var/lib/apt/lists/*;

#
# Install mbstring
#
RUN apt update; \
    apt --no-install-recommends install -y libonig-dev; \
    docker-php-ext-install mbstring; \
    rm -rf /var/lib/apt/lists/*;

#
# Install GD
#
RUN apt update; \
    apt --no-install-recommends install -y libfreetype6-dev libjpeg62-turbo-dev libgd-dev libpng12-dev; \
    docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/; \
    docker-php-ext-install gd; \
    rm -rf /var/lib/apt/lists/*;

#
# Install BC Math
#
RUN apt update; \
    docker-php-ext-install bcmath; \
    rm -rf /var/lib/apt/lists/*; \

#
# Install exif
#
RUN apt update; \
    docker-php-ext-install exif; \
    rm -rf /var/lib/apt/lists/*;

##
## Install SSL
##
#RUN apt update; \
#    apt --no-install-recommends install certbot python3-certbot-apache; \
#    docker-php-ext-install sockets; \
#    a2enmod ssl; \
#    rm -rf /var/lib/apt/lists/*;

#
# Install X-Debug
#
RUN pecl install xdebug; docker-php-ext-enable xdebug;

#
# Install NodeJS v18
#
WORKDIR /root
RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.shapt update; \
    chmod +x nodesource_setup.shapt; \
    ./nodesource_setup.shapt; \
    apt update; \
    apt --no-install-recommends install -y nodejs build-essential; \
    rm nodesource_setup.shapt; \
    rm -rf /var/lib/apt/lists/*;

#
# Install Yarn
#
RUN npm install --ignore-scripts -g yarn;

#
# Install Firebase Globally
#
RUN npm install --ignore-scripts -g firebase-tools;

#
# Install JQ - https://stedolan.github.io/jq/
#
RUN apt update; \
    apt --no-install-recommends install -y jq; \
    rm -rf /var/lib/apt/lists/*;

#
# Tweak Apache
#
COPY apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY php/php.ini /usr/local/etc/php/php.ini
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
