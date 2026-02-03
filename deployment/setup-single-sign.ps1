# Single-sign SSH setup: type VPS password ONCE, never again
# Run from repo root or deployment folder: .\deployment\setup-single-sign.ps1

$VPS = "root@72.61.227.53"
$sshDir = Join-Path $env:USERPROFILE ".ssh"
$keyFile = Join-Path $sshDir "id_ed25519"
$pubFile = Join-Path $sshDir "id_ed25519.pub"

# 1. Ensure .ssh exists
if (-not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
    Write-Host "Created $sshDir"
}

# 2. Generate key if missing
if (-not (Test-Path $pubFile)) {
    Write-Host "Generating SSH key (no passphrase so scripts can run without prompts)..."
    ssh-keygen -t ed25519 -C "aman-vps" -f $keyFile -N '""'
    if (-not (Test-Path $pubFile)) {
        Write-Host "ERROR: Key generation failed."
        exit 1
    }
    Write-Host "Key created."
} else {
    Write-Host "Using existing key: $pubFile"
}

# 3. Install public key on VPS (you type password ONCE here)
Write-Host ""
Write-Host "You will be asked for the VPS root password ONCE. After this, you will never type it again."
Write-Host ""
Get-Content $pubFile | ssh $VPS "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Install failed. Check the password and try again."
    exit 1
}

# 4. Test passwordless access
Write-Host "Testing passwordless access..."
$test = ssh -o BatchMode=yes -o ConnectTimeout=5 $VPS "echo OK" 2>&1
if ($test -eq "OK") {
    Write-Host "Single-sign is active. No password needed from now on."
} else {
    Write-Host "Warning: Test did not return OK. Key may still work; try: ssh $VPS"
}

# 5. Add Host aman to SSH config (optional)
$configPath = Join-Path $sshDir "config"
$configBlock = @"

Host aman
    HostName 72.61.227.53
    User root
    IdentityFile ~/.ssh/id_ed25519
"@
if (Test-Path $configPath) {
    $content = Get-Content $configPath -Raw
    if ($content -notmatch "Host\s+aman\s") {
        Add-Content -Path $configPath -Value $configBlock
        Write-Host "Added 'aman' to SSH config. You can now use: ssh aman"
    }
} else {
    Set-Content -Path $configPath -Value $configBlock.Trim()
    Write-Host "Created SSH config. You can now use: ssh aman"
}

Write-Host ""
Write-Host "Done. From now on use: ssh aman  or  ssh root@72.61.227.53  (no password)."
