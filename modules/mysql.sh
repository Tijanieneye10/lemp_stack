install_mysql() {
    log "Installing MySQL 8..."
    
    apt install -y mysql-server
    
    # Start and enable MySQL service
    systemctl start mysql
    systemctl enable mysql
    
    log "MySQL 8 installed and started"
} 