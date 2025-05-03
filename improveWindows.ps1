<#
.SYNOPSIS
  Apply robust “computer-literate” Windows tweaks plus extras.
.DESCRIPTION
  Must be run As Administrator. Exits if not elevated.
#>

# 0) Elevation check
if (-not ([Security.Principal.WindowsPrincipal] `
            [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error 'Administrator rights required. Rerun as Admin.' 
    exit 1
}

# 1) Auto-start Chrome at login
$chrome = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
if (Test-Path $chrome) {
    New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run `
        -Name Chrome -Value "`"$chrome`"" -PropertyType String -Force | Out-Null
}

# 2) skip

# 3) Turn off Bing/web in Start Search
$sk = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search'
foreach ($name in 'BingSearchEnabled', 'AllowSearchToUseWeb', 'CortanaConsent') {
    New-ItemProperty -Path $sk -Name $name -PropertyType DWord -Value 0 -Force | Out-Null
}

# 4–8) Explorer “Advanced” tweaks
$adv = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
$props = @{
    ShowSearch            = 1  # show search box
    ConfirmFileDelete     = 0  # disable delete confirmation
    WarnOnExtensionChange = 0  # disable extension-change warning
    HideFileExt           = 0  # always show extensions
    EnableBalloonTips     = 0  # disable balloon tips
}
foreach ($k in $props.Keys) {
    New-ItemProperty -Path $adv -Name $k -PropertyType DWord -Value $props[$k] -Force | Out-Null
}

# 9) Disable Start-menu app suggestions
$cdm = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
foreach ($n in 'SystemPaneSuggestionsEnabled', 'SubscribedContent-338388Enabled') {
    New-ItemProperty -Path $cdm -Name $n -PropertyType DWord -Value 0 -Force | Out-Null
}

# 10) Disable Telemetry & related services
$dc = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
New-ItemProperty -Path $dc -Name AllowTelemetry -PropertyType DWord -Value 0 -Force | Out-Null
foreach ($svc in 'DiagTrack', 'dmwappushsvc') {
    if (Get-Service $svc -ErrorAction SilentlyContinue) {
        Stop-Service $svc -Force
        Set-Service  $svc -StartupType Disabled
    }
}

# 11) Prevent Windows Update auto-restart
$wu = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
New-ItemProperty -Path $wu -Name NoAutoRebootWithLoggedOnUsers -PropertyType DWord -Value 1 -Force | Out-Null

# 12) Disable Microsoft Store auto-updates
$sp = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore'
New-ItemProperty -Path $sp -Name AutoDownload -PropertyType DWord -Value 2 -Force | Out-Null

# 13) Remove these specific “bloatware” packages only
$families = @(
    'king.com.CandyCrushSaga',
    'king.com.CandyCrushSodaSaga',
    'king.com.CandyCrushFriends',
    'Microsoft.MicrosoftSolitaireCollection',
    'Microsoft.SkypeApp',
    'Microsoft.XboxApp',
    'Microsoft.XboxGamingOverlay',
    'Microsoft.XboxSpeechToTextOverlay'
)

foreach ($f in $families) {
    # Per‑user uninstall
    $inst = Get-AppxPackage -AllUsers |
    Where-Object { $_.PackageFamilyName -like "$f*" }
    if ($inst) {
        $inst | Remove-AppxPackage -ErrorAction SilentlyContinue
    }

    # Provisioned uninstall
    $prov = Get-AppxProvisionedPackage -Online |
    Where-Object { $_.PackageName -like "$f*" }
    if ($prov) {
        $prov | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    }
}


# 15) Disable Lock-Screen Spotlight & ads (ensure parent key exists)
$cc = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
if (-not (Test-Path $cc)) { New-Item -Path $cc -Force | Out-Null }
New-ItemProperty -Path $cc -Name DisableWindowsSpotlight -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $cc -Name DisableConsumerFeatures   -PropertyType DWord -Value 1 -Force | Out-Null

# 16) Prevent UWP apps running in background (ensure parent key)
$ap = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy'
if (-not (Test-Path $ap)) { New-Item -Path $ap -Force | Out-Null }
New-ItemProperty -Path $ap -Name LetAppsRunInBackground -PropertyType DWord -Value 2 -Force | Out-Null

# 17) Remove OneDrive from startup & uninstall it
Remove-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run `
    -Name OneDrive -ErrorAction SilentlyContinue

# Try the 64‑bit path first, then SysWOW64
$odPaths = @(
    "$env:SystemRoot\System32\OneDriveSetup.exe",
    "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
)
foreach ($od in $odPaths) {
    if (Test-Path $od) {
        Start-Process -FilePath $od -ArgumentList '/uninstall' -NoNewWindow -Wait
        break
    }
}

# 18) Restart Explorer once
Stop-Process -Name explorer -Force
Start-Process explorer.exe

Write-Host 'All tweaks applied — Explorer restarted once. No loops, no unintended removals.'
