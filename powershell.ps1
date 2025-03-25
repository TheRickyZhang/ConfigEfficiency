# powershell.ps1
Set-Alias redis-cli "C:\Libraries\Redis\redis-cli.exe"
function run-redis {
    redis-cli.exe -h redis-13662.c13.us-east-1-3.ec2.cloud.redislabs.com -p 13662 -a y3fJt9kYkw5WVwDYMI8XPY4tXb6KF0pr
}

Set-Alias python3 python
function pfp { notepad $PROFILE }
function pfp. { . $PROFILE }

function Show-Path {
    $env:PATH -split ';' | ForEach-Object { $_ }
}

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

function ch { git checkout $args }
function rb { git rebase $args }
function or { git remote -v }
function cp { git cherry-pick $args }
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
