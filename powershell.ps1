# powershell.ps1

Write-Host "Setting keyboard repeat settings..."
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed" -Value 31
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value 0
Write-Host "Keyboard settings updated."

Write-Host "Updating PowerShell profile..."
if (!(Test-Path -Path $PROFILE)) {
    New-Item -Type File -Path $PROFILE -Force | Out-Null
}

$profileContent = @'
$env:PATH = ($env:PATH -split ";" | Select-Object -Unique) -join ";"

function gitpush { param([string]$message) git add .; git commit -m "$message"; git push }
function gitpushf { param([string]$message) git add .; git commit -m "$message"; git push --force-with-lease }
function gitri { param([int]$number) git rebase -i HEAD~$number }

function openprofile { notepad "$PROFILE" }

function mk {
    param (
        [string]$Name,
        [string]$Extension = "cpp",
        [string]$FolderPath = (Get-Location)
    )
    $FileName = "$Name.$Extension"
    $FilePath = Join-Path -Path $FolderPath -ChildPath $FileName
    if (Test-Path $FilePath) {
        Write-Host "File '$FilePath' already exists!" -ForegroundColor Yellow
    } else {
        New-Item -Path $FilePath -ItemType File -Force | Out-Null
        Write-Host "File '$FilePath' created successfully." -ForegroundColor Green
    }
}
'@

Add-Content -Path $PROFILE -Value $profileContent
Write-Host "PowerShell profile updated. Please restart PowerShell to apply changes."
