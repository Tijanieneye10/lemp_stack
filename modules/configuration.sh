#!/bin/bash

# Configuration module for Nginx, PHP integration, and final setup

# Configure Nginx for PHP
configure_nginx_php() {
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
    
    log "Nginx configured for PHP"
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
    log "Configuring MySQL security..."
    warning "You will need to configure MySQL security manually after this script completes."
    warning "Run: sudo mysql_secure_installation"
    
    log "Installation Summary:"
    echo "✅ Nginx installed and configured"
    echo "✅ PHP 8.4 with FPM installed"
    echo "✅ MySQL 8 installed"
    echo "✅ Composer installed"
    echo "✅ Test PHP file created at /var/www/html/index.php"
    echo "🌐 Tst your installation by visiting: http://your-server-ip"
    echo "🔧 Configure MySQL security: sudo mysql_secure_installation"
    echo "📁 Web root: /var/www/html"

     log "Installation completed successfully!"
} 