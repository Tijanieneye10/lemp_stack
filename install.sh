#!/bin/bash

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

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all module files
source "${SCRIPT_DIR}/modules/utils.sh"
source "${SCRIPT_DIR}/modules/nginx.sh"
source "${SCRIPT_DIR}/modules/php.sh"
source "${SCRIPT_DIR}/modules/mysql.sh"
source "${SCRIPT_DIR}/modules/composer.sh"
source "${SCRIPT_DIR}/modules/configuration.sh"

# Main installation function
main() {
    log "Starting LEMP Stack installation..."
    
    # Check prerequisites
    check_prerequisites
    
    # Update package list
    update_packages
    
    # Install common dependencies
    install_common_dependencies
    
    # Install and configure Nginx
    install_nginx
    
    # Install and configure PHP 8.4
    install_php
    
    # Install and configure MySQL 8
    install_mysql
    
    # Install Composer
    install_composer
    
    # Configure Nginx for PHP
    configure_nginx_php
    
    # Create test file
    create_test_file
    
    # Final instructions
    show_final_instructions
    
   
}

# Run main function
main "$@"