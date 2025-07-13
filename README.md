# LEMP Stack Installation Script

A comprehensive bash script to automatically install and configure a LEMP (Linux, Nginx, MySQL, PHP) stack on Ubuntu/Debian servers.

## 🚀 Quick Install

Run this command on your Ubuntu server to install the LEMP stack:

```bash
# Install with PHP 8.4 (default)
curl -fsSL https://raw.githubusercontent.com/tijaniusman/lemp_stack/main/install.sh | sudo bash

# Install with specific PHP version
curl -fsSL https://raw.githubusercontent.com/tijaniusman/lemp_stack/main/install.sh | sudo bash -s 8.2
curl -fsSL https://raw.githubusercontent.com/tijaniusman/lemp_stack/main/install.sh | sudo bash -s 8.3
curl -fsSL https://raw.githubusercontent.com/tijaniusman/lemp_stack/main/install.sh | sudo bash -s 8.4
```

## 📋 What's Included

This script installs and configures:

- **Nginx** - Web server
- **PHP 8.2/8.3/8.4** - Choose your PHP version (default: 8.4)
- **MySQL 8** - Database server
- **Composer** - PHP dependency manager

## 🏗️ Modular Structure

The script is organized into modular components for better maintainability:

- **`install.sh`** - Main installation script
- **`modules/utils.sh`** - Utility functions (logging, error handling, prerequisites)
- **`modules/nginx.sh`** - Nginx installation and configuration
- **`modules/php.sh`** - PHP 8.4 installation and extensions
- **`modules/mysql.sh`** - MySQL 8 installation
- **`modules/composer.sh`** - Composer installation
- **`modules/configuration.sh`** - Nginx-PHP integration and final setup
- **`test_modules.sh`** - Test script to verify modular structure

### PHP Extensions Installed

- `php8.4-fpm` - FastCGI Process Manager
- `php8.4-mysql` - MySQL support
- `php8.4-curl` - cURL support
- `php8.4-gd` - Image processing
- `php8.4-mbstring` - Multibyte string support
- `php8.4-xml` - XML support
- `php8.4-zip` - ZIP support
- `php8.4-bcmath` - BCMath support
- `php8.4-soap` - SOAP support
- `php8.4-intl` - Internationalization
- `php8.4-readline` - Readline support
- `php8.4-ldap` - LDAP support
- `php8.4-msgpack` - MessagePack support
- `php8.4-igbinary` - Igbinary support
- `php8.4-redis` - Redis support
- `php8.4-memcached` - Memcached support
- `php8.4-xdebug` - Xdebug for debugging

## 🛠️ Prerequisites

- Ubuntu/Debian server
- Root or sudo access
- Internet connection
- At least 1GB of available disk space

## 🐘 PHP Version Selection

The script supports PHP versions 8.2, 8.3, and 8.4:

- **Default**: PHP 8.4 (if no version specified)
- **8.2**: Stable version with long-term support
- **8.3**: Latest stable version
- **8.4**: Latest development version

**Usage:**

```bash
sudo ./install.sh        # PHP 8.4 (default)
sudo ./install.sh 8.2    # PHP 8.2
sudo ./install.sh 8.3    # PHP 8.3
sudo ./install.sh 8.4    # PHP 8.4
```

## 📦 Manual Installation

If you prefer to install manually:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/tijaniusman/lemp_stack.git
   cd lemp_stack
   ```

2. **Test the modular structure (optional):**

   ```bash
   ./test_modules.sh
   ```

3. **Run the installation script:**

   ```bash
   # Install with PHP 8.4 (default)
   sudo ./install.sh

   # Install with specific PHP version
   sudo ./install.sh 8.2
   sudo ./install.sh 8.3
   sudo ./install.sh 8.4
   ```

## 🔧 Post-Installation Steps

After the script completes, you should:

1. **Configure MySQL security:**

   ```bash
   sudo mysql_secure_installation
   ```

2. **Test the installation:**

   - Visit `http://your-server-ip` in your browser
   - You should see the PHP info page

3. **Optional: Remove the test file:**
   ```bash
   sudo rm /var/www/html/index.php
   ```

## 📁 Default Configuration

- **Web root:** `/var/www/html`
- **Nginx config:** `/etc/nginx/sites-available/default`
- **PHP-FPM socket:** `/var/run/php/php8.4-fpm.sock`
- **MySQL data:** `/var/lib/mysql`

## 🔍 Verification

Check if services are running:

```bash
# Check Nginx status
sudo systemctl status nginx

# Check PHP-FPM status
sudo systemctl status php8.4-fpm

# Check MySQL status
sudo systemctl status mysql

# Check Composer installation
composer --version
```

## 🐛 Troubleshooting

### Common Issues

1. **Permission denied errors:**

   - Ensure you're running the script as root or with sudo

2. **Package not found errors:**

   - Update your package list: `sudo apt update`

3. **Nginx configuration errors:**

   - Test configuration: `sudo nginx -t`
   - Check logs: `sudo tail -f /var/log/nginx/error.log`

4. **PHP-FPM not working:**
   - Check socket file: `ls -la /var/run/php/php8.4-fpm.sock`
   - Restart service: `sudo systemctl restart php8.4-fpm`

## 📝 Logs

The script provides colored output with timestamps:

- 🟢 **Green:** Success messages
- 🔴 **Red:** Error messages
- 🟡 **Yellow:** Warning messages

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

**Tijani Usman**

- GitHub: [@tijaniusman](https://github.com/tijaniusman)
- Version: 1.0.0
- Date: 2025-07-13

## ⚠️ Disclaimer

This script is provided for educational and development purposes. Always test in a development environment before using in production. The author is not responsible for any data loss or system issues that may occur.

## 🔄 Updates

- **v1.0.0** - Initial release with PHP 8.4, MySQL 8, Nginx, and Composer
