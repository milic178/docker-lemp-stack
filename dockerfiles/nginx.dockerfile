FROM nginx:stable-alpine

# Define user and group arguments
ARG UID
ARG GID

# Add user and group, and set up the directory
RUN addgroup -g ${GID} --system laravel \
    && adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel \
    && mkdir -p /var/www/html \
    && chown -R laravel:laravel /var/www/html

# Add Nginx configuration
COPY ./nginx/default.conf /etc/nginx/conf.d/

# Switch to non-root user
USER laravel
