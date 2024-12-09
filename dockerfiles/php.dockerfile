FROM php:8-fpm-alpine

# Define user and group arguments
ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

# Create user and group, set up the working directory
RUN mkdir -p /var/www/html \
    && addgroup -g ${GID} --system laravel \
    && adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel \
    && chown -R laravel:laravel /var/www/html

# Set working directory
WORKDIR /var/www/html

# Install Composer from the official image
COPY --from=composer:2.6 /usr/bin/composer /usr/local/bin/composer

# Update PHP-FPM configuration for the laravel user
RUN sed -i "s/user = www-data/user = laravel/g" /usr/local/etc/php-fpm.d/www.conf \
    && sed -i "s/group = www-data/group = laravel/g" /usr/local/etc/php-fpm.d/www.conf \
    && echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

# Install necessary PHP extensions for MariaDB and PHPUnit dependencies
RUN apk add --no-cache --virtual .build-deps \
        autoconf \
        g++ \
        make \
        libxml2-dev \
        oniguruma-dev \
        curl \
    && docker-php-ext-install \
        pdo_mysql \
        mbstring \
        dom \
        xml \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del .build-deps

# Switch to the non-root user
USER laravel

# Start PHP-FPM
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
