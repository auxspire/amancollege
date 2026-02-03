# Complete WordPress install via VPS terminal (no DNS, no browser)

Use this when DNS is not set up. You run commands **on the VPS** (via SSH) to finish the WordPress install and activate the theme — no browser or hosts file needed.

---

## 1. SSH into the VPS

From your PC:

```bash
ssh root@72.61.227.53
# or: ssh aman
```

---

## 2. Option A – Run the install script on the VPS

**From your PC** (script is in the repo), pipe the script over SSH:

```powershell
Get-Content D:\Work\AmanCollege\deployment\complete-wp-install-on-vps.sh | ssh root@72.61.227.53 "bash -s YourAdminPassword"
```

Replace `YourAdminPassword` with the admin password you want for the WordPress admin user. Or set it via env and run without argument:

```powershell
$env:WP_ADMIN_PASSWORD = "YourAdminPassword"
Get-Content D:\Work\AmanCollege\deployment\complete-wp-install-on-vps.sh | ssh root@72.61.227.53 "bash -s"
```

**Or copy the script to the VPS and run there:**

```bash
# From your PC: upload script
scp D:\Work\AmanCollege\deployment\complete-wp-install-on-vps.sh root@72.61.227.53:/tmp/

# SSH in and run (set password when prompted by script, or pass as argument)
ssh root@72.61.227.53
export WP_ADMIN_PASSWORD="YourAdminPassword"
bash /tmp/complete-wp-install-on-vps.sh
```

The script will:

- Install WP-CLI if missing
- Run `wp core install` (site URL, title, admin user, password, email)
- Activate the **KITS College** theme
- Set permalinks and fix ownership

Then open **http://72.61.227.53:8080** in your browser (admin: `/wp-admin`).

---

## 3. Option B – Run WP-CLI commands by hand on the VPS

SSH into the VPS, then:

```bash
# Install WP-CLI if you don't have it
curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/aman.auxspire.com

# Complete WordPress install (use your chosen admin password and email)
wp core install \
  --url="http://72.61.227.53:8080" \
  --title="Aman College" \
  --admin_user=admin \
  --admin_password="YOUR_ADMIN_PASSWORD" \
  --admin_email="admin@example.com" \
  --skip-email \
  --allow-root

# Activate theme
wp theme activate kits-college --allow-root

# Permalinks
wp rewrite structure '/%postname%/' --allow-root
wp rewrite flush --allow-root

chown -R www-data:www-data /var/www/aman.auxspire.com
```

Replace `YOUR_ADMIN_PASSWORD` and `admin@example.com` with your values.

---

## 4. After DNS is set

- Point **aman.auxspire.com** to **72.61.227.53** (A record).
- In WordPress: **Settings → General** set **WordPress Address** and **Site Address** to `https://aman.auxspire.com`.
- On the VPS run Certbot for HTTPS:  
  `certbot --nginx -d aman.auxspire.com -d www.aman.auxspire.com`

---

## Summary

| Step | Where | Action |
|------|--------|--------|
| 1 | Your PC | `ssh root@72.61.227.53` (or `ssh aman`) |
| 2 | VPS | Run [complete-wp-install-on-vps.sh](complete-wp-install-on-vps.sh) with admin password, or run the `wp core install` and `wp theme activate` commands above |
| 3 | When DNS ready | Add A record, then in WP set URLs to https and run Certbot |

No browser and no DNS are required for the install; everything is done from the VPS terminal.
