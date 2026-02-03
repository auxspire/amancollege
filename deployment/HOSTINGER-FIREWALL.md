# Hostinger VPS: Open port 8080 for WordPress

The site is at **http://72.61.227.53:8080**. If the page does not load, check these **three layers** in order.

---

## Layer 1: Hostinger VPS firewall (hPanel)

1. **hPanel** → **VPS** → select your server → **Security** → **Firewall**.
2. If you see **no firewall** or no rules:
   - Click **Add Firewall** (or similar), give it a name, create it.
   - Then **Edit** that firewall and add a rule.
3. Add a rule:
   - **Action:** Accept  
   - **Protocol:** TCP  
   - **Port:** `8080`  
   - **Source:** Anywhere  
4. Save and ensure this firewall configuration is **active**.

---

## Layer 2: OS firewall inside the VPS (Ubuntu)

SSH into the VPS and run:

```bash
sudo ufw status verbose
```

- If **UFW is active**, allow the port:

  ```bash
  sudo ufw allow 8080/tcp
  sudo ufw reload
  ```

- If **UFW is inactive** (as on this VPS), Layer 2 is not blocking; no change needed.

---

## Layer 3: Service listening on 8080

On the VPS, verify something is listening on that port:

```bash
sudo ss -tulpn | grep 8080
# or
sudo netstat -tulpn | grep 8080
```

You should see **nginx** bound to **0.0.0.0:8080** (not only 127.0.0.1). If nothing is listening:

- Start Nginx: `sudo systemctl start nginx`
- Ensure the Nginx config for this site uses `listen 8080;` and `listen [::]:8080;` (not `127.0.0.1:8080` only).

---

## Status on this VPS (checked via SSH)

| Layer | Status |
|-------|--------|
| **1 – Hostinger panel** | You add the rule in hPanel (Accept TCP 8080, source Anywhere). If there is no firewall, create one first, then add the rule. |
| **2 – UFW** | Inactive — not blocking. |
| **3 – Service** | Nginx is listening on **0.0.0.0:8080** — OK. |

After Layer 1 is set in hPanel, try **http://72.61.227.53:8080** again.

---

## If 8080 is still blocked (connection refused)

Some providers only allow **22, 80, 443**. Use **port 80** instead: have Caddy (already on 80) proxy to WordPress. See [HOSTINGER-PORT-80-FALLBACK.md](HOSTINGER-PORT-80-FALLBACK.md).
