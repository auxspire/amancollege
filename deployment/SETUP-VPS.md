# VPS Setup: aman.auxspire.com (WordPress)

Run these steps on the VPS as `root` (or with sudo).

**One-time: use SSH keys so you don’t type the password every time.**  
See [SSH-KEY-SETUP.md](SSH-KEY-SETUP.md). After that you can use `ssh aman` (or `ssh root@72.61.227.53`) without a password.

---

## 1. Stack check / install

### PHP (install if missing)

**Option A – run the install script on the VPS:**

From your machine (after [SSH key setup](SSH-KEY-SETUP.md)):

```bash
scp deployment/install-php.sh root@72.61.227.53:/tmp/
ssh root@72.61.227.53 "bash /tmp/install-php.sh"
```

Or, after SSHing into the VPS, copy-paste and run:

```bash
apt update
apt install -y php-fpm php-mysql php-curl php-xml php-mbstring php-zip php-gd php-openssl
php -v
```

**Option B – use the script in this repo:** Copy [deployment/install-php.sh](install-php.sh) to the server and run `bash install-php.sh`.

Note the PHP version and FPM socket (e.g. `/var/run/php/php8.2-fpm.sock`). If your socket name differs (e.g. `php8.1-fpm.sock`), edit the Nginx config `fastcgi_pass` line in [nginx-aman.auxspire.com.conf](nginx-aman.auxspire.com.conf).

### MySQL/MariaDB

```bash
# Check
mysql --version
# If missing (Ubuntu/Debian):
apt install -y mariadb-server
mysql_secure_installation
```

---

## 2. Site directory and ownership

```bash
mkdir -p /var/www/aman.auxspire.com
chown -R www-data:www-data /var/www/aman.auxspire.com
```

---

## 3. Database

```bash
mysql -u root -p
```

In MySQL:

```sql
CREATE DATABASE aman_wp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'aman_wp'@'localhost' IDENTIFIED BY 'CHOOSE_A_STRONG_PASSWORD';
GRANT ALL PRIVILEGES ON aman_wp.* TO 'aman_wp'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

Replace `CHOOSE_A_STRONG_PASSWORD` with a secure password and save it for `wp-config.php`.

---

## 4. Nginx

Copy the server block to the VPS (or paste contents):

- Local file: `deployment/nginx-aman.auxspire.com.conf`
- On VPS: `/etc/nginx/sites-available/aman.auxspire.com.conf`

If PHP-FPM socket is not `php8.2-fpm.sock`, edit the `fastcgi_pass` line (e.g. `php8.1-fpm.sock`).

Enable and test:

```bash
ln -s /etc/nginx/sites-available/aman.auxspire.com.conf /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx
```

---

## 5. WordPress files

```bash
cd /var/www/aman.auxspire.com
wget -q https://wordpress.org/latest.zip -O latest.zip
apt install -y unzip
unzip -q latest.zip
mv wordpress/* .
mv wordpress/.* . 2>/dev/null || true
rmdir wordpress
rm latest.zip
chown -R www-data:www-data /var/www/aman.auxspire.com
```

---

## 6. wp-config.php

Copy `deployment/wp-config.php.template` to the server as `/var/www/aman.auxspire.com/wp-config.php`, then:

1. Set `DB_NAME`, `DB_USER`, `DB_PASSWORD` to the database name, user, and password from step 3.
2. Replace the placeholder salts with unique values (e.g. from https://api.wordpress.org/secret-key/1.1/salt/ ).
3. Ensure `WP_HOME` and `WP_SITEURL` are `https://aman.auxspire.com`.

Set permissions:

```bash
chown www-data:www-data /var/www/aman.auxspire.com/wp-config.php
chmod 640 /var/www/aman.auxspire.com/wp-config.php
```

---

## 7. SSL (Certbot)

Ensure DNS A record for `aman.auxspire.com` points to `72.61.227.53`, then:

```bash
apt install -y certbot python3-certbot-nginx
certbot --nginx -d aman.auxspire.com -d www.aman.auxspire.com
```

Follow prompts. Certbot will configure HTTPS and redirect HTTP to HTTPS.

---

## 8. Finish install (browser or VPS terminal)

**If DNS is set (or you use hosts file):** Open http://aman.auxspire.com and complete the 5-minute install in the browser; then Appearance → Themes → Activate "KITS College".

**If DNS is not set:** Complete the install from the VPS terminal (no browser) using WP-CLI. See [INSTALL-VIA-VPS-TERMINAL.md](INSTALL-VIA-VPS-TERMINAL.md) and run [complete-wp-install-on-vps.sh](complete-wp-install-on-vps.sh) on the server.

---

## 9. Theme deployment

From your local machine (in the AmanCollege repo), upload the theme:

```bash
# From D:\Work\AmanCollege (or project root)
scp -r wp-content/themes/kits-college root@72.61.227.53:/var/www/aman.auxspire.com/wp-content/themes/
ssh root@72.61.227.53 "chown -R www-data:www-data /var/www/aman.auxspire.com/wp-content/themes/kits-college"
```

Then in WP Admin: Appearance → Themes → Activate "KITS College".

---

---

## 10. DNS (do before or with SSL)

In your DNS provider for **auxspire.com**:

- Add **A record**: `aman.auxspire.com` → `72.61.227.53`
- Optionally add **A record**: `www.aman.auxspire.com` → `72.61.227.53`

Wait for propagation (a few minutes to 48 hours) before running Certbot. Test with: `curl -I http://aman.auxspire.com`

---

## Summary

| Item          | Value                        |
|---------------|------------------------------|
| Site URL      | https://aman.auxspire.com    |
| Document root | /var/www/aman.auxspire.com   |
| Nginx config  | /etc/nginx/sites-available/aman.auxspire.com.conf |
| DB name       | aman_wp (or your choice)     |
