FROM php:7.4-apache

#
# Install Vim
#
RUN apt-get update && \
    apt-get install -y vim; \
    rm -rf /var/lib/apt/lists/*;

#
# Install ZIP
#
RUN apt-get update; \
    apt-get install -y libzip-dev zip; \
    docker-php-ext-install zip; \
    rm -rf /var/lib/apt/lists/*;

#
# Install SSH Client
#
RUN apt-get update; \
    apt-get install -y openssh-client; \
    rm -rf /var/lib/apt/lists/*;

#
# Install MySQL
#
RUN apt-get update; \
    docker-php-ext-install mysqli pdo pdo_mysql; \
    apt-get install -y default-mysql-client; \
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
    docker-php-ext-install gd; \
    rm -rf /var/lib/apt/lists/*;

#
# Install BC Math
#
RUN apt-get update; \
    docker-php-ext-install bcmath; \
    rm -rf /var/lib/apt/lists/*;

#
# Install SSL
#
RUN apt-get update; \
    apt install certbot python3-certbot-apache; \
    docker-php-ext-install sockets; \
    a2enmod ssl; \
    rm -rf /var/lib/apt/lists/*;

#
# Install Composer
#
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#
# Install NodeJS & NPM
#
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh; \
    chmod +x nodesource_setup.sh; \
    ./nodesource_setup.sh; \
    apt-get update; \
    apt-get install -y nodejs; \
    rm -rf /var/lib/apt/lists/*;

#
# Install Yarn
#
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -; \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list; \
    apt-get update; \
    apt-get install -y yarn; \
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
