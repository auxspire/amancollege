# Switch WordPress on VPS to port 8080 (run from repo root or deployment folder)
# Prerequisite: Hostinger firewall rule for TCP 8080 added in hPanel

$ErrorActionPreference = "Stop"
$VPS = "root@72.61.227.53"
$RepoRoot = Split-Path $PSScriptRoot -Parent
if (-not (Test-Path "$RepoRoot\deployment\nginx-aman-port8080.conf")) {
    $RepoRoot = "D:\Work\AmanCollege"
}

Write-Host "Step 1: Upload Nginx 8080 config..."
scp "$RepoRoot\deployment\nginx-aman-port8080.conf" "${VPS}:/etc/nginx/sites-available/aman.auxspire.com.conf"

Write-Host "Step 2: Reload Nginx and update WordPress URLs to 8080..."
ssh $VPS "nginx -t && systemctl reload nginx && sed -i 's/:3082/:8080/g' /var/www/aman.auxspire.com/wp-config.php && cd /var/www/aman.auxspire.com && wp option update home 'http://72.61.227.53:8080' --allow-root 2>/dev/null; wp option update siteurl 'http://72.61.227.53:8080' --allow-root 2>/dev/null; echo Done"

Write-Host ""
Write-Host "Done. Open in browser: http://72.61.227.53:8080"
Start-Process "http://72.61.227.53:8080"
