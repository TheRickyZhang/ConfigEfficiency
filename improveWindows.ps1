<#
.SYNOPSIS
  “Computer‑literate” Windows tweaks:
    • Auto‑start Chrome
    • Disable Search service
    • Turn off web results in Start menu
    • Hide taskbar Search box
    • Disable delete/extension‑change warnings
    • Always show file extensions
    • Disable balloon tips
    • Disable Start menu suggestions
    • Restart Explorer

.DESCRIPTION
  Run this under your user account. No Admin prompt needed except for Edge uninstall.
#>

Write-Host "IsAdmin: " `
  (([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
  ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))


# 1) Auto‑launch Chrome at login
$chrome = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
if (Test-Path $chrome) {
    New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run `
        -Name Chrome -Value "`"$chrome`"" -PropertyType String -Force | Out-Null
}

# 2) Disable Windows Search indexing service
if (Get-Service WSearch -ErrorAction SilentlyContinue) {
    Stop-Service   WSearch -ErrorAction SilentlyContinue
    Set-Service    WSearch -StartupType Disabled
}

# 3) Turn off Bing/web in Start Search
$sk = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search'
New-Item -Path $sk -Force | Out-Null
foreach ($name in 'BingSearchEnabled', 'AllowSearchToUseWeb', 'CortanaConsent') {
    New-ItemProperty -Path $sk -Name $name -PropertyType DWord -Value 0 -Force | Out-Null
}

# 4) Hide the taskbar Search box
$adv = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
New-Item -Path $adv -Force | Out-Null
New-ItemProperty -Path $adv -Name ShowSearch -PropertyType DWord -Value 0 -Force | Out-Null

# 5) Disable “Delete file?” confirmation
New-ItemProperty -Path $adv -Name ConfirmFileDelete   -PropertyType DWord -Value 0 -Force | Out-Null

# 6) Disable “Delete file?” confirmation
New-ItemProperty -Path $adv -Name ConfirmFileDelete   -PropertyType DWord -Value 0 -Force | Out-Null

# 7) Disable “Changing file extension?” warning
New-ItemProperty -Path $adv -Name WarnOnExtensionChange -PropertyType DWord -Value 0 -Force | Out-Null

# 8) Always show file extensions
New-ItemProperty -Path $adv -Name HideFileExt -PropertyType DWord -Value 0 -Force | Out-Null

# 9) Disable balloon tips
New-ItemProperty -Path $adv -Name EnableBalloonTips -PropertyType DWord -Value 0 -Force | Out-Null

# 10) Disable Start menu “app suggestions”
$cdm = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
New-Item -Path $cdm -Force | Out-Null
foreach ($n in 'SystemPaneSuggestionsEnabled', 'SubscribedContent-338388Enabled') {
    New-ItemProperty -Path $cdm -Name $n -PropertyType DWord -Value 0 -Force | Out-Null
}

# 11) Disable Telemetry / Diagnostic Data
$dc = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
New-Item -Path $dc -Force | Out-Null
New-ItemProperty -Path $dc -Name AllowTelemetry -PropertyType DWord -Value 0 -Force | Out-Null
foreach ($svc in 'DiagTrack', 'dmwappushsvc') {
    if (Get-Service $svc -ErrorAction SilentlyContinue) {
        Stop-Service   -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service    -Name $svc -StartupType Disabled
    }
}

# 12) Prevent Windows Update auto‑restart when users are logged in
$wu = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
New-Item -Path $wu -Force | Out-Null
New-ItemProperty -Path $wu -Name NoAutoRebootWithLoggedOnUsers `
    -PropertyType DWord -Value 1 -Force | Out-Null

# 13) Stop Microsoft Store app auto‑updates
$sp = 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore'
New-Item -Path $sp -Force | Out-Null
New-ItemProperty -Path $sp -Name AutoDownload `
    -PropertyType DWord -Value 2 -Force | Out-Null

# 14) Remove pre‑installed “bloatware” for all users
$patterns = 'Candy', 'Solitaire', 'Skype', 'Xbox', 'Microsoft3D', 'GetOffice', 'MixedReality'
Get-AppxPackage -AllUsers |
Where-Object { $patterns | ForEach-Object { $_ -and $_ -match $_ } } |
Remove-AppxPackage -ErrorAction SilentlyContinue

Get-AppxProvisionedPackage -Online |
Where-Object { $patterns | ForEach-Object { $_ -and $_ -match $_ } } |
Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue

# 15) Disable Lock Screen Spotlight & ads
$cc = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
New-Item -Path $cc -Force | Out-Null
New-ItemProperty -Path $cc -Name DisableWindowsSpotlight `
    -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $cc -Name DisableConsumerFeatures `
    -PropertyType DWord -Value 1 -Force | Out-Null

# 16) Prevent UWP apps from running in background
$ap = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy'
New-Item -Path $ap -Force | Out-Null
New-ItemProperty -Path $ap -Name LetAppsRunInBackground `
    -PropertyType DWord -Value 2 -Force | Out-Null

# 17) Disable UI animations (best performance) & transparency
# Visual Effects: 2 = Adjust for best performance
$vf = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects'
New-Item -Path $vf -Force | Out-Null
New-ItemProperty -Path $vf -Name VisualFXSetting `
    -PropertyType DWord -Value 2 -Force | Out-Null
# Transparency: 0 = Off
$tp = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
New-Item -Path $tp -Force | Out-Null
New-ItemProperty -Path $tp -Name EnableTransparency `
    -PropertyType DWord -Value 0 -Force | Out-Null

# 18) Disable UWP Live Tile suggestions
foreach ($n in 'SubscribedContent-338388Enabled', 'SystemPaneSuggestionsEnabled') {
    New-ItemProperty -Path $cdm -Name $n -PropertyType DWord -Value 0 -Force | Out-Null
}

# 19) Remove OneDrive from startup and uninstall it
Remove-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run `
    -Name OneDrive -ErrorAction SilentlyContinue
Start-Process -FilePath "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" `
    -ArgumentList '/uninstall' -NoNewWindow -Wait

# 20) Restart Explorer to apply changes immediately
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Host Windows successfully improved! Please see manual instructions.
