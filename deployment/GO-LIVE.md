# Go-live checklist: aman.auxspire.com

## Before go-live

1. **DNS**: A record(s) for `aman.auxspire.com` (and `www.aman.auxspire.com`) pointing to `72.61.227.53`. Wait for propagation.
2. **VPS**: Complete [SETUP-VPS.md](SETUP-VPS.md) (Nginx, PHP, MySQL, WordPress, SSL via Certbot).
3. **Theme**: Upload and activate KITS College theme; set logo and menus.
4. **Content**: Follow [content-migration/CONTENT-MIGRATION.md](../content-migration/CONTENT-MIGRATION.md) — create pages, assign templates, paste content, upload media.

## After go-live

- Test `https://aman.auxspire.com` and `https://aman.auxspire.com/wp-admin`.
- Set **Settings → Permalinks** to “Post name” and save (if not already).
- Consider a backup plugin (e.g. UpdraftPlus) or cron backup for files and database.
- Keep WordPress and plugins updated.

## Quick reference

| Item        | Value                     |
|------------|---------------------------|
| VPS        | 72.61.227.53 (root)       |
| Site URL   | https://aman.auxspire.com |
| Nginx conf | `/etc/nginx/sites-available/aman.auxspire.com.conf` |
| Doc root   | `/var/www/aman.auxspire.com` |
