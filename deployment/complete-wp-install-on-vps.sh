#!/bin/bash
# Complete WordPress install from VPS terminal (no browser, no DNS needed).
# Run on the VPS: bash complete-wp-install-on-vps.sh
# Or from your PC: ssh root@72.61.227.53 'bash -s' < deployment/complete-wp-install-on-vps.sh
#
# Set admin password (required):
#   export WP_ADMIN_PASSWORD="YourSecurePassword"
#   bash complete-wp-install-on-vps.sh
# Or pass as first argument: bash complete-wp-install-on-vps.sh "YourSecurePassword"

set -e
SITE_ROOT="/var/www/aman.auxspire.com"
URL="http://72.61.227.53:8080"
TITLE="Aman College"
ADMIN_USER="admin"
ADMIN_EMAIL="admin@aman.auxspire.com"

# Admin password: env WP_ADMIN_PASSWORD or first argument
WP_ADMIN_PASSWORD="${WP_ADMIN_PASSWORD:-$1}"
if [ -z "$WP_ADMIN_PASSWORD" ]; then
  echo "Set admin password: export WP_ADMIN_PASSWORD=\"YourPassword\" or: bash $0 \"YourPassword\""
  exit 1
fi

# Install WP-CLI if missing
if ! command -v wp &>/dev/null; then
  echo "Installing WP-CLI..."
  curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp
  wp --info --allow-root >/dev/null 2>&1 || true
fi

cd "$SITE_ROOT"

# Run WordPress install (creates admin user and finalizes DB)
echo "Running WordPress core install..."
wp core install \
  --url="$URL" \
  --title="$TITLE" \
  --admin_user="$ADMIN_USER" \
  --admin_password="$WP_ADMIN_PASSWORD" \
  --admin_email="$ADMIN_EMAIL" \
  --skip-email \
  --allow-root

# Activate KITS College theme
echo "Activating KITS College theme..."
wp theme activate kits-college --allow-root

# Permalinks
wp rewrite structure '/%postname%/' --allow-root
wp rewrite flush --allow-root

# Fix ownership
chown -R www-data:www-data "$SITE_ROOT"

echo ""
echo "Done. WordPress is installed (no browser needed)."
echo "  Site URL: $URL"
echo "  Admin: $ADMIN_USER (password as set above)"
echo "  Theme: KITS College (active)"
echo "Open in browser: $URL (admin: /wp-admin). When DNS is set, update Settings -> General to https://aman.auxspire.com"
