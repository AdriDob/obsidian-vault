$vault = "$env:USERPROFILE\ObsidianVault"

while ($true) {
    Set-Location $vault

    git add .

    $status = git status --porcelain

    if ($status) {
        git commit -m "auto-sync $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        git push
        Write-Host "✔ Sync OK"
    }

    Start-Sleep -Seconds 120
}