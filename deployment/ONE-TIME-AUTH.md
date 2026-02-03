# One-time authentication for VPS

Do this **once**. After that, SSH and SCP to the VPS use your key and **never ask for a password** — so you only authenticate once, and scripts (or the assistant) can run necessary commands without you typing anything.

---

## Easiest: run the single-sign script (one password, then never again)

From the repo root, in PowerShell:

```powershell
.\deployment\setup-single-sign.ps1
```

You will be asked for the **VPS root password once**. The script will create an SSH key (if you don't have one), install it on the VPS, and add `Host aman` to your SSH config. After that, **no password is ever asked again** for `ssh` or `scp` to this VPS.

---

## What you get

- **One-time:** You type the VPS password only once (when copying your key to the server).
- **After that:** Every `ssh root@72.61.227.53` or `scp ... root@72.61.227.53` uses your key automatically — no password prompt.
- **Scripts:** Commands like `.\deployment\deploy.ps1` run without asking for a password.

There is no separate "token" to copy — the **SSH key pair** on your machine is the credential. Once the public key is on the VPS, that machine is trusted.

---

## Steps (do once)

### 1. Create an SSH key (if you don't have one)

In **PowerShell** or **Git Bash**:

```powershell
# Check for existing key
Get-ChildItem $env:USERPROFILE\.ssh -ErrorAction SilentlyContinue

# If you see id_ed25519.pub or id_rsa.pub, skip to step 2.
# If not, generate a key (press Enter for defaults; passphrase optional):
ssh-keygen -t ed25519 -C "aman-vps" -f "$env:USERPROFILE\.ssh\id_ed25519"
```

### 2. Copy your public key to the VPS (only time you type the password)

**Option A – ssh-copy-id (e.g. Git Bash / WSL):**

```bash
ssh-copy-id root@72.61.227.53
```

Enter the **VPS root password** when prompted. Done.

**Option B – Manual (PowerShell):**

```powershell
# Show your public key and copy the entire line (starts with ssh-ed25519 or ssh-rsa)
Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub
```

Then connect with password **one last time** and add the key:

```bash
ssh root@72.61.227.53
# Enter password

mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "PASTE_THE_FULL_LINE_YOU_COPIED" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
exit
```

Paste the full line (e.g. `ssh-ed25519 AAAAC3... user@host`) in place of `PASTE_THE_FULL_LINE_YOU_COPIED`.

### 3. Optional: SSH config so you can use `ssh aman`

Edit (or create) **`C:\Users\<YourUsername>\.ssh\config`** and add:

```
Host aman
    HostName 72.61.227.53
    User root
    IdentityFile ~/.ssh/id_ed25519
```

If your key is `id_rsa`, use `IdentityFile ~/.ssh/id_rsa`.

### 4. Verify — no password should be asked

```powershell
ssh root@72.61.227.53 "echo OK"
# Or, if you added the config: ssh aman "echo OK"
```

If you see `OK` and were **not** prompted for a password, one-time auth is done. From now on, any `ssh` or `scp` to this VPS will work without a password.

---

## Summary

| Step | Action |
|------|--------|
| 1 | Create key with `ssh-keygen` (if needed) |
| 2 | Copy public key to VPS: `ssh-copy-id root@72.61.227.53` **or** paste into `~/.ssh/authorized_keys` on VPS (type password once) |
| 3 | (Optional) Add `Host aman` to `~/.ssh/config` |
| 4 | Test: `ssh root@72.61.227.53 "echo OK"` — no prompt |

After this, you only authenticated once; the key is used for all later commands.
