# Start local static preview of KITS College theme
# Run from repo root: .\start-local-preview.ps1
# Serves from repo root so local-preview/index.html can load ../wp-content/themes/kits-college/style.css

$RepoRoot = $PSScriptRoot
if (-not (Test-Path "$RepoRoot\local-preview\index.html")) {
    $RepoRoot = "D:\Work\AmanCollege"
}
Set-Location $RepoRoot

$Port = 5050
$PreviewUrl = "http://localhost:$Port/local-preview/"

Write-Host "Starting local preview server (repo root: $RepoRoot)"
Write-Host "Aman College preview: $PreviewUrl"
Write-Host "Press Ctrl+C to stop."
Write-Host ""

# Prefer npx serve; fallback to PHP built-in server (port 5050 to avoid conflict with other apps on 3000)
if (Get-Command npx -ErrorAction SilentlyContinue) {
    Start-Job -ScriptBlock { param($u) Start-Sleep -Seconds 5; Start-Process $u } -ArgumentList $PreviewUrl | Out-Null
    npx --yes serve . -l $Port
} elseif (Get-Command php -ErrorAction SilentlyContinue) {
    Write-Host "Using PHP built-in server."
    Start-Process $PreviewUrl
    php -S "localhost:$Port"
} else {
    Write-Host "Install Node (npx serve) or PHP, then run this script again."
    Write-Host "Or: python -m http.server $Port  then open $PreviewUrl"
}
