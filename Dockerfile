FROM php:7.4-apache

# Установка необходимых зависимостей и PHP расширений
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    zip \
    libonig-dev \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxpm-dev \
    libfreetype6-dev \
    libzip-dev \
    && docker-php-ext-install -j$(nproc) iconv mbstring mysqli pdo_mysql \
    && pecl channel-update pecl.php.net \
    && pecl install xdebug-2.9.8 \
    && docker-php-ext-enable xdebug

RUN curl -o /tmp/ioncube_loaders.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar -xzf /tmp/ioncube_loaders.tar.gz -C /tmp \
    && mv /tmp/ioncube/ioncube_loader_lin_7.4.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/ \
    && echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20190902/ioncube_loader_lin_7.4.so" > /usr/local/etc/php/conf.d/00-ioncube.ini \
    && rm -rf /tmp/ioncube*

# Конфигурация и установка GD
RUN docker-php-ext-configure gd \
    --with-jpeg \
    --with-webp \
    --with-freetype \
    && docker-php-ext-install -j$(nproc) gd

# Установка ZIP без конфигурации
RUN docker-php-ext-install zip

# Активация mod_rewrite для Apache
RUN a2enmod rewrite

# Установка Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Добавление конфигурационных файлов
ADD configs/php/php.ini /usr/local/etc/php/conf.d/40-custom.ini

# Настройка прав доступа для запуска Apache от непривилегированного пользователя
RUN sed -i 's/^export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=1000/' /etc/apache2/envvars \
    && sed -i 's/^export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=1000/' /etc/apache2/envvars \
    && mkdir -p /var/lock/apache2 /var/run/apache2 \
    && chown -R 1000:1000 /var/lock/apache2 /var/run/apache2 \
    && chmod 777 -R /var/lock/apache2 /var/run/apache2

WORKDIR /var/www/html

EXPOSE 80

# Оставляем стандартную команду, entrypoint переопределяется в docker-compose.yml
CMD ["apache2-foreground"]
