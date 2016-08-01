FROM php:7.0-fpm
MAINTAINER dmitrii.kvaskov@accenture.com


# Install developer dependencies
RUN apt-get update -yqq && apt-get install -y libsqlite3-dev libxml2-dev libicu-dev libfreetype6-dev libmcrypt-dev libjpeg62-turbo-dev libpng12-dev git libcurl4-gnutls-dev libbz2-dev libssl-dev -yqq python python-dev python-distribute python-pip && \
    pip install selenium

# Install php extensions
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_sqlite
RUN docker-php-ext-install opcache
RUN docker-php-ext-install json
RUN docker-php-ext-install calendar
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install xml
RUN docker-php-ext-install zip
RUN docker-php-ext-install bz2
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install curl

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# Install PECL extensions
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN pecl install phar
RUN docker-php-ext-install phar

RUN pecl install intl
RUN docker-php-ext-install intl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN mkdir /var/www/html/pctv-selenium-cucumber
COPY pctv-selenium-cucumber pctv-selenium-cucumber/
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
