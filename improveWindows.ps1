<#
.SYNOPSIS
  Apply a set of “Chrome‑first, lean Windows” tweaks:
    • Auto‑start Chrome
    • Disable Search service
    • Turn off web results in Start menu
    • Hide the taskbar Search box
    • Restart Explorer to pick up changes

.DESCRIPTION
  Run this as your user (no admin prompt needed except for Edge removal).
#>

# 1) Auto‑launch Chrome at login via registry
$chromePath = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
if (Test-Path $chromePath) {
    New-ItemProperty `
        -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run `
        -Name Chrome `
        -Value "`"$chromePath`"" `
        -PropertyType String -Force
}

# 2) Disable Windows Search indexing service
if (Get-Service -Name WSearch -ErrorAction SilentlyContinue) {
    Stop-Service   -Name WSearch   -ErrorAction SilentlyContinue
    Set-Service    -Name WSearch   -StartupType Disabled
}

# 3) Turn off Bing/web results in Start Search
$searchKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search'
New-Item         -Path $searchKey -Force | Out-Null
New-ItemProperty -Path $searchKey -Name BingSearchEnabled   -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path $searchKey -Name AllowSearchToUseWeb -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path $searchKey -Name CortanaConsent      -Value 0 -PropertyType DWord -Force

# 4) Hide the taskbar Search box entirely
$advKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
New-Item         -Path $advKey -Force | Out-Null
New-ItemProperty -Path $advKey -Name ShowSearch -PropertyType DWord -Value 0 -Force

# 5) Restart Explorer so all changes take effect immediately
Stop-Process -Name explorer -Force
Start-Process explorer
