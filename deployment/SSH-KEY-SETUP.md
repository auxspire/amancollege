# SSH key setup: authenticate once, then no password

After this one-time setup, `ssh`, `scp`, and `rsync` to the VPS will use your key and **not ask for a password** each time.

---

## 1. Generate an SSH key (if you don’t have one)

On your **local machine** (PowerShell or Git Bash):

```bash
# Check for existing key
dir $env:USERPROFILE\.ssh
# Look for id_ed25519 / id_ed25519.pub or id_rsa / id_rsa.pub

# If none, generate (Ed25519 recommended)
ssh-keygen -t ed25519 -C "your-email@example.com" -f "$env:USERPROFILE\.ssh\id_ed25519"
# Press Enter for default path; set a passphrase or leave empty
```

If you already have `id_ed25519.pub` or `id_rsa.pub`, skip to step 2.

---

## 2. Copy your public key to the VPS (one-time password)

**Option A – ssh-copy-id (if available):**

```bash
ssh-copy-id root@72.61.227.53
# Enter the VPS root password once. After this, key login works.
```

**Option B – Manual (Windows / when ssh-copy-id is missing):**

```powershell
# Show your public key (copy the whole line)
Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub
# Or: type %USERPROFILE%\.ssh\id_ed25519.pub
```

Then on the **VPS** (SSH in with password one last time):

```bash
ssh root@72.61.227.53
# Enter password when prompted

mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "PASTE_YOUR_PUBLIC_KEY_LINE_HERE" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
exit
```

Replace `PASTE_YOUR_PUBLIC_KEY_LINE_HERE` with the full line from `id_ed25519.pub` (starts with `ssh-ed25519 ...`).

---

## 3. Add SSH config (optional but useful)

On your **local machine**, edit (or create) `C:\Users\<YourUsername>\.ssh\config` and add:

```
Host aman
    HostName 72.61.227.53
    User root
    IdentityFile ~/.ssh/id_ed25519
```

If your key is `id_rsa`, use `IdentityFile ~/.ssh/id_rsa` instead.

Then you can connect with:

```bash
ssh aman
```

No password after the first time (and no need to type `root@72.61.227.53`).

---

## 4. Test passwordless login

```bash
ssh aman
# or: ssh root@72.61.227.53
```

If it logs in without asking for a password, setup is done. Use `ssh aman`, `scp`, and `rsync` as needed; they will all use the key.

---

## Quick reference

| Step | What to do |
|------|------------|
| 1 | `ssh-keygen -t ed25519 ...` (if no key yet) |
| 2 | `ssh-copy-id root@72.61.227.53` **or** paste public key into VPS `~/.ssh/authorized_keys` |
| 3 | Add `Host aman` block to `~/.ssh/config` |
| 4 | `ssh aman` — no password from now on |

**VPS:** 72.61.227.53, user **root**.  
**After setup:** `ssh aman` (or `ssh root@72.61.227.53`) with no password.
