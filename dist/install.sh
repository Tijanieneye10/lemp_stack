#!/bin/bash
# Auto-generated install script

#!/bin/bash

# Output colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
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

# Validate PHP version
validate_php_version() {
    local version="$1"
    case "$version" in
        "8.2"|"8.3"|"8.4")
            ;;
        *)
            error "Invalid PHP version: $version. Supported versions are: 8.2, 8.3, 8.4"
            ;;
    esac
}

# Check prerequisites
check_prerequisites() {
    log "Checking prerequisites..."
    
    # Check if this command is run as root user
    if [ "$EUID" -ne 0 ]; then
        error "Please run as root"
    fi
    
    # Check if apt package manager is installed
    if ! command -v apt &> /dev/null; then
        error "apt package manager not found"
    fi
    
    log "Prerequisites check passed"
}

# Update package list
update_packages() {
    log "Updating package list..."
    apt update
}

# Install common dependencies
install_common_dependencies() {
    log "Installing common dependencies..."
    
    apt install -y \
        wget \
        gnupg \
        lsb-release \
        ca-certificates \
        apt-transport-https \
        software-properties-common \
        unzip
    
    log "Common dependencies installed"
} 
#!/bin/bash

install_nginx() {
    log "Installing Nginx..."
    
    apt install -y nginx
    
    # Start and enable Nginx service
    systemctl start nginx
    systemctl enable nginx
    
    log "Nginx installed and started"
} 
#!/bin/bash

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
#!/bin/bash

install_mysql() {
    log "Installing MySQL 8..."
    
    apt install -y mysql-server
    
    # Start and enable MySQL service
    systemctl start mysql
    systemctl enable mysql
    
    log "MySQL 8 installed and started"
} 
#!/bin/bash

install_composer() {
    log "Installing Composer..."
    
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    
    # Verify that composer is installed successfully
    if ! command -v composer &> /dev/null; then
        error "Composer installation failed"
    fi
    
    log "Composer installed successfully"
}
#!/bin/bash

# Configuration module for Nginx, PHP integration, and final setup

configure_nginx_php() {
    local php_version="$1"
    
    log "Configuring Nginx for PHP $php_version..."
    
    cat > /etc/nginx/sites-available/default << EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.php index.html index.htm;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php${php_version}-fpm.sock;
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
    
    log "Nginx configured for PHP $php_version"
}

# Create test PHP file
create_test_file() {
    log "Creating test PHP file..."
    
    cat > /var/www/html/index.php << 'EOF'
<?php
phpinfo();
?>
EOF
    
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html

    log "Test PHP file created"
}

# Show final instructions
show_final_instructions() {
    local php_version="$1"
    
    log "Configuring MySQL security..."
    warning "You will need to configure MySQL security manually after this script completes."
    warning "Run: sudo mysql_secure_installation"
    
    log "Installation Summary:"
    echo "✅ Nginx installed and configured"
    echo "✅ PHP $php_version with FPM installed"
    echo "✅ MySQL 8 installed"
    echo "✅ Composer installed"
    echo "✅ Test PHP file created at /var/www/html/index.php"
    echo "🌐 Test your installation by visiting: http://your-server-ip"
    echo "🔧 Configure MySQL security: sudo mysql_secure_installation"
    echo "📁 Web root: /var/www/html"
    echo "🔌 PHP-FPM socket: /var/run/php/php${php_version}-fpm.sock"

    log "Installation completed successfully!"
} 
#!/bin/bash

# LEMP Stack Installation Script
# Author: Tijani Usman
# Version: 1.0.0
# Date: 2025-07-13
# License: MIT
# Description: This script installs PHP 8.2/8.3/8.4, MySQL 8, Composer, and Nginx on Ubuntu/Debian Server
# Prerequisites: Ubuntu/Debian Server
# Dependencies: Nginx, PHP 8.2/8.3/8.4, MySQL 8, Composer

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/modules/utils.sh"
source "${SCRIPT_DIR}/modules/nginx.sh"
source "${SCRIPT_DIR}/modules/php.sh"
source "${SCRIPT_DIR}/modules/mysql.sh"
source "${SCRIPT_DIR}/modules/composer.sh"
source "${SCRIPT_DIR}/modules/configuration.sh"


log "Starting LEMP Stack installation..."
exit 1;

main() {
    # Get PHP version from command line argument, if not given use 8.4
    PHP_VERSION="${1:-8.4}"

    # Validate PHP version before processing anything
    validate_php_version "$PHP_VERSION"
    
    log "Starting LEMP Stack installation with PHP $PHP_VERSION..."
    
    # Check prerequisites
    check_prerequisites
    
    # Update package list
    update_packages
    
    # Install common dependencies
    install_common_dependencies
    
    # Install and configure Nginx
    install_nginx
    
    # Install and configure PHP
    install_php "$PHP_VERSION"
    
    # Install and configure MySQL 8
    install_mysql
    
    # Install Composer
    install_composer
    
    # Configure Nginx for PHP
    configure_nginx_php "$PHP_VERSION"
    
    # Create test file
    create_test_file
    
    # Final instructions
    show_final_instructions "$PHP_VERSION"
    
}

# Run main function and pass all arguments
main "$@"