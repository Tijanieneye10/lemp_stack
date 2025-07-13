#!/bin/bash

# Nginx installation and configuration module

# Install Nginx
install_nginx() {
    log "Installing Nginx..."
    
    apt install -y nginx
    
    # Start and enable Nginx service
    systemctl start nginx
    systemctl enable nginx
    
    log "Nginx installed and started"
} 