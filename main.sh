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