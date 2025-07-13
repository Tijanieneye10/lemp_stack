#!/bin/bash

# Contains logging, error handling, and common checks

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