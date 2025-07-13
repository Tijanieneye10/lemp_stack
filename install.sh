#! /bin/bash

# LEMP Stack Installation Script
# Installs PHP 8.4, MySQL 8, Composer, and Nginx on Ubuntu/Debian
# Author: Tijani Usman

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

