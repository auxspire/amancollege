#!/bin/bash
# Install PHP and extensions required for WordPress on the VPS.
# Run on the server: bash install-php.sh
# Or from your machine (after SSH key setup): ssh aman 'bash -s' < install-php.sh

set -e
export DEBIAN_FRONTEND=noninteractive

echo "Updating package lists..."
apt update

echo "Installing PHP FPM and extensions..."
apt install -y \
  php-fpm \
  php-mysql \
  php-curl \
  php-xml \
  php-mbstring \
  php-zip \
  php-gd \
  php-openssl

echo ""
php -v
echo ""
echo "PHP-FPM socket (use this in Nginx fastcgi_pass):"
ls -la /var/run/php/php*-fpm.sock 2>/dev/null || echo "  (check: ls /var/run/php/)"
echo ""
echo "Done. PHP is installed."
