# PowerShell Configuration and Git Setup

## PowerShell Configuration

### Set PowerShell 7 as Default Terminal
1. Add an entry in `settings.json` of your terminal.
2. Set the default ID to PowerShell 7.

### Node.js Permissions Issue
- If encountering weird permissions issues with installing Node.js and related tools:
  - Check both `AppData/Roaming` and `Program Files` locations.
  - Manually copy or sync the files between these locations.

### PowerShell Profile ($PROFILE)
Add the following to your `$PROFILE`:

```powershell
$env:PATH = ($env:PATH -split ';' | Select-Object -Unique) -join ';'

function gitpush { param([string]$message) git add .; git commit -m "$message"; git push }
function gitpushf { param([string]$message) git add . git commit -m "$message" git push --force-with-lease }
function gitri { param([int]$number) git rebase -i HEAD~$number }

function openprofile { notepad "C:\PowerShell\profile.ps1" }

function mk {
    param (
        [string]$Name,                     # Name of the file (required)
        [string]$Extension = "cpp",        # Optional extension, defaults to "cpp"
        [string]$FolderPath = (Get-Location) # Optional folder path, defaults to current location
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
