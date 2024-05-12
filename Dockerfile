FROM php:8.2-fpm
MAINTAINER nipen
ARG user
ARG uid
# Install Dependencies
RUN apt-get update && apt-get install -y git curl libpng-dev libonig-dev libxml2-dev zip unzip

RUN apt-get install -y wget dpkg fontconfig libfreetype6 libjpeg62-turbo libxrender1 xfonts-75dpi xfonts-base mariadb-client

#install some base extensions
RUN apt-get install -y \
    libzip-dev \
    zip \
    zlib1g-dev\
    && docker-php-ext-install zip \
    && docker-php-ext-install gd
# Clear Cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql intl mbstring exif pcntl bcmath gd

COPY .docker/app/php-fpm.ini /usr/local/etc/php/conf.d/php-fpm.ini
# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user

# Set working directory
WORKDIR /var/www
RUN chown -R www-data:www-data /var/www
USER $user
