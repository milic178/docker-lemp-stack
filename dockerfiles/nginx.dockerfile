FROM nginx:stable-alpine

ARG UID
ARG GID

# Add user and group for Nginx
RUN addgroup -g ${GID} --system chargemap \
    && adduser -G chargemap --system -D -s /bin/sh -u ${UID} chargemap \
    && sed -i "s/user  nginx/user chargemap/g" /etc/nginx/nginx.conf \
    && mkdir -p /var/www/html \
    && chown -R chargemap:chargemap /var/www/html

# Add custom Nginx configuration
COPY ./nginx/default.conf /etc/nginx/conf.d/
