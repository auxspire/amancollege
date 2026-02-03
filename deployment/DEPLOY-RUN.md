# Run deployment to VPS

The script [deploy.ps1](deploy.ps1) performs steps 1–7 of the plan on the VPS.

**Single sign (recommended):** Run `.\deployment\setup-single-sign.ps1` once — you type the VPS password **once**, then never again. See [ONE-TIME-AUTH.md](ONE-TIME-AUTH.md). After that, `.\deployment\deploy.ps1` and any `ssh`/`scp` run without prompts.

## Run

From the **repo root** (`D:\Work\AmanCollege`), in PowerShell:

```powershell
.\deployment\deploy.ps1
```

Enter the **root** password when prompted (for each upload/command until the script finishes).

## After the script

1. **Save the DB password** – the script prints it at the end (e.g. `DB password (save it): xxxxx`).
2. **Browser** – open **http://72.61.227.53:8080** and complete the WordPress 5-minute install (language, site title, admin user, password, email).
4. **Theme** – in WP Admin go to **Appearance → Themes** and activate **KITS College**.

## If step 3 (database) fails

If the VPS MySQL root user has a password, run the SQL yourself on the server:

```bash
ssh root@72.61.227.53
mysql -u root -p
# Enter root password, then in MySQL:
```

```sql
CREATE DATABASE IF NOT EXISTS aman_wp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'aman_wp'@'localhost' IDENTIFIED BY 'CHOOSE_A_STRONG_PASSWORD';
GRANT ALL PRIVILEGES ON aman_wp.* TO 'aman_wp'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

Then edit `/var/www/aman.auxspire.com/wp-config.php` on the VPS and set `DB_PASSWORD` to the same password. Re-run from step 4 onward if needed, or only fix wp-config.
