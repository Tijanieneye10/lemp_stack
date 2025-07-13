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

# Add PHP repository (Ondrej's PPA for latest PHP versions)
log "Adding PHP repository..."
add-apt-repository ppa:ondrej/php -y
apt-get update -y

# Install PHP 8.4 and common extensions
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