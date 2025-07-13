#! /bin/bash

# LEMP Stack Installation Script
# Installs PHP 8.4, MySQL 8, Composer, and Nginx on Ubuntu/Debian Server
# Author: Tijani Usman
# Version: 1.0.0
# Date: 2025-07-13
# License: MIT
# Description: This script installs PHP 8.4, MySQL 8, Composer, and Nginx on Ubuntu/Debian Server
# Prerequisites: Ubuntu/Debian Server
# Dependencies: Nginx, PHP 8.4, MySQL 8, Composer

set -e

# Output colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
    exit 1
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if this command is run as root user.
if [ "$EUID" -ne 0 ]; then
    error "Please run as root"
fi

#check if app-get package manager is installed
if ! command -v apt &> /dev/null; then
    error "apt package manager not found"
fi

# install common linux packages
app-get update

log "Installing common dependencies..."

apt-get install -y \
    curl \
    wget \
    gnupg \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    unzip

# install nginx and set it process
log "Installing Nginx..."
apt-get install -y nginx


systemctl start nginx
systemctl enable nginx

# Install PHP 8.4 and common extensions
log "Adding PHP repository..."
add-apt-repository ppa:ondrej/php -y
apt-get update -y

log "Installing PHP 8.4 and extensions..."
apt-get install -y \
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

systemctl start php8.4-fpm
systemctl enable php8.4-fpm

log "PHP 8.4 installed and configured"

# Install MySQL 8
log "Installing MySQL 8..."
apt-get install -y mysql-server

systemctl start mysql
systemctl enable mysql

log "MySQL 8 installed and started"

# Install Composer
log "Installing Composer..."
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# confirmed that composer is installed successfully
if ! command -v composer &> /dev/null; then
    error "Composer installation failed"
fi

log "Composer installed successfully"

# Configure Nginx for PHP
log "Configuring Nginx for PHP..."

cat > /etc/nginx/sites-available/default << 'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.php index.html index.htm;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

# Test Nginx configuration
nginx -t

# Reload Nginx
systemctl reload nginx

log "Creating test PHP file..."
cat > /var/www/html/index.php << 'EOF'
<?php
phpinfo();
?>
EOF

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html