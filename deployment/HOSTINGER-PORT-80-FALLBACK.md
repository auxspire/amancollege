# If port 8080 is also blocked (Hostinger)

If **http://72.61.227.53:8080** still refuses to connect even with the firewall rule, Hostinger may only allow **22, 80, 443** at the network level. Use **port 80** by proxying through Caddy.

## Option: Serve WordPress on port 80 via Caddy

Your VPS already has **Caddy** (Docker) on ports 80 and 443. Add a Caddy block so that requests to the server IP (or a hostname) are proxied to Nginx (WordPress).

### 1. On the VPS: Nginx listen on localhost only

So Nginx doesn’t need a public port; only Caddy talks to it.

```bash
# Edit the Nginx server block so it listens on 127.0.0.1:3082 only
sudo sed -i 's/listen 8080;/listen 127.0.0.1:3082;/' /etc/nginx/sites-available/aman.auxspire.com.conf
sudo sed -i 's/listen \[::]:8080;/# listen [::]:8080;/' /etc/nginx/sites-available/aman.auxspire.com.conf
# Or manually edit: listen 127.0.0.1:3082; and comment out the [::]:8080 line.
sudo nginx -t && sudo systemctl reload nginx
```

### 2. Caddy: proxy by IP or hostname

Edit the Caddyfile (e.g. `/root/supabase/docker/Caddyfile` or wherever your Caddy config lives). Add a block so that when someone visits **http://72.61.227.53** (port 80), Caddy forwards to Nginx:

```caddy
# Respond to requests to the VPS IP (port 80)
:80 {
    @by_ip host 72.61.227.53
    handle @by_ip {
        reverse_proxy 127.0.0.1:3082
    }
    # ... rest of your existing :80 blocks (other sites)
}
```

If Caddy uses **named hosts** only, add a block that matches the IP:

```caddy
72.61.227.53 {
    reverse_proxy 127.0.0.1:3082
}
```

Reload Caddy (e.g. restart the Caddy container or `docker restart supabase-caddy`).

### 3. WordPress URLs

In WordPress **Settings → General**, set:

- **WordPress Address (URL):** `http://72.61.227.53`
- **Site Address (URL):** `http://72.61.227.53`

(No port; traffic comes in on port 80.)

### 4. Test

Open **http://72.61.227.53** in your browser (no port). You should see the WordPress site.

---

**Summary:** Nginx serves WordPress on **127.0.0.1:3082**; Caddy on **port 80** proxies to it. No custom port needed; Hostinger’s open port 80 is used.
