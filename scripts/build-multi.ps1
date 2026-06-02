Param()

$root = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $root

$backup = Join-Path $root 'build-profile.backup.json5'
if (-not (Test-Path $backup)) {
    Copy-Item -Path (Join-Path $root 'build-profile.json5') -Destination $backup -ErrorAction SilentlyContinue
}

$profiles = @('phone','pad')
foreach ($p in $profiles) {
    $src = Join-Path $root "build-profile.$p.json5"
    if (-not (Test-Path $src)) {
        Write-Host "Profile file $src not found, skipping $p"
        continue
    }
    Copy-Item -Path $src -Destination (Join-Path $root 'build-profile.json5') -Force
    Write-Host "Switched to profile: $p"
    try {
        Write-Host "Attempting to run hvigor build for $p (if hvigor is in PATH)..."
        & hvigor || Write-Host "hvigor returned non-zero or not found. Please run hvigor from your environment or DevEco Studio."
    } catch {
        Write-Host "Failed to execute hvigor: $_"
    }
}

# restore original build-profile
if (Test-Path $backup) {
    Copy-Item -Path $backup -Destination (Join-Path $root 'build-profile.json5') -Force
    Write-Host 'Restored original build-profile.json5'
}
