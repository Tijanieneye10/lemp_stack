#!/bin/bash

# PHP installation and configuration module

# Install PHP and common extensions
install_php() {
    local php_version="$1"
    
    log "Adding PHP repository..."
    add-apt-repository ppa:ondrej/php -y
    apt update -y
    
    log "Installing PHP $php_version and extensions..."
    apt install -y \
        php${php_version} \
        php${php_version}-fpm \
        php${php_version}-mysql \
        php${php_version}-curl \
        php${php_version}-gd \
        php${php_version}-mbstring \
        php${php_version}-xml \
        php${php_version}-zip \
        php${php_version}-bcmath \
        php${php_version}-soap \
        php${php_version}-intl \
        php${php_version}-readline \
        php${php_version}-ldap \
        php${php_version}-msgpack \
        php${php_version}-igbinary \
        php${php_version}-redis \
        php${php_version}-memcached \
        php${php_version}-xdebug
    
    # Start and enable PHP-FPM service
    systemctl start php${php_version}-fpm
    systemctl enable php${php_version}-fpm
    
    log "PHP $php_version installed and configured"
} 