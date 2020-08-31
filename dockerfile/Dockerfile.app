FROM php:7.4-fpm

# Copy composer.lock and composer.json
#COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www
COPY wp /usr/local/bin

# Install dependencies
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list && rm -Rf /var/lib/apt/lists/* && apt update && apt install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev libonig-dev\
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl mariadb-client-core*\
    libxml2-dev libzip-dev\
# Clear cache
&& apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get purge -y --auto-remove \
# Install extensions
&& docker-php-ext-install pdo_mysql mbstring zip exif pcntl mysqli gd \
&& docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
&& pecl install redis && docker-php-ext-enable redis && pecl install xdebug && docker-php-ext-enable xdebug \
# Install composer
&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \


# Add user for laravel application
&& groupadd -g 1000 www && useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www
RUN wp package install aaemnnosttv/wp-cli-login-command
# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]