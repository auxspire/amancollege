# Preview the site by accessing the VPS

You can preview the WordPress site on the server in two ways. You can type the SSH password when prompted if you haven't set up keys yet.

---

## Option 1: Open the site URL (hosts file or DNS)

Once Nginx and WordPress are set up on the VPS (see [SETUP-VPS.md](SETUP-VPS.md)), you view the site in your browser by opening the domain. No SSH needed for **viewing** (SSH is only for setup).

### If DNS is already set

- Open **http://72.61.227.53:8080** (IP and port; no hosts file or DNS needed).

### If DNS is not set yet (preview before go-live)

Use your **hosts file** so your PC treats `aman.auxspire.com` as the VPS IP:

1. **Edit hosts (as Administrator):**
   - File: **`C:\Windows\System32\drivers\etc\hosts`**
   - Open Notepad as Administrator (right‑click → Run as administrator), then File → Open → go to that path. Choose "All Files" so you can select `hosts`.
   - Add this line at the end (see also [hosts-preview.txt](hosts-preview.txt)):
     ```
     72.61.227.53 aman.auxspire.com
     ```
   - Save.

2. In your browser open: **http://aman.auxspire.com**  
   (Use https only after you run Certbot on the VPS.)

Your machine will send requests for `aman.auxspire.com` to `72.61.227.53`; Nginx will serve the WordPress site. You don't need SSH for this.

---

## Option 2: SSH port forwarding (tunnel)

Use this if you want traffic to go through an SSH tunnel (e.g. you're on a different network). You'll be asked for the SSH password once per tunnel.

1. **Create the tunnel** (run on your PC):

   ```bash
   ssh -L 8080:localhost:8080 root@72.61.227.53
   ```

   Enter the **VPS root password** when prompted. Leave this terminal open while you preview.

2. **Open in browser:** **http://localhost:8080**

Traffic goes: your browser → localhost:8080 → SSH tunnel → VPS port 8080. Nginx on the VPS serves the WordPress site.

To stop the tunnel, press `Ctrl+C` in the SSH terminal or close it.

---

## Summary

| Goal                         | What to do |
|-----------------------------|------------|
| Preview now (IP and port)   | Open **http://72.61.227.53:8080** (no hosts file or SSH). |
| Preview once DNS is live    | Open https://aman.auxspire.com (no SSH). |
| Preview via SSH tunnel      | Run `ssh -L 8080:localhost:8080 root@72.61.227.53`, then open http://localhost:8080. |

You only need to type the SSH password when using Option 2 (tunnel); Option 1 uses the browser only.
