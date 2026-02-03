# Switch WordPress to port 8080 (do this once)

We switched the project to **port 8080** so Hostinger firewall can allow it. Do these steps once.

## 1. Hostinger firewall

In **hPanel → VPS → Security → Firewall**, add (or edit) a rule:

- **Action:** Accept  
- **Protocol:** TCP  
- **Port:** **8080**  
- **Source:** Anywhere  

Save and ensure the firewall is active.

## 2. On the VPS: use the 8080 Nginx config and WordPress URLs

**Option A – run the script (easiest):**

From your PC (PowerShell, repo root):

```powershell
.\deployment\switch-to-8080.ps1
```

**Option B – run commands by hand:**

```powershell
scp D:\Work\AmanCollege\deployment\nginx-aman-port8080.conf root@72.61.227.53:/etc/nginx/sites-available/aman.auxspire.com.conf
ssh root@72.61.227.53 "nginx -t && systemctl reload nginx && sed -i 's/:3082/:8080/g' /var/www/aman.auxspire.com/wp-config.php && cd /var/www/aman.auxspire.com && wp option update home 'http://72.61.227.53:8080' --allow-root 2>/dev/null; wp option update siteurl 'http://72.61.227.53:8080' --allow-root 2>/dev/null; echo Done"
```

## 3. Open the site

In your browser open: **http://72.61.227.53:8080**

If 8080 is still refused, use the port-80 fallback: [HOSTINGER-PORT-80-FALLBACK.md](HOSTINGER-PORT-80-FALLBACK.md).
