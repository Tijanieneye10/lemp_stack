#!/bin/bash

# Composer installation module

# Install Composer
install_composer() {
    log "Installing Composer..."
    
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    
    # Verify that composer is installed successfully
    if ! command -v composer &> /dev/null; then
        error "Composer installation failed"
    fi
    
    log "Composer installed successfully"
} 