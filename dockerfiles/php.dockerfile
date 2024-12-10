FROM php:8-fpm-alpine

# Define user and group arguments
ARG UID
ARG GID

# Install required system dependencies and PHP extensions
RUN apk add --no-cache \
        libxml2-dev \
        oniguruma-dev \
        zip \
        curl \
        bash \
    && docker-php-ext-install \
        pdo_mysql \
        mbstring \
        dom \
        xml \
        zip \
    && rm -rf /var/cache/apk/*

# Add user and group, set up the working directory
RUN addgroup -g ${GID} --system laravel \
    && adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel \
    && mkdir -p /var/www/html \
    && chown -R laravel:laravel /var/www/html

# Set working directory
WORKDIR /var/www/html

# Install Composer from the official image
COPY --from=composer:2.6 /usr/bin/composer /usr/local/bin/composer

# Configure PHP-FPM
RUN sed -i "s/user = www-data/user = laravel/g" /usr/local/etc/php-fpm.d/www.conf \
    && sed -i "s/group = www-data/group = laravel/g" /usr/local/etc/php-fpm.d/www.conf \
    && echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

# Use the non-root user
USER laravel

# Start PHP-FPM
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
