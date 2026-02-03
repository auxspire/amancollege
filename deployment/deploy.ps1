# Deploy WordPress to VPS (72.61.227.53)
# Run from repo root: .\deployment\deploy.ps1
# You will be prompted for SSH password (unless key-based auth is set up).

$ErrorActionPreference = "Stop"
$VPS = "root@72.61.227.53"
$RepoRoot = Split-Path $PSScriptRoot -Parent
if (-not (Test-Path "$RepoRoot\wp-content\themes\kits-college\style.css")) {
    $RepoRoot = "D:\Work\AmanCollege"
}
Set-Location $RepoRoot

# Generate DB password and salts
$DBPassword = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 24 | ForEach-Object { [char]$_ })
$saltChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:,.<>?"
$genSalt = { -join (1..64 | ForEach-Object { $saltChars[(Get-Random -Maximum $saltChars.Length)] }) }
$salts = @(
    "AUTH_KEY", "SECURE_AUTH_KEY", "LOGGED_IN_KEY", "NONCE_KEY",
    "AUTH_SALT", "SECURE_AUTH_SALT", "LOGGED_IN_SALT", "NONCE_SALT"
) | ForEach-Object { "define( '$_', '" + (& $genSalt) + "' );" }

Write-Host "Step 1: Upload and run PHP install script..."
scp "$RepoRoot\deployment\install-php.sh" "${VPS}:/tmp/"
ssh $VPS "bash /tmp/install-php.sh"

Write-Host "Step 2: Create site directory..."
ssh $VPS "mkdir -p /var/www/aman.auxspire.com && chown -R www-data:www-data /var/www/aman.auxspire.com"

Write-Host "Step 3: Create database and user..."
$mysqlScript = @"
CREATE DATABASE IF NOT EXISTS aman_wp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'aman_wp'@'localhost' IDENTIFIED BY '$DBPassword';
GRANT ALL PRIVILEGES ON aman_wp.* TO 'aman_wp'@'localhost';
FLUSH PRIVILEGES;
"@
Set-Content -Path "$RepoRoot\deployment\aman_init.sql" -Value $mysqlScript
scp "$RepoRoot\deployment\aman_init.sql" "${VPS}:/tmp/"
ssh $VPS "mysql -u root < /tmp/aman_init.sql && rm /tmp/aman_init.sql"
Remove-Item "$RepoRoot\deployment\aman_init.sql" -ErrorAction SilentlyContinue

Write-Host "Step 4: Upload Nginx config and reload..."
scp "$RepoRoot\deployment\nginx-aman-port8080.conf" "${VPS}:/etc/nginx/sites-available/aman.auxspire.com.conf"
ssh $VPS "ln -sf /etc/nginx/sites-available/aman.auxspire.com.conf /etc/nginx/sites-enabled/ && nginx -t && systemctl reload nginx"

Write-Host "Step 5: Download and extract WordPress..."
ssh $VPS "cd /var/www/aman.auxspire.com && wget -q https://wordpress.org/latest.zip -O latest.zip && unzip -q -o latest.zip && mv wordpress/* . ; mv wordpress/.* . 2>/dev/null ; rmdir wordpress 2>/dev/null ; rm -f latest.zip ; chown -R www-data:www-data /var/www/aman.auxspire.com"

Write-Host "Step 6: Create and upload wp-config.php..."
$wpConfig = @"
<?php
define( 'DB_NAME', 'aman_wp' );
define( 'DB_USER', 'aman_wp' );
define( 'DB_PASSWORD', '$DBPassword' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );
define( 'WP_HOME', 'http://72.61.227.53:8080' );
define( 'WP_SITEURL', 'http://72.61.227.53:8080' );
$($salts -join "`n")
`$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) { define( 'ABSPATH', __DIR__ . '/' ); }
require_once ABSPATH . 'wp-settings.php';
"@
$wpConfig | Out-File -FilePath "$RepoRoot\deployment\wp-config-generated.php" -Encoding utf8
scp "$RepoRoot\deployment\wp-config-generated.php" "${VPS}:/var/www/aman.auxspire.com/wp-config.php"
ssh $VPS "chown www-data:www-data /var/www/aman.auxspire.com/wp-config.php && chmod 640 /var/www/aman.auxspire.com/wp-config.php"

Write-Host "Step 7: Upload theme..."
scp -r "$RepoRoot\wp-content\themes\kits-college" "${VPS}:/var/www/aman.auxspire.com/wp-content/themes/"
ssh $VPS "chown -R www-data:www-data /var/www/aman.auxspire.com/wp-content/themes/kits-college"

Write-Host ""
Write-Host "Deployment complete. DB password (save it): $DBPassword"
Write-Host "Open in browser: http://72.61.227.53:8080 and complete the 5-minute install."
Write-Host "In WP Admin: Appearance -> Themes -> Activate 'KITS College'."
