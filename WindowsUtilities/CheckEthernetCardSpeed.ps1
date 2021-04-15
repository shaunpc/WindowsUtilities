<# :
:: Check Ethernet Card Speed - 
:: 
#>

$card = 'Killer E2400 Gigabit Ethernet Controller'

clear-host

while ($true) {
	Get-WmiObject -ComputerName 'XPS8930' -Class Win32_NetworkAdapter | Where-Object { $_.Name -eq $card } | select -ExpandProperty Speed -outvariable speed |  Out-Null
	$a = (Get-Host).UI.RawUI
	if  ($speed -eq 1000000000)
	{
		$a.BackgroundColor = "green"
		$a.ForegroundColor = "white"
	}
	else 
	{
		$a.BackgroundColor = "red"
		$a.ForegroundColor = "white"
	}
	write-host "$PID / CARD:$card / Speed:$speed"
	Start-Sleep -Seconds 1
}

$a.BackgroundColor = "black"
$a.ForegroundColor = "white"
write-host "FINISHED"
