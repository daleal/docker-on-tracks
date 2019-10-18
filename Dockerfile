FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    # Install apache
    apache2 \
    # Install php 7.2
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-fpm \
    php7.2-gd \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-soap \
    php7.2-sqlite3 \
    php7.2-xml \
    php7.2-zip \
    php7.2-intl \
    php7.2-pgsql \
    php-imagick \
    # Install tools
    openssl \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/* && phpenmod pdo_pgsql

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Remove original config files
RUN rm -rf /etc/apache2 && rm -rf /etc/php

# Copy config files
RUN mkdir /etc/apache2 /etc/php
COPY apache-config-files/apache2/. /etc/apache2
COPY apache-config-files/php/. /etc/php

# Link httpd command to sbin file
RUN ln -s /usr/sbin/apache2ctl /usr/sbin/httpd

# Copy website
COPY ./app /var/www/html

# Add a script to be executed every time the container starts
COPY apache-config-files/entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/opt/entrypoint.sh"]
