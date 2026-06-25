function vault-sync {
    $path = "$env:USERPROFILE\ObsidianVault"

    Set-Location $path

    git add .

    $status = git status --porcelain

    if ($status) {
        git commit -m "vault sync $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        git push
        Write-Host "✔ Vault sincronizado"
    } else {
        Write-Host "✔ Sin cambios"
    }
}

function vault-status {
    Set-Location "$env:USERPROFILE\ObsidianVault"
    git status
}

function vault-open {
    Set-Location "$env:USERPROFILE\ObsidianVault"
}