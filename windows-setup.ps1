Write-Host "Running PowerShell configuration..."
& .\powershell.ps1
Start-Sleep -Seconds 5

Write-Host "Running Git configuration..."
& .\git.ps1
Start-Sleep -Seconds 5


Read-Host "Press Enter to exit..."
