Write-Host "Checking..."
Get-Process -Name "explorer"
Write-Host "Getting..."
$p = Get-Process -Name "explorer"
Write-Host "Stopping..."
Stop-Process -InputObject $p -Confirm -PassThru
Write-Host "Restarting (auto)..."
$p = Get-Process -Name "explorer"
Get-Process -Name "explorer"