function ck { git checkout $args }
function rb { git rebase $args }
function or { git remote -v }
function cp { git cherry-pick $args }
function gitpush { param([string]$message) git add .; git commit -m "$message"; git push }
function gitpushf { param([string]$message) git add .; git commit -m "$message"; git push --force-with-lease }
function gitri { param([int]$number) git rebase -i HEAD~$number }

function openpfp {
    notepad "$PROFILE"
}
function pfp {
    . "$PROFILE"
    Write-Output "pfp applied"
}

# Create a new file with a default extension (cpp by default)
function mk {
    param (
        [string]$Name,
        [string]$Extension = "cpp",
        [string]$FolderPath = (Get-Location)
    )

    if ($Name -notmatch '\.\w+$') {
        $Name = "$Name.$Extension"
    }

    $FilePath = Join-Path -Path $FolderPath -ChildPath $Name
    if (Test-Path $FilePath) {
        Write-Host "File '$FilePath' already exists!" -ForegroundColor Yellow
    }
    else {
        New-Item -Path $FilePath -ItemType File -Force | Out-Null
        Write-Host "File '$FilePath' created successfully." -ForegroundColor Green
    }
}
