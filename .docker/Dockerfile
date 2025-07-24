FROM php:8.2-apache

# Установка необходимых зависимостей и PHP расширений
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    zip \
    unzip \
    vim \
    libonig-dev \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxpm-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev \
    libbz2-dev \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        calendar \
        exif \
        gettext \
        intl \
        mbstring \
        mysqli \
        opcache \
        pcntl \
        pdo_mysql \
        soap \
        sockets \
        zip \
    && pecl channel-update pecl.php.net \
    && pecl install xdebug-3.3.1 \
    && docker-php-ext-enable xdebug \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Установка IonCube для PHP 8.2
RUN curl -o /tmp/ioncube_loaders.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar -xzf /tmp/ioncube_loaders.tar.gz -C /tmp \
    && PHP_EXT_DIR=$(php-config --extension-dir) \
    && cp /tmp/ioncube/ioncube_loader_lin_8.2.so $PHP_EXT_DIR/ \
    && echo "zend_extension=ioncube_loader_lin_8.2.so" > /usr/local/etc/php/conf.d/00-ioncube.ini \
    && rm -rf /tmp/ioncube*

# Конфигурация и установка GD с поддержкой современных форматов
RUN docker-php-ext-configure gd \
    --with-jpeg \
    --with-webp \
    --with-freetype \
    && docker-php-ext-install -j$(nproc) gd

# Активация mod_rewrite и других необходимых модулей для Apache
RUN a2enmod rewrite expires headers ssl deflate mime

# Установка Composer последней версии
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Добавление конфигурационных файлов
COPY .docker/configs/php/php.ini /usr/local/etc/php/conf.d/99-custom.ini
COPY .docker/configs/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Настройка прав доступа для запуска Apache от непривилегированного пользователя
RUN sed -i 's/^export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=1000/' /etc/apache2/envvars \
    && sed -i 's/^export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=1000/' /etc/apache2/envvars \
    && mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/apache2 \
    && chown -R 1000:1000 /var/lock/apache2 /var/run/apache2 /var/log/apache2 \
    && chmod 755 /var/lock/apache2 /var/run/apache2 /var/log/apache2

# Создание директории для логов PHP
RUN mkdir -p /var/log/php && chown -R 1000:1000 /var/log/php

WORKDIR /var/www/html

EXPOSE 80

# Оставляем стандартную команду, entrypoint переопределяется в docker-compose.yml
CMD ["apache2-foreground"]
