#!/bin/bash

# PHP 8.4 installation and configuration module

# Install PHP 8.4 and extensions
install_php() {
    log "Adding PHP repository..."
    add-apt-repository ppa:ondrej/php -y
    apt update -y
    
    log "Installing PHP 8.4 and extensions..."
    apt install -y \
        php8.4 \
        php8.4-fpm \
        php8.4-mysql \
        php8.4-curl \
        php8.4-gd \
        php8.4-mbstring \
        php8.4-xml \
        php8.4-zip \
        php8.4-bcmath \
        php8.4-soap \
        php8.4-intl \
        php8.4-readline \
        php8.4-ldap \
        php8.4-msgpack \
        php8.4-igbinary \
        php8.4-redis \
        php8.4-memcached \
        php8.4-xdebug
    
    # Start and enable PHP-FPM service
    systemctl start php8.4-fpm
    systemctl enable php8.4-fpm
    
    log "PHP 8.4 installed and configured"
} 