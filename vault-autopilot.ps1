$vault = "$env:USERPROFILE\ObsidianVault"

function Run-GitSync {
    Set-Location $vault
    git add .

    $changes = git status --porcelain
    if (-not $changes) { return }

    git commit -m "auto-sync $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    git push
}

function Clean-Inbox {

    $inbox = "$vault\Inbox"

    if (-Not (Test-Path $inbox)) {
        New-Item -ItemType Directory -Path $inbox | Out-Null
        Write-Host "Inbox creada automáticamente"
        return
    }

    Get-ChildItem $inbox -File | ForEach-Object {

        if ($_.Length -lt 5) {
            Remove-Item $_.FullName -Force
        }

    }
}

function Organize-Vault {
    # placeholder agente IA
    # acá luego entra Ollama
    Write-Host "IA organizando vault..."
}

while ($true) {

    Write-Host "=== VAULT AUTOPILOT RUN ==="

    Clean-Inbox
    Organize-Vault
    Run-GitSync

    Start-Sleep -Seconds 180
}

function vault {
    Set-Location "$env:USERPROFILE\ObsidianVault"
}

function rastro {
    Set-Location "$env:USERPROFILE\projects\Rastro"
}

function syncvault {
    vault
    git add .
    git commit -m "auto sync $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    git push
}