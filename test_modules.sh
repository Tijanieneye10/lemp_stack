#!/bin/bash

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Testing LEMP Stack modular structure..."

# Source all module files
echo "Sourcing modules..."
source "${SCRIPT_DIR}/modules/utils.sh"
source "${SCRIPT_DIR}/modules/nginx.sh"
source "${SCRIPT_DIR}/modules/php.sh"
source "${SCRIPT_DIR}/modules/mysql.sh"
source "${SCRIPT_DIR}/modules/composer.sh"
source "${SCRIPT_DIR}/modules/configuration.sh"

echo "✅ All modules sourced successfully"

# Test that functions are available
echo "Testing function availability..."

# Test utility functions
if declare -f log > /dev/null; then
    echo "✅ log function available"
else
    echo "❌ log function not found"
    exit 1
fi

if declare -f error > /dev/null; then
    echo "✅ error function available"
else
    echo "❌ error function not found"
    exit 1
fi

if declare -f warning > /dev/null; then
    echo "✅ warning function available"
else
    echo "❌ warning function not found"
    exit 1
fi

if declare -f validate_php_version > /dev/null; then
    echo "✅ validate_php_version function available"
else
    echo "❌ validate_php_version function not found"
    exit 1
fi

# Test installation functions
if declare -f install_nginx > /dev/null; then
    echo "✅ install_nginx function available"
else
    echo "❌ install_nginx function not found"
    exit 1
fi

if declare -f install_php > /dev/null; then
    echo "✅ install_php function available"
else
    echo "❌ install_php function not found"
    exit 1
fi

if declare -f install_mysql > /dev/null; then
    echo "✅ install_mysql function available"
else
    echo "❌ install_mysql function not found"
    exit 1
fi

if declare -f install_composer > /dev/null; then
    echo "✅ install_composer function available"
else
    echo "❌ install_composer function not found"
    exit 1
fi

if declare -f configure_nginx_php > /dev/null; then
    echo "✅ configure_nginx_php function available"
else
    echo "❌ configure_nginx_php function not found"
    exit 1
fi

# Test PHP version validation
echo "Testing PHP version validation..."

# Test valid versions
for version in "8.2" "8.3" "8.4"; do
    if validate_php_version "$version" 2>/dev/null; then
        echo "✅ PHP version $version validation works"
    else
        echo "❌ PHP version $version validation failed"
        exit 1
    fi
done

# Test invalid version (should fail)
echo "Testing invalid PHP version (should fail gracefully)..."
if (validate_php_version "8.1" 2>/dev/null); then
    echo "❌ Invalid PHP version should have been rejected"
    exit 1
else
    echo "✅ Invalid PHP version correctly rejected"
fi

echo ""
echo "🎉 All tests passed! Modular structure is working correctly."
echo "Usage examples:"
echo "  sudo ./install.sh        # Install with PHP 8.4 (default)"
echo "  sudo ./install.sh 8.2    # Install with PHP 8.2"
echo "  sudo ./install.sh 8.3    # Install with PHP 8.3"
echo "  sudo ./install.sh 8.4    # Install with PHP 8.4" 